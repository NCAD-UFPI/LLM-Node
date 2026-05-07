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

## 🔐 Acesso ao Nó via SSH

Este documento descreve como realizar a conexão segura ao `LLMNode01` para operações de terminal e administração.

### 📍 Endereço de Conexão

- **IP:** `10.94.80.13`
- **Hostname:** `llmnode01.ncad.ufpi.br`

### 📡 Requisitos de Rede

Para que a conexão seja estabelecida, o dispositivo deve estar em um dos seguintes estados:

1. Conectado via cabo ou Wi‑Fi à Rede Institucional da UFPI.
2. Com o túnel da VPN Institucional ativo para acesso externo.

### ⌨️ Comandos de Acesso

Utilize o nome de utilizador fornecido pelo NCAD/FreeIPA.

```bash
# Formato padrão
ssh <seu_usuario>@10.94.80.13
```

#### Exemplo

```bash
ssh aluno_cielio@10.94.80.13
```

### 📌 Notas Importantes

#### Credenciais
O acesso utiliza a palavra‑passe centralizada do FreeIPA.

#### Primeiro Acesso
Se for o primeiro acesso, o sistema poderá solicitar confirmação da chave RSA do host.

Digite:

```bash
yes
```

#### Diretório Inicial
Ao entrar no sistema, o utilizador iniciará no diretório:

```bash
/<nome_usuario>/home/
```

Com cota aproximada de **40GB**.

---

## 📊 Monitoramento e Manutenção do Nó

Para garantir a estabilidade do `LLMNode01`, existem scripts de verificação automática para monitoramento da GPU e do serviço de inferência. Porque servidores têm a delicadeza emocional de uma torradeira industrial.

### 📜 Scripts de Diagnóstico

Os scripts encontram-se no diretório [`scripts/`](../scripts/) e devem ser executados via SSH no nó.

#### 🔎 `check_node.sh`

Valida:

- Conectividade básica
- Resposta do binário do Ollama

#### 🎮 `check_gpu.sh`

Monitoriza a saúde da GPU NVIDIA L4:

- Temperatura (ideal abaixo de 75°C)
- Consumo de VRAM (limite de 24GB)
- Utilização SM da GPU (proxy operacional para carga tensorial)

#### 📚 `list_models.sh`

Executa uma query interna na API do Ollama e apresenta os modelos disponíveis em formato legível.

---

## Histórico de Modelos

| Data (aprox.) | Evento                                                        |
|---------------|---------------------------------------------------------------|
| Início        | Projeto iniciado com **Phi3-Mini** (Microsoft)                |
| Atual         | Frota principal migrada para **Gemma 3 27B** e **Gemma 2 27B**|

---

## 🛠️ Procedimento de Atualização

### 1. Aceder ao nó via SSH

```bash
ssh <usuario>@10.94.80.13
```

### 2. Fazer download do novo modelo

```bash
ollama pull <nome:tag>
```

### 3. Verificar catálogo

```bash
ollama list
```
