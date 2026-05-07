# Como Chamar a API

## Endpoint de geracao

`POST /api/generate`

Exemplo:

```bash
curl -s http://10.94.80.13:11434/api/generate \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gemma4:latest",
    "prompt": "Resuma IA generativa em 3 linhas.",
    "stream": false
  }'
```

## Endpoint de chat

`POST /api/chat`

Exemplo:

```bash
curl -s http://10.94.80.13:11434/api/chat \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gemma4:latest",
    "messages": [
      {"role":"user","content":"Crie um plano de estudo de NLP em 4 semanas."}
    ],
    "stream": false
  }'
```

## Dicas

- Comece com `stream: false` para debug facil.
- Use timeout maior para modelos grandes.
- Trate erro HTTP no cliente para retry.
