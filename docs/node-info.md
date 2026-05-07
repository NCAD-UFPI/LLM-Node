# Informações do Nó Computacional – TechNE / UFPI

## Identificação

| Campo             | Valor                          |
|-------------------|--------------------------------|
| **IP**            | `10.94.80.13`                  |
| **Cluster**       | TechNE                         |
| **Instituição**   | UFPI (Universidade Federal do Piauí) |
| **Laboratório**   | NCAD                           |

---

## Hardware

### GPU

| Campo             | Valor          |
|-------------------|----------------|
| **Modelo**        | NVIDIA L4      |
| **Arquitetura**   | Ada Lovelace   |
| **Memória VRAM**  | 24 GB GDDR6    |
| **TDP**           | 72 W           |

A GPU NVIDIA L4 é otimizada para inferência de modelos de linguagem de grande porte (LLMs), com suporte a quantizações INT8 e FP16, possibilitando a execução eficiente de modelos de dezenas de bilhões de parâmetros.

---

## 🤖 Motor de Inferência: Ollama

O `Ollama` é o runtime utilizado no `LLMNode01` para gestão e execução de modelos de linguagem de grande porte (LLMs). Porque aparentemente humanos decidiram que conversar com máquinas era mais fácil do que documentação organizada.

### ⚙️ Informações do Serviço

- **Porta padrão:** `11434`
- **API Base:** `http://10.94.80.13:11434`
- **Gerenciamento:** `systemd`
- **Documentação:** https://github.com/ollama/ollama

### 📡 Endpoints da API

| Método | Endpoint | Função |
|---|---|---|
| GET | `/api/tags` | Lista modelos carregados |
| POST | `/api/generate` | Geração de texto |
| POST | `/api/chat` | Chat multi-turno |
| GET | `/api/version` | Retorna versão do Ollama |

### 🛠️ Comandos de Diagnóstico

Verificar modelos carregados na VRAM:

```bash
ollama ps
```

Listar modelos disponíveis:

```bash
ollama list
```

Ver logs em tempo real:

```bash
journalctl -u ollama -f
```

### 📌 Nota Técnica

O serviço `vllm` anteriormente utilizado foi descontinuado em favor da estabilidade do `Ollama` na arquitetura NVIDIA L4.

---

## Modelos Disponíveis

### Gemma 3 – 27B  (`gemma3:27b`)
- **Provedor:** Google DeepMind
- **Parâmetros:** 27 bilhões
- **Situação:** ✅ Ativo (modelo principal)

### Gemma 2 – 27B  (`gemma2:27b`)
- **Provedor:** Google DeepMind
- **Parâmetros:** 27 bilhões
- **Situação:** ✅ Ativo

### Phi-3 Mini  (`phi3:mini`)  _(Legado)_
- **Provedor:** Microsoft
- **Parâmetros:** ~3.8 bilhões
- **Situação:** 🗂️ Legado – foi o modelo usado para inicializar o projeto
- **Referência:** https://azure.microsoft.com/en-us/blog/introducing-phi-3/

---

## Acesso ao Nó

> ⚠️ É necessário estar conectado à **rede da UFPI** para acessar o cluster TechNE.

```bash
# Acesso SSH ao nó
ssh usuario@10.94.80.13

# Verificar versão do Ollama via API
curl http://10.94.80.13:11434/api/version

# Listar modelos disponíveis
curl http://10.94.80.13:11434/api/tags
```

---

## Scripts de Monitoramento

Os scripts disponíveis em [`scripts/`](../scripts/) automatizam as verificações mais comuns:

| Script               | Descrição                                      |
|----------------------|------------------------------------------------|
| `check_node.sh`      | Situação geral do nó (Ollama + GPU)            |
| `check_gpu.sh`       | Informações detalhadas da GPU NVIDIA L4        |
| `list_models.sh`     | Modelos carregados no Ollama                   |

---

## Histórico de Modelos

| Data (aprox.) | Evento                                                        |
|---------------|---------------------------------------------------------------|
| Início        | Projeto iniciado com **Phi3-Mini** (Microsoft)                |
| Atual         | Frota principal migrada para **Gemma 3 27B** e **Gemma 2 27B**|

---

## Manutenção

Para adicionar novos modelos ao nó:

```bash
# Conectado ao nó via SSH
ollama pull <nome-do-modelo>

# Exemplo
ollama pull gemma3:27b
```

Para verificar o status do serviço Ollama:

```bash
systemctl status ollama
# ou
ollama ps
```
