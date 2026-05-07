# Operação do Dia a Dia

## Acesso

```bash
ssh usuario@10.94.80.13
```

## Verificações básicas

```bash
systemctl status ollama
curl -s http://127.0.0.1:11434/api/version
curl -s http://127.0.0.1:11434/api/tags
nvidia-smi
```

## Gerenciamento de modelos

```bash
# baixar modelo
ollama pull <modelo>

# listar modelos
ollama list

# remover modelo
ollama rm <modelo>
```

## Reinício de serviço

```bash
sudo systemctl restart ollama
sudo systemctl status ollama
```

## Boas práticas

- Validar GPU (`nvidia-smi`) antes e após mudanças.
- Confirmar espaço em disco/NFS antes de baixar modelos grandes.
- Registrar alterações no repositório após qualquer mudança operacional.
