# LLM-Node

Repositório de referência para uso dos modelos de linguagem hospedados no nó computacional de LLM do cluster TechNE/UFPI.

## Objetivo

Este projeto existe para facilitar a vida de quem vai consumir os modelos no nó `llmnode01`.
Aqui você encontra como acessar, quais modelos estão disponíveis, como testar a API e onde consultar a documentação operacional.

## Acesso ao nó

- Host: `10.94.80.13`
- Hostname: `llmnode01.ncad.ufpi.br`
- Runtime de inferência: `Ollama`
- Porta da API: `11434`

Acesso SSH (rede autorizada):

```bash
ssh <usuario>@10.94.80.13
```

## Endpoint da API

Base URL:

```text
http://10.94.80.13:11434
```

Checagens rápidas:

```bash
curl -s http://10.94.80.13:11434/api/version
curl -s http://10.94.80.13:11434/api/tags
```

## Modelos atualmente disponíveis

- `gemma4:latest` (8B, Q4_K_M)
- `gemma4:31b` (31B, Q4_K_M)
- `gemma4:e4b` (8B, Q4_K_M)
- `gemma3:27b` (27B, Q4_K_M)

Observação: o catálogo pode mudar ao longo do tempo. Sempre valide via `/api/tags` antes de integrar em produção.

## Exemplo de uso (geração)

```bash
curl -s http://10.94.80.13:11434/api/generate \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gemma4:latest",
    "prompt": "Explique em 3 topicos o que e computacao de alto desempenho.",
    "stream": false
  }'
```

## Exemplo de uso (chat)

```bash
curl -s http://10.94.80.13:11434/api/chat \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gemma4:latest",
    "messages": [
      {"role":"user","content":"Resuma o objetivo do cluster TechNE em 2 frases."}
    ],
    "stream": false
  }'
```

## Diagnóstico rápido

Scripts úteis do repositório:

```bash
bash scripts/check_node.sh
bash scripts/list_models.sh
bash scripts/check_gpu.sh
```

## Wiki (foco principal)

Toda a documentação de uso está organizada na pasta `wiki/` para publicação nas abas da Wiki do GitHub:

- `wiki/01-Visao-Geral.md`
- `wiki/02-Primeiros-Passos.md`
- `wiki/03-Como-Chamar-a-API.md`
- `wiki/04-Modelos-Disponiveis.md`
- `wiki/05-Boas-Praticas-de-Uso.md`
- `wiki/06-Exemplos-de-Integracao.md`
- `wiki/07-FAQ.md`
- `wiki/08-Erros-Comuns.md`
- `wiki/09-Limites-e-Recomendacoes.md`
- `wiki/10-Guia-Rapido.md`

## Estrutura atual do repositório

```text
LLM-Node/
├── config/
├── scripts/
├── wiki/
└── README.md
```
