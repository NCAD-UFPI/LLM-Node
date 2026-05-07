# Inventário do Nó

## Identificação

- Hostname: `llmnode01.ncad.ufpi.br`
- IP: `10.94.80.13`
- SO: Ubuntu 24.04.2 LTS
- Kernel: `6.8.0-101-generic`
- Virtualização: QEMU

## CPU e Memória

- CPU: Intel Xeon Gold 6526Y
- vCPUs: 12 (2 sockets x 6 cores)
- RAM: 30 GiB

## GPU

- Modelo: NVIDIA L4
- VRAM detectada: ~23 GiB
- Driver em uso: 580.126.09
- CUDA reportada por `nvidia-smi`: 13.0

## Disco e Montagens

- Partição raiz: LVM ext4 em `/` (~58G)
- Montagem NFS usuários: `10.94.80.30:/data/cluster/users` em `/data`
- Montagem NFS LLM: `10.94.80.30:/data/cluster/users/llm_storage` em `/opt/llm`

## Estado Coletado

- Reboot pendente no host.
- Atualizações de sistema pendentes no momento da coleta.
