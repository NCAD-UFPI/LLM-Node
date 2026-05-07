# Boas Praticas de Uso

## Prompt

- Seja especifico no objetivo.
- Defina formato de saida (lista, JSON, resumo, etc).
- Limite tamanho quando precisar resposta curta.

## Performance

- Evite prompt longo sem necessidade.
- Reaproveite contexto so quando realmente util.
- Para carga alta, use filas no seu sistema cliente.

## Confiabilidade

- Sempre valide a saida antes de usar em automacoes criticas.
- Implemente retry com backoff no cliente.
- Registre latencia e taxa de erro da sua aplicacao.
