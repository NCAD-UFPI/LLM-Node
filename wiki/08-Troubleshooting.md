# Troubleshooting

## `vllm.service` em falha (`203/EXEC`)

Sintoma observado no inventário: serviço falho com `status=203/EXEC`.

### Verificações

```bash
systemctl status vllm --no-pager -l
journalctl -u vllm -n 200 --no-pager
cat /etc/systemd/system/vllm.service
```

### Causas comuns

- Binário/caminho inexistente em `ExecStart`.
- Permissão de execução ausente.
- Ambiente Python/venv removido.
- Variáveis de ambiente não carregadas pelo systemd.

### Ação recomendada

- Corrigir `ExecStart` e permissões.
- Rodar `daemon-reload` após ajuste.
- Revalidar com `systemctl restart vllm` e `systemctl status vllm`.

## Ollama inacessível

### Verificações

```bash
systemctl status ollama
ss -lntp | grep 11434
curl -v http://127.0.0.1:11434/api/version
```

### Possíveis causas

- Serviço parado.
- Porta não publicada/listening.
- Firewall/rede fora do domínio esperado.

## GPU indisponível

### Verificações

```bash
nvidia-smi
lsmod | grep nvidia
```

### Possíveis causas

- Driver inconsistente.
- Host após atualização com reboot pendente.
