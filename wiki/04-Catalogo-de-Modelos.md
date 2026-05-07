# Catálogo de Modelos

Modelos detectados via `ollama list` e `GET /api/tags`.

## Modelos ativos

- `gemma4:latest`
  - Família: gemma4
  - Parâmetros: 8.0B
  - Quantização: Q4_K_M
  - Tamanho: ~9.6 GB

- `gemma4:31b`
  - Família: gemma4
  - Parâmetros: 31.3B
  - Quantização: Q4_K_M
  - Tamanho: ~19 GB

- `gemma4:e4b`
  - Família: gemma4
  - Parâmetros: 8.0B
  - Quantização: Q4_K_M
  - Tamanho: ~9.6 GB

- `gemma3:27b`
  - Família: gemma3
  - Parâmetros: 27.4B
  - Quantização: Q4_K_M
  - Tamanho: ~17 GB

## Histórico conhecido

- O projeto já utilizou `phi3:mini` como modelo inicial (legado).
- O inventário atual mostra foco nas famílias `gemma3/gemma4`.

## Comandos úteis

```bash
ollama list
curl -s http://10.94.80.13:11434/api/tags
```
