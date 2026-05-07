# Erros Comuns

## `connection refused`

A API nao esta acessivel no momento ou ha bloqueio de rede.

## `model not found`

O modelo informado nao existe no runtime atual. Consulte `/api/tags`.

## Timeout

Modelos maiores podem levar mais tempo. Aumente timeout no cliente.

## HTTP 500

Erro interno temporario. Tente retry com backoff e registre ocorrencia.
