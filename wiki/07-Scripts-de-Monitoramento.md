# Scripts de Monitoramento

## Scripts disponíveis

- `scripts/check_node.sh`
  - Verifica saúde geral: API do Ollama, modelos e status de GPU.

- `scripts/check_gpu.sh`
  - Exibe diagnóstico detalhado da NVIDIA L4.

- `scripts/list_models.sh`
  - Lista modelos via endpoint `/api/tags` com formatação amigável.

## Exemplos de uso

```bash
bash scripts/check_node.sh
bash scripts/check_node.sh --host 10.94.80.13 --port 11434

bash scripts/check_gpu.sh

bash scripts/list_models.sh
bash scripts/list_models.sh --host 10.94.80.13 --port 11434
```

## Dependências

- `bash`
- `curl`
- `python3` (para parsing JSON com saída melhor)
- `nvidia-smi` (no host do nó)
