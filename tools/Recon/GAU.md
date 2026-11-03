# GAU — GetAllUrls

## 1. O que é?

O **GAU (GetAllUrls)** é uma ferramenta que coleta URLs conhecidas de um domínio a partir de fontes públicas e arquivos históricos.

Entre as fontes utilizadas estão:
- Wayback Machine.
- Common Crawl.
- AlienVault Open Threat Exchange (OTX).
- URLScan.

É especialmente útil durante o reconhecimento de aplicações web porque pode revelar caminhos e parâmetros que não aparecem na navegação normal do site.

Projeto: https://github.com/lc/gau

## 2. Como funciona?

O GAU consulta fontes externas que já possuem registros de URLs associados a um domínio.

Isso significa que ele não precisa descobrir todos os caminhos fazendo requisições diretamente ao servidor de destino.

Exemplo:

```text
https://example.com/
https://example.com/login
https://example.com/products?id=10
https://example.com/api/v1/users
```

Essas URLs podem ter sido coletadas em momentos diferentes. Portanto, não significa que todas continuam disponíveis.

## 3. Instalação no Kali

Uma forma de instalar é utilizando Go:

```bash
go install github.com/lc/gau/v2/cmd/gau@latest
```

Confira:

```bash
gau --help
```

Se o comando não for encontrado, verifique se o diretório `$(go env GOPATH)/bin` está no PATH.

## 4. Uso básico

```bash
gau example.com
```

A ferramenta retorna URLs conhecidas associadas ao domínio.

Para incluir subdomínios:

```bash
gau example.com --subs
```

## 5. Trabalhando com arquivos

É possível fornecer uma lista de domínios:

```bash
gau example.com example.org
```

Ou utilizar entrada padrão:

```bash
cat dominios.txt | gau
```

Salvar resultados:

```bash
gau example.com --o urls.txt
```

## 6. Filtrando resultados

### Excluir extensões

```bash
gau example.com --blacklist png,jpg,gif,woff,svg
```

### Selecionar fontes

```bash
gau example.com --providers wayback,commoncrawl
```

### Incluir subdomínios

```bash
gau example.com --subs
```

### Remover variações de parâmetros do mesmo endpoint

```bash
gau example.com --fp
```

### Exportar em JSON

```bash
gau example.com --json
```

## 7. Integrando com outras ferramentas

O GAU pode ser combinado com ferramentas de linha de comando.

Exemplo: coletar URLs e procurar aquelas que possuem parâmetros:

```bash
gau example.com | grep '?'
```

Salvar apenas URLs únicas:

```bash
gau example.com | sort -u > urls.txt
```

Procurar caminhos que contenham uma palavra:

```bash
gau example.com | grep -i 'login'
```

Esses comandos demonstram processamento de texto; não significam que os caminhos encontrados estejam ativos.

## 8. GAU não é um scanner de vulnerabilidades

O GAU não confirma:
- Se uma URL ainda existe.
- Se um parâmetro é vulnerável.
- Se uma API permite acesso indevido.
- Se um arquivo pode ser acessado atualmente.

Ele é uma ferramenta de coleta de URLs históricas e conhecidas. Para verificar a disponibilidade de um recurso, é necessário fazer uma análise separada e autorizada.

## 9. Cuidados

- URLs históricas podem conter parâmetros antigos.
- Alguns endereços podem estar desativados.
- Não compartilhe tokens ou dados sensíveis encontrados em URLs.
- Não teste parâmetros de terceiros sem autorização.

## 10. Documentação

- GitHub: https://github.com/lc/gau
- Releases: https://github.com/lc/gau/releases
