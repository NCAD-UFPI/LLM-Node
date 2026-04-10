#!/usr/bin/env bash
# list_models.sh – Lista os modelos disponíveis no Ollama do nó LLM
# Nó: 10.94.80.13 | Cluster TechNE – UFPI
# Uso: bash scripts/list_models.sh [--host <ip>]

set -euo pipefail

HOST="${OLLAMA_HOST:-10.94.80.13}"
PORT="${OLLAMA_PORT:-11434}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --host) HOST="$2"; shift 2 ;;
    --port) PORT="$2"; shift 2 ;;
    *) echo "Uso: $0 [--host <ip>] [--port <porta>]"; exit 1 ;;
  esac
done

BASE_URL="http://${HOST}:${PORT}"

echo "======================================================"
echo "  Modelos Ollama – TechNE / UFPI"
echo "  Nó: ${HOST}:${PORT}"
echo "  Data: $(date '+%Y-%m-%d %H:%M:%S')"
echo "======================================================"
echo ""

# Buscar versão do Ollama
echo "[ Versão do Ollama ]"
if curl -sf --max-time 10 "${BASE_URL}/api/version" -o /tmp/ollama_ver.json 2>/dev/null; then
  if command -v python3 &>/dev/null; then
    python3 -c "import json; d=json.load(open('/tmp/ollama_ver.json')); print('  Versão:', d.get('version','N/A'))"
  else
    echo "  $(cat /tmp/ollama_ver.json)"
  fi
else
  echo "  ❌ Ollama inacessível em ${BASE_URL}"
  echo "     Verifique se está conectado à rede da UFPI."
  exit 1
fi
echo ""

# Listar modelos
echo "[ Modelos Disponíveis ]"
if curl -sf --max-time 10 "${BASE_URL}/api/tags" -o /tmp/ollama_models.json 2>/dev/null; then
  if command -v python3 &>/dev/null; then
    python3 - <<'EOF'
import json

with open('/tmp/ollama_models.json') as f:
    data = json.load(f)

models = data.get('models', [])
if not models:
    print("  Nenhum modelo encontrado.")
else:
    header = f"  {'Nome':<30} {'Tamanho':>10}  {'Formato':<10}  {'Modificado'}"
    print(header)
    print("  " + "-" * (len(header) - 2))
    for m in models:
        name      = m.get('name', 'N/A')
        size_gb   = m.get('size', 0) / (1024 ** 3)
        fmt       = m.get('details', {}).get('format', 'N/A')
        modified  = m.get('modified_at', 'N/A')[:10]
        print(f"  {name:<30} {size_gb:>9.1f}G  {fmt:<10}  {modified}")
    print()
    print(f"  Total: {len(models)} modelo(s)")
EOF
  else
    echo "  (python3 não disponível – exibindo JSON bruto)"
    cat /tmp/ollama_models.json
  fi
else
  echo "  ⚠️  Não foi possível obter a lista de modelos."
  exit 1
fi
echo ""

echo "======================================================"
echo "  Fim da listagem"
echo "======================================================"
