#!/usr/bin/env bash
# check_node.sh – Verifica conectividade básica e resposta do Ollama
# Nó: 10.94.80.13 | Cluster TechNE – UFPI
# Uso: bash scripts/check_node.sh [--host <ip>]

set -euo pipefail

HOST="${OLLAMA_HOST:-10.94.80.13}"
PORT="${OLLAMA_PORT:-11434}"

# Permite sobrescrever o endereço do nó via argumento
while [[ $# -gt 0 ]]; do
  case "$1" in
    --host) HOST="$2"; shift 2 ;;
    --port) PORT="$2"; shift 2 ;;
    *) echo "Uso: $0 [--host <ip>] [--port <porta>]"; exit 1 ;;
  esac
done

BASE_URL="http://${HOST}:${PORT}"

echo "======================================================"
echo "  Diagnóstico do Nó LLM – TechNE / UFPI"
echo "  Nó: ${HOST}:${PORT}"
echo "  Data: $(date '+%Y-%m-%d %H:%M:%S')"
echo "======================================================"
echo ""

# ── 1. Conectividade básica ───────────────────────────────
echo "[ Conectividade básica ]"
if ping -c 1 -W 2 "${HOST}" >/dev/null 2>&1; then
  echo "  Host ${HOST}: ✅ acessível via ICMP"
else
  echo "  Host ${HOST}: ❌ sem resposta de ping"
fi

if curl -sf --max-time 10 "${BASE_URL}/api/version" -o /tmp/ollama_version.json 2>/dev/null; then
  echo "  API Ollama (${BASE_URL}): ✅ respondendo"
else
  echo "  API Ollama (${BASE_URL}): ❌ indisponível"
fi
echo ""

# ── 2. Resposta do binário do Ollama ──────────────────────
echo "[ Binário Ollama ]"
if command -v ollama >/dev/null 2>&1; then
  if OLLAMA_VERSION="$(ollama --version 2>/dev/null | head -n 1)"; then
    echo "  Binário: ✅ disponível"
    echo "  Versão : ${OLLAMA_VERSION}"
  else
    echo "  Binário: ⚠️ encontrado, mas sem resposta válida"
  fi
else
  echo "  Binário: ❌ não encontrado no PATH"
fi
echo ""

echo "======================================================"
echo "  Fim do relatório"
echo "======================================================"
