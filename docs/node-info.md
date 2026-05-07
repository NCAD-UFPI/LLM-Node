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

## Motor de LLM

**Ollama** é o serviço utilizado para servir e gerenciar os modelos de linguagem neste nó.

- **Porta padrão:** `11434`
- **API base:** `http://10.94.80.13:11434`
- **Documentação:** https://github.com/ollama/ollama

### Endpoints Principais

| Endpoint                                      | Descrição                        |
|-----------------------------------------------|----------------------------------|
| `GET  /api/version`                           | Versão do Ollama                 |
| `GET  /api/tags`                              | Lista modelos disponíveis        |
| `POST /api/generate`                          | Geração de texto                 |
| `POST /api/chat`                              | Chat multi-turno                 |
| `POST /api/pull`                              | Baixar novo modelo               |
| `DELETE /api/delete`                          | Remover modelo                   |

---

## Modelos Disponíveis

O `LLMNode01` está focado na execução de modelos da família **Gemma (Google DeepMind)** otimizados para GPU NVIDIA L4.

| Modelo | Tag Ollama | Parâmetros | Tamanho | Uso recomendado |
|---|---|---|---|---|
| Gemma 4 (High) | `gemma4:31b` | 31.3B | ~19 GB | Raciocínio complexo e lógica |
| Gemma 4 (Base) | `gemma4:latest` | 8.0B | ~9.6 GB | Chats rápidos e tarefas gerais |
| Gemma 3 | `gemma3:27b` | 27.4B | ~17 GB | Modelo principal para investigação |
| Gemma 2 | `gemma2:27b` | 27B | N/D | Versão estável anterior |

## Localização dos Modelos

Os artefatos dos modelos estão armazenados em:

```bash
/opt/llm/.ollama/models/blobs
```

## Modelos Descontinuados

### Phi-3 Mini (`phi3:mini`)
- **Situação:** ❌ Removido do catálogo ativo.
- **Motivo:** Considerado legado frente ao desempenho da linha Gemma 4.

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
| Atual         | Frota principal migrada para **Gemma 4 (31B/8B)** e **Gemma 3 27B** |

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
