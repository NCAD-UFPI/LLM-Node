# Roadmap

## Curto prazo

- Consolidar inventário técnico em `docs/node-info.md`.
- Atualizar `config/models.json` para refletir modelo real em produção.
- Criar runbook de correção do `vllm.service`.

## Médio prazo

- Automatizar coleta periódica de inventário (CPU/RAM/GPU/modelos).
- Padronizar relatório de capacidade e consumo de VRAM por modelo.
- Definir política de ciclo de vida de modelos (ativo, legado, descontinuado).

## Longo prazo

- Criar baseline de observabilidade (métricas, alertas e eventos).
- Integrar histórico de mudanças com gestão de incidentes.
- Definir estratégia de alta disponibilidade para inferência.
