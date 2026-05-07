# Segurança e Acesso

## Premissas de acesso

- O acesso ao nó depende da rede interna/rota permitida do ambiente UFPI.
- SSH deve ser usado com usuários autorizados e trilha de auditoria.

## Práticas recomendadas

- Preferir autenticação por chave SSH.
- Evitar credenciais em texto plano em documentação versionada.
- Rotacionar credenciais quando houver exposição acidental.
- Restringir sudo ao mínimo necessário para operação.

## Permissões operacionais

- Validar se comandos administrativos exigem senha interativa.
- Documentar quais rotinas exigem privilégio elevado.
- Registrar mudanças sensíveis em PR com revisão.
