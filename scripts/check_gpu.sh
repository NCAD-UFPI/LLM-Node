#!/usr/bin/env bash
# check_gpu.sh – Exibe informações detalhadas da GPU NVIDIA L4 do nó
# Nó: 10.94.80.13 | Cluster TechNE – UFPI
# Uso: bash scripts/check_gpu.sh

set -euo pipefail

echo "======================================================"
echo "  Situação da GPU – NVIDIA L4"
echo "  Nó: 10.94.80.13 | TechNE – UFPI"
echo "  Data: $(date '+%Y-%m-%d %H:%M:%S')"
echo "======================================================"
echo ""

if ! command -v nvidia-smi &>/dev/null; then
  echo "ERRO: nvidia-smi não encontrado."
  echo "Este script deve ser executado diretamente no nó (10.94.80.13)."
  exit 1
fi

# ── Informações gerais ────────────────────────────────────
echo "[ Informações Gerais ]"
nvidia-smi --query-gpu=index,name,uuid,driver_version,vbios_version,pci.bus_id \
  --format=csv,noheader | \
awk -F',' '{
    printf "  Índice       : %s\n", $1
    printf "  Modelo       : %s\n", $2
    printf "  UUID         : %s\n", $3
    printf "  Driver       : %s\n", $4
    printf "  VBIOS        : %s\n", $5
    printf "  PCI Bus      : %s\n", $6
  }'
echo ""

# ── Utilização e temperatura ──────────────────────────────
echo "[ Utilização ]"
nvidia-smi --query-gpu=temperature.gpu,fan.speed,power.draw,power.limit,utilization.gpu,utilization.memory,memory.used,memory.free,memory.total \
  --format=csv,noheader,nounits | \
awk -F',' '{
    printf "  Temperatura       : %s °C\n", $1
    printf "  Ventoinhas        : %s %%\n", $2
    printf "  Potência atual    : %s W\n", $3
    printf "  Limite de potência: %s W\n", $4
    printf "  Uso GPU           : %s %%\n", $5
    printf "  Uso Memória       : %s %%\n", $6
    printf "  VRAM usada        : %s MiB\n", $7
    printf "  VRAM livre        : %s MiB\n", $8
    printf "  VRAM total        : %s MiB\n", $9
  }'
echo ""

# ── Processos usando a GPU ────────────────────────────────
echo "[ Processos na GPU ]"
PROCS=$(nvidia-smi --query-compute-apps=pid,used_memory,name --format=csv,noheader 2>/dev/null || true)
if [[ -z "$PROCS" ]]; then
  echo "  Nenhum processo ativo na GPU."
else
  echo "  PID       Memória    Processo"
  echo "  --------- ---------- --------------------------------"
  echo "$PROCS" | awk -F',' '{printf "  %-9s %-10s %s\n", $1, $2, $3}'
fi
echo ""

# ── Saída completa do nvidia-smi ──────────────────────────
echo "[ Saída Completa do nvidia-smi ]"
nvidia-smi
