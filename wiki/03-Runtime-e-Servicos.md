# Runtime e Serviços

## Runtime principal

- Engine: `Ollama`
- Porta: `11434`
- Endpoint base: `http://10.94.80.13:11434`

## Endpoints principais

- `GET /api/version`: versão do serviço.
- `GET /api/tags`: lista de modelos disponíveis.
- `POST /api/generate`: geração de texto.
- `POST /api/chat`: chat multi-turno.

## Serviços observados

- `ollama.service`: ativo e em execução.
- `vllm.service`: falho (`status=203/EXEC`).

## Verificações rápidas

```bash
curl -s http://10.94.80.13:11434/api/version
curl -s http://10.94.80.13:11434/api/tags
systemctl status ollama
systemctl status vllm
```
