#!/usr/bin/env bash
# check_node.sh – Verifica o status geral do nó LLM (Ollama + GPU)
# Nó: 10.94.80.13 | Cluster TechNE – UFPI
# Uso: bash scripts/check_node.sh [--host <ip>]

set -euo pipefail

HOST="${OLLAMA_HOST:-10.94.80.13}"
PORT="${OLLAMA_PORT:-11434}"

# Allow overriding host via argument
while [[ $# -gt 0 ]]; do
  case "$1" in
    --host) HOST="$2"; shift 2 ;;
    --port) PORT="$2"; shift 2 ;;
    *) echo "Uso: $0 [--host <ip>] [--port <porta>]"; exit 1 ;;
  esac
done

BASE_URL="http://${HOST}:${PORT}"

echo "======================================================"
echo "  Monitor do Nó LLM – TechNE / UFPI"
echo "  Nó: ${HOST}:${PORT}"
echo "  Data: $(date '+%Y-%m-%d %H:%M:%S')"
echo "======================================================"
echo ""

# ── 1. Ollama – versão ────────────────────────────────────
echo "[ Ollama ]"
if curl -sf --max-time 10 "${BASE_URL}/api/version" -o /tmp/ollama_version.json 2>/dev/null; then
  VERSION=$(python3 -c "import json,sys; d=json.load(open('/tmp/ollama_version.json')); print(d.get('version','N/A'))" 2>/dev/null || cat /tmp/ollama_version.json)
  echo "  Status  : ✅ Online"
  echo "  Versão  : ${VERSION}"
else
  echo "  Status  : ❌ Offline ou inacessível (verifique conexão com a rede UFPI)"
fi
echo ""

# ── 2. Modelos carregados ─────────────────────────────────
echo "[ Modelos disponíveis ]"
if curl -sf --max-time 10 "${BASE_URL}/api/tags" -o /tmp/ollama_tags.json 2>/dev/null; then
  if command -v python3 &>/dev/null; then
    python3 - <<'EOF'
import json, sys

with open('/tmp/ollama_tags.json') as f:
    data = json.load(f)

models = data.get('models', [])
if not models:
    print("  Nenhum modelo encontrado.")
else:
    for m in models:
        name = m.get('name', 'N/A')
        size_bytes = m.get('size', 0)
        size_gb = size_bytes / (1024 ** 3)
        modified = m.get('modified_at', 'N/A')[:10]
        print(f"  • {name:<25} {size_gb:>6.1f} GB  (atualizado: {modified})")
EOF
  else
    echo "  (python3 não disponível – exibindo JSON bruto)"
    cat /tmp/ollama_tags.json
  fi
else
  echo "  ⚠️  Não foi possível obter a lista de modelos."
fi
echo ""

# ── 3. GPU ────────────────────────────────────────────────
echo "[ GPU ]"
if command -v nvidia-smi &>/dev/null; then
  nvidia-smi \
    --query-gpu=name,driver_version,temperature.gpu,utilization.gpu,utilization.memory,memory.used,memory.total \
    --format=csv,noheader,nounits \
  | awk -F',' '{
      printf "  Modelo       : %s\n", $1
      printf "  Driver       : %s\n", $2
      printf "  Temperatura  : %s °C\n", $3
      printf "  Uso GPU      : %s %%\n", $4
      printf "  Uso Memória  : %s %%\n", $5
      printf "  VRAM usada   : %s / %s MiB\n", $6, $7
    }'
else
  echo "  ⚠️  nvidia-smi não encontrado. Execute este script diretamente no nó."
fi
echo ""

echo "======================================================"
echo "  Fim do relatório"
echo "======================================================"
