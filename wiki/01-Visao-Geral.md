# Visão Geral

Este repositório documenta o nó de LLM do cluster TechNE/UFPI, incluindo inventário técnico, runtime de inferência, catálogo de modelos e procedimentos operacionais.

## Objetivos

- Centralizar informações técnicas do nó.
- Facilitar operação diária e troubleshooting.
- Manter histórico de mudanças de modelos e infraestrutura.
- Padronizar scripts de validação e monitoramento.

## Escopo

- Nó principal: `llmnode01.ncad.ufpi.br` (`10.94.80.13`)
- Runtime principal: `Ollama`
- GPU principal: `NVIDIA L4`
- Armazenamento de modelos: `/opt/llm/.ollama/models`

## Organização sugerida da Wiki

- 01 Visão Geral
- 02 Inventário do Nó
- 03 Runtime e Serviços
- 04 Catálogo de Modelos
- 05 Armazenamento e Artefatos
- 06 Operação do Dia a Dia
- 07 Scripts de Monitoramento
- 08 Troubleshooting
- 09 Segurança e Acesso
- 10 Roadmap

## Fonte de Verdade

- Inventário técnico consolidado: `README.md`
- Metadados de modelos: `config/models.json`
- Endpoints do Ollama: `config/ollama.json`
- Documentação complementar: `docs/node-info.md`
- Scripts operacionais: `scripts/*.sh`
