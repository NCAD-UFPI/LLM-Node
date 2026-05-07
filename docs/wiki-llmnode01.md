# 📖 Wiki: Nó de LLM (LLMNode01)

Este tutorial inicial da wiki é voltado para usuários do nó computacional de IA generativa do NCAD/UFPI.

## 🛠️ Especificações de Infraestrutura

| Componente | Detalhe Técnico |
| :--- | :--- |
| **Hostname** | `llmnode01.ncad.ufpi.br` |
| **IP Estático** | `10.94.80.13` |
| **SO / Kernel** | Ubuntu 24.04.2 LTS / Kernel 6.8.0 |
| **Runtime Único** | **Ollama** (vLLM descontinuado neste nó) |
| **GPU** | NVIDIA L4 (24 GB VRAM Ada Lovelace) |
| **Recursos CPU** | 12 vCPUs (Intel Xeon Gold 6526Y) |
| **Memória RAM** | 30 GiB |

### Gestão de Armazenamento (NFS)

- **Armazenamento de modelos:** `/opt/llm/.ollama/models` (NFS: `10.94.80.30:/data/cluster/users/llm_storage`)
- **Dados de usuários:** diretórios home montados em `/data`

## 🤖 Catálogo de Modelos (Foco: Gemma)

| Modelo | Tag Ollama | Parâmetros | Tamanho em Disco |
| :--- | :--- | :--- | :--- |
| **Gemma 4 (High)** | `gemma4:31b` | 31.3B | ~19 GB |
| **Gemma 4 (Base)** | `gemma4:latest` | 8.0B | ~9.6 GB |
| **Gemma 3** | `gemma3:27b` | 27.4B | ~17 GB |

## 🚀 Guia de Operação e Uso

> ⚠️ O acesso ao nó exige conexão prévia à rede interna da UFPI ou VPN institucional.

### 1) Utilização via API (Integração)

O serviço Ollama escuta na porta **11434**.

- **Listar modelos ativos**

```bash
curl http://10.94.80.13:11434/api/tags
```

- **Exemplo de prompt (chat)**

```bash
curl http://10.94.80.13:11434/api/chat -d '{
  "model": "gemma4:latest",
  "messages": [{ "role": "user", "content": "Olá, Gemma!" }],
  "stream": false
}'
```

### 2) Acesso direto via SSH

1. Conecte ao nó: `ssh usuario@10.94.80.13`
2. Inicie o modelo desejado: `ollama run gemma4:31b`
3. Verifique o que está carregado na GPU: `ollama ps`

## 📈 Scripts de Monitoramento

Utilize os scripts homologados na pasta [`scripts/`](../scripts/):

- `check_node.sh`: valida o estado do serviço Ollama
- `check_gpu.sh`: monitora temperatura e consumo de VRAM da NVIDIA L4
- `list_models.sh`: exibe o catálogo atual de modelos via endpoint local

## 🔧 Manutenção para Administradores

- **Verificar status:** `systemctl status ollama`
- **Atualizar/baixar modelos:** `ollama pull <nome:tag>`
- **Localização de blobs:** `/opt/llm/.ollama/models/blobs`

## 🔐 Autenticação e Acesso (evolução planejada)

Este tutorial cobre o cenário atual de acesso à rede e uso do nó.
Os próximos métodos de acesso e autenticação integrada via **FreeIPA** serão adicionados na wiki em etapa posterior.
