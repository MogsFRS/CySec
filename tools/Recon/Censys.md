# Censys — Pesquisa e Análise de Ativos na Internet

## 1. O que é?

O **Censys** é uma plataforma de pesquisa de ativos conectados à internet. Ele coleta e organiza informações sobre hosts, serviços, certificados digitais e propriedades web.

É utilizado em:
- OSINT.
- Reconhecimento de infraestrutura.
- Inventário de ativos públicos.
- Análise de exposição.
- Pesquisa de certificados.
- Identificação de serviços e tecnologias.

Site: https://search.censys.io/

## 2. Como funciona?

O Censys realiza medições e varreduras da internet pública e organiza os resultados em conjuntos de dados.

Na plataforma atual, três categorias são especialmente importantes:

| Categoria | O que representa |
|---|---|
| Hosts | Endereços IP e serviços observados |
| Web properties | Sites, APIs e aplicações web |
| Certificates | Certificados digitais e informações associadas |

Isso permite pesquisar não apenas um IP, mas também nomes de domínio, certificados e serviços relacionados.

## 3. Criando uma conta

1. Acesse https://platform.censys.io/.
2. Crie uma conta.
3. Confirme seu endereço de e-mail.
4. Entre na plataforma.
5. Utilize a barra de pesquisa para realizar consultas.

A disponibilidade de campos, recursos e limites depende do nível de acesso da conta.

## 4. Sintaxe de pesquisa

O Censys utiliza uma linguagem de consulta chamada **Censys Query Language (CenQL)**.

Uma consulta pode pesquisar texto livre ou campos específicos.

### Pesquisa textual

```text
"example.com"
```

Procura correspondências textuais nos dados aplicáveis.

### Pesquisa por porta

```text
host.services.port = "22"
```

Procura hosts com serviço identificado na porta 22.

### Pesquisa por protocolo

```text
host.services: (port = "22" and protocol = "SSH")
```

Combina porta e protocolo.

### Pesquisa por sistema operacional

```text
host.operating_system.product = "linux"
```

Procura registros identificados como Linux.

### Pesquisa por domínio em certificados

```text
host.services.cert.names = "example.com"
```

Procura hosts cujos certificados apresentam o nome informado.

Essas consultas são exemplos de sintaxe. Os campos disponíveis dependem do conjunto de dados e da versão atual da plataforma.

## 5. Como analisar um resultado

Ao abrir um registro de host, observe:

- IP associado ao registro.
- Serviços identificados.
- Portas observadas.
- Protocolos.
- Produtos e versões anunciados.
- Nomes DNS relacionados.
- Certificados.
- Localização e organização, quando disponíveis.

Não confunda um produto identificado com uma vulnerabilidade confirmada.

## 6. Censys e Shodan: diferenças

| Característica | Censys | Shodan |
|---|---|---|
| Hosts e serviços | Sim | Sim |
| Pesquisa por certificados | Sim | Sim |
| Pesquisa estruturada | CenQL | Filtros próprios |
| Propriedades web | Conjunto específico | Informações de banners e serviços |
| API e integração | Sim | Sim |
| Principal uso | Pesquisa estruturada e correlação de ativos | Busca de serviços e banners expostos |

As duas plataformas são complementares. Uma pode encontrar informações que não aparecem na outra, devido a diferenças de coleta, cobertura e indexação.

## 7. Cuidados

- Os registros representam observações feitas em determinados momentos.
- Um resultado não comprova que um serviço continua ativo.
- Uma versão anunciada não confirma, sozinha, a existência de uma CVE explorável.
- Não tente acessar ou explorar ativos de terceiros.
- Respeite os limites e termos de uso da plataforma.

## 8. Documentação oficial

- Plataforma: https://platform.censys.io/
- Guia inicial: https://docs.censys.com/docs/platform-quickstart-guide
- Linguagem CenQL: https://docs.censys.com/docs/censys-query-language
- Diferenças de sintaxe: https://docs.censys.com/docs/censys-platform-syntax-differences
