# Exemplos de Integracao

## cURL

```bash
curl -s http://10.94.80.13:11434/api/generate \
  -H "Content-Type: application/json" \
  -d '{"model":"gemma4:latest","prompt":"Diga ola","stream":false}'
```

## JavaScript (fetch)

```javascript
const res = await fetch("http://10.94.80.13:11434/api/generate", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({
    model: "gemma4:latest",
    prompt: "Crie 5 ideias de projeto com IA",
    stream: false
  })
});

const data = await res.json();
console.log(data.response);
```
