# Imagens base para containers

| Variante | Pasta | Situação |
|---|---|---|
| Ubuntu 26.04 LTS + Node.js 26 | `images/ubuntu26.04-node26` | Atual (tag `latest`) |
| Ubuntu 22.04 LTS + Node.js 20 | `images/ubuntu22.04-node20` | Legado, congelada |

As imagens são publicadas no GitHub Container Registry: `ghcr.io/<owner>/base-image`.

## Tags

| Tag | Quando muda | Uso recomendado |
|---|---|---|
| `ubuntu26.04-node26-v1.2.0` | Nunca (imutável) | Produção |
| `ubuntu26.04-node26` | A cada release/rebuild | Desenvolvimento |
| `ubuntu26.04-node26-20261023` | Rebuild manual | Rastrear patches |
| `latest` | A cada release | Evitar em produção |

Mesmo esquema para `ubuntu22.04-node20-*`.

## Como criar uma release

```bash
git tag v1.0.0
git push origin v1.0.0
```

O workflow faz o build das duas imagens, publica no GHCR e cria a GitHub Release com as tags no corpo.

## Rebuild sem nova versão

Em **Actions > Build e release das imagens base > Run workflow**, escolha a variante. Útil para pegar
patches de segurança do Ubuntu e do Node sem mudar nada no Dockerfile.

## Usando nos projetos

```dockerfile
FROM ghcr.io/<owner>/base-image:ubuntu26.04-node26-v1.0.0
```

Se o repositório for privado, o servidor/CI que faz o pull precisa autenticar no GHCR
(`docker login ghcr.io` com um token com escopo `read:packages`).

## Trocar a versão do Node

A imagem nova aceita `NODE_MAJOR` como build-arg (padrão 26):

```bash
docker build --build-arg NODE_MAJOR=24 -t teste images/ubuntu26.04-node26
```
