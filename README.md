# LLM-Node

Repositório para mapeamento, operação e manutenção do nó de LLM do cluster TechNE/UFPI.

## Plano de Trabalho

1. Mapear o estado atual do nó (SO, CPU, RAM, disco, GPU, runtime de LLM).
2. Identificar modelos disponíveis e localização física dos artefatos.
3. Registrar inventário técnico no repositório (README + docs/config/scripts).
4. Versionar arquivos críticos para facilitar auditoria e operação.
5. Evoluir para baseline operacional (healthchecks, playbooks e rotina de atualização).

## Inventário Inicial do Nó (coletado em 23/04/2026)

### Identificação

- Hostname: `llmnode01.ncad.ufpi.br`
- IP: `10.94.80.13`
- SO: Ubuntu 24.04.2 LTS
- Kernel: `6.8.0-101-generic`
- Virtualização: QEMU

### Hardware

- CPU: `Intel Xeon Gold 6526Y`
- vCPUs: `12` (2 sockets x 6 cores, 1 thread/core)
- RAM total: `30 GiB`
- GPU: `NVIDIA L4 (23 GB VRAM)`
- Driver NVIDIA (em uso): `580.126.09`
- CUDA reportada no `nvidia-smi`: `13.0`

### Armazenamento e Montagens

- Disco do sistema: `/` em LVM ext4 (`58G`, ~`60%` usado)
- NFS usuários: `10.94.80.30:/data/cluster/users` montado em `/data`
- NFS LLM: `10.94.80.30:/data/cluster/users/llm_storage` montado em `/opt/llm`

### Runtime de LLM e Serviços

- Serviço `ollama`: `active (running)`
- Porta de inferência ativa: `11434/tcp`
- Serviço `vllm`: `failed` (status `203/EXEC`, falha antiga)

### Modelos Disponíveis no Ollama

Fonte: `ollama list` e endpoint local `http://127.0.0.1:11434/api/tags`

- `gemma4:31b` (31.3B, Q4_K_M, ~19 GB)
- `gemma4:latest` (8.0B, Q4_K_M, ~9.6 GB)
- `gemma3:27b` (27.4B, Q4_K_M, ~17 GB)
- `gemma2:27b` (27B, tamanho N/D no inventário, versão estável anterior)
- `phi3:mini` (descontinuado; removido do catálogo ativo)

### Localização dos Artefatos de Modelo

- Base Ollama: `/opt/llm/.ollama/models`
- Manifests:
  - `/opt/llm/.ollama/models/manifests/registry.ollama.ai/library/gemma3/27b`
  - `/opt/llm/.ollama/models/manifests/registry.ollama.ai/library/gemma4/e4b`
  - `/opt/llm/.ollama/models/manifests/registry.ollama.ai/library/gemma4/31b`
  - `/opt/llm/.ollama/models/manifests/registry.ollama.ai/library/gemma4/latest`
- Blobs: `/opt/llm/.ollama/models/blobs` (ocupação observada ~44 GB)

## Observações Operacionais

- O usuário possui sudo, mas no momento o `sudo` exige senha interativa.
- Há indicação de reboot pendente no host.
- Há 118 atualizações reportadas pelo sistema no momento do inventário.

## Arquivos Importantes para Versionar (próxima etapa)

- `docs/node-info.md`: ficha técnica consolidada do nó.
- `docs/services.md`: estado e troubleshooting de `ollama`/`vllm`.
- `config/models.json`: catálogo de modelos e metadados.
- `scripts/check_node.sh`: healthcheck geral.
- `scripts/list_models.sh`: listagem de modelos via API/local runtime.
- `scripts/check_gpu.sh`: validação rápida da GPU (`nvidia-smi`).

## Próximos Passos Imediatos

1. Versionar este inventário inicial no repositório `NCAD-UFPI/LLM-Node`.
2. Atualizar `docs/node-info.md` e `config/models.json` com os dados já coletados.
3. Ajustar/criar scripts de diagnóstico para repetir este mapeamento automaticamente.
4. Investigar e corrigir o `vllm.service` (erro `203/EXEC`).
