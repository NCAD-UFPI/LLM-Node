# LLM-Node

Repositório de monitoramento e manutenção do nó computacional de LLMs do cluster **TechNE** (UFPI).

> ⚠️ **Acesso restrito:** É necessário estar conectado à rede da UFPI para acessar o cluster TechNE.

---

## 🖥️ Informações do Nó

| Campo             | Valor                         |
|-------------------|-------------------------------|
| **IP**            | `10.94.80.13`                 |
| **Cluster**       | TechNE (UFPI)                 |
| **GPU**           | NVIDIA L4                     |
| **Motor de LLM**  | [Ollama](https://ollama.com/) |

---

## 🤖 Modelos Disponíveis

| Modelo         | Parâmetros | Situação            |
|----------------|------------|---------------------|
| `gemma3:27b`   | 27B        | ✅ Disponível       |
| `gemma2:27b`   | 27B        | ✅ Disponível       |
| `phi3:mini`    | ~3.8B      | 🗂️ Legado (inicial) |

> **Nota:** O projeto foi iniciado com o modelo **Phi3-Mini** da Microsoft. Atualmente a frota principal usa modelos da família Gemma.

---

## 📁 Estrutura do Repositório

```
LLM-Node/
├── config/
│   ├── ollama.json        # Configuração do motor Ollama
│   └── models.json        # Metadados dos modelos disponíveis
├── docs/
│   └── node-info.md       # Documentação detalhada do nó
├── scripts/
│   ├── check_node.sh      # Verifica status geral do nó (Ollama + GPU)
│   ├── check_gpu.sh       # Verifica status da GPU NVIDIA L4
│   └── list_models.sh     # Lista modelos disponíveis no Ollama
└── README.md
```

---

## 🚀 Uso Rápido

> Execute os scripts a partir de uma máquina conectada à rede da UFPI.

### Verificar status do nó
```bash
ssh usuario@10.94.80.13
bash scripts/check_node.sh
```

### Listar modelos disponíveis
```bash
bash scripts/list_models.sh
```

### Verificar GPU
```bash
bash scripts/check_gpu.sh
```

---

## 📖 Documentação

Consulte [`docs/node-info.md`](docs/node-info.md) para informações detalhadas sobre hardware, configurações e procedimentos de manutenção do nó.

---

## 🔗 Links Úteis

- [Ollama – Documentação Oficial](https://github.com/ollama/ollama)
- [Modelos Gemma – Google DeepMind](https://ai.google.dev/gemma)
- [Phi-3 Mini – Microsoft](https://azure.microsoft.com/en-us/blog/introducing-phi-3/)
- [NVIDIA L4 – Ficha Técnica](https://www.nvidia.com/en-us/data-center/l4/)
