# Primeiros Passos

## 1. Verifique acesso de rede

Voce precisa conseguir acessar `10.94.80.13` no seu ambiente.

## 2. Teste se o servico responde

```bash
curl -s http://10.94.80.13:11434/api/version
```

Se retornar JSON com versao, a API esta online.

## 3. Veja os modelos disponiveis

```bash
curl -s http://10.94.80.13:11434/api/tags
```

## 4. Faça sua primeira geracao

```bash
curl -s http://10.94.80.13:11434/api/generate \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gemma4:latest",
    "prompt": "Explique em 2 topicos o que e HPC.",
    "stream": false
  }'
```
