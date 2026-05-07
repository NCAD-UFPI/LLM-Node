# Limites e Recomendacoes

## Recomendacoes para clientes

- Definir timeout por request.
- Implementar retry com backoff exponencial.
- Logar prompt, modelo, latencia e status HTTP.
- Evitar burst alto sem controle de concorrencia.

## Quando abrir suporte interno

- Falha recorrente de conexao
- Erro 500 frequente
- Degradacao grande de latencia
- Modelo sumiu de `/api/tags`
