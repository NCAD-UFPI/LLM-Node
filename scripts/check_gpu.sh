#!/usr/bin/env bash
# check_gpu.sh – Monitoramento da saúde da GPU NVIDIA L4
# Nó: 10.94.80.13 | Cluster TechNE – UFPI
# Uso: bash scripts/check_gpu.sh

set -euo pipefail

TEMP_LIMIT_C=75
VRAM_LIMIT_GB=24

echo "======================================================"
echo "  Monitoramento da GPU – NVIDIA L4"
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
echo "[ Saúde da GPU ]"
GPU_STATS_RAW="$(nvidia-smi \
  --query-gpu=temperature.gpu,power.draw,power.limit,utilization.gpu,utilization.memory,memory.used,memory.total \
  --format=csv,noheader,nounits | head -n 1 || true)"

if [[ -z "${GPU_STATS_RAW}" ]]; then
  echo "  ❌ Não foi possível obter métricas da GPU via nvidia-smi."
  exit 1
fi

read -r TEMP POWER_DRAW POWER_LIMIT GPU_UTIL MEM_UTIL MEM_USED MEM_TOTAL <<<"$(echo "${GPU_STATS_RAW}" | tr ',' ' ' | xargs)"

if ! [[ "${TEMP}" =~ ^[0-9]+([.][0-9]+)?$ && "${MEM_USED}" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
  echo "  ❌ Métricas inválidas recebidas do nvidia-smi."
  exit 1
fi

TEMP_INT="${TEMP%.*}"
MEM_USED_INT="${MEM_USED%.*}"

TEMP_STATUS="✅"
if (( TEMP_INT >= TEMP_LIMIT_C )); then
  TEMP_STATUS="⚠️"
fi

VRAM_LIMIT_MIB=$((VRAM_LIMIT_GB * 1024))
VRAM_STATUS="✅"
if (( MEM_USED_INT >= VRAM_LIMIT_MIB )); then
  VRAM_STATUS="⚠️"
fi

printf "  Temperatura       : %s °C %s (ideal < %s °C)\n" "${TEMP}" "${TEMP_STATUS}" "${TEMP_LIMIT_C}"
printf "  Potência atual    : %s W\n" "${POWER_DRAW}"
printf "  Limite de potência: %s W\n" "${POWER_LIMIT}"
printf "  Uso GPU           : %s %%\n" "${GPU_UTIL}"
printf "  Uso Memória       : %s %%\n" "${MEM_UTIL}"
printf "  VRAM usada        : %s / %s MiB %s (limite: %s GB)\n" "${MEM_USED}" "${MEM_TOTAL}" "${VRAM_STATUS}" "${VRAM_LIMIT_GB}"

TENSOR_SM_UTIL="$(nvidia-smi dmon -s u -c 1 2>/dev/null | awk '
  /^# *gpu/ {
    for (i = 1; i <= NF; i++) {
      if ($i == "sm") {
        sm_col = i
        break
      }
    }
    next
  }
  $1 ~ /^[0-9]+$/ && sm_col {
    print $sm_col
    exit
  }
')"
if [[ "${TENSOR_SM_UTIL}" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
  printf "  Tensor Cores*     : %s %%\n" "${TENSOR_SM_UTIL}"
  echo "  *Métrica aproximada via utilização SM (nvidia-smi dmon)."
else
  echo "  Tensor Cores      : N/A (saída do nvidia-smi dmon não reconhecida)"
fi
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
