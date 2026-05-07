# Armazenamento e Artefatos

## Localização dos dados de modelo

- Base Ollama: `/opt/llm/.ollama/models`
- Manifests: `/opt/llm/.ollama/models/manifests`
- Blobs: `/opt/llm/.ollama/models/blobs`

## Manifests observados

- `.../library/gemma3/27b`
- `.../library/gemma4/e4b`
- `.../library/gemma4/31b`
- `.../library/gemma4/latest`

## Observações

- O volume de blobs observado foi de ~44 GB na coleta inicial.
- O armazenamento de modelos está sob `/opt/llm`, com origem NFS no cluster.

## Checklist de integridade

```bash
ls -lah /opt/llm/.ollama/models
find /opt/llm/.ollama/models/manifests -type f
du -sh /opt/llm/.ollama/models/blobs
```
