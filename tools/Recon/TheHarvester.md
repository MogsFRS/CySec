# theHarvester — OSINT Gathering

## O que é o theHarvester?

O **theHarvester** é uma ferramenta de OSINT (Open Source Intelligence) utilizada para coletar informações públicas relacionadas a um domínio ou organização.

Ela consulta diferentes fontes de informação, como mecanismos de busca, registros de transparência de certificados, repositórios de código e serviços de inteligência.

Seu objetivo é reunir informações que possam ajudar a mapear a presença pública de uma organização na internet.

Entre os dados que pode coletar estão:

- Endereços de e-mail.
- Subdomínios e hostnames.
- Endereços IP.
- ASNs.
- URLs.
- Nomes de pessoas.
- Informações relacionadas a vazamentos, conforme a fonte utilizada.

**Linguagem:** Python  
**Categoria:** OSINT / Information Gathering

## Instalação

### Kali Linux

```bash
# Atualiza a lista de pacotes
sudo apt update

# Instala o theHarvester
sudo apt install theharvester

# Verifica a instalação
theHarvester -h
```

### Instalação pelo código-fonte

O repositório atual utiliza Python 3.14 e `uv` para gerenciar o ambiente e as dependências.

```bash
# Instala o Git, caso ainda não esteja disponível
sudo apt install git

# Clona o repositório oficial
git clone https://github.com/laramies/theHarvester.git

# Entra na pasta do projeto
cd theHarvester

# Instala as dependências definidas pelo projeto
uv sync

# Verifica se a ferramenta inicia corretamente
uv run theHarvester -h
```

Na instalação pelo código-fonte, os comandos podem ser executados com `uv run`. Na instalação pelo pacote do Kali, utilize diretamente `theHarvester`.

## Sintaxe básica

```bash
theHarvester -d <domínio> -b <fonte>
```

- `-d`: define o domínio que será pesquisado.
- `-b`: define as fontes de informação utilizadas.

Exemplo:

```bash
# Consulta fontes públicas relacionadas ao domínio
theHarvester -d example.com -b crtsh,certspotter
```

`example.com` é utilizado apenas para demonstrar a sintaxe.

## 1. Selecionando fontes

A opção `-b` define quais fontes serão utilizadas na coleta.

Exemplos de fontes e seletores:

| Fonte ou seletor | Finalidade |
|---|---|
| `crtsh` | Consulta certificados públicos no Certificate Transparency |
| `certspotter` | Pesquisa informações em certificados públicos |
| `commoncrawl` | Consulta dados do índice Common Crawl |
| `subdomains` | Seleciona fontes que podem contribuir com subdomínios |
| `emails` | Seleciona fontes que podem contribuir com e-mails |
| `ips` | Seleciona fontes que podem contribuir com endereços IP |
| `asns` | Seleciona fontes que podem contribuir com ASNs |
| `urls` | Seleciona fontes que podem contribuir com URLs |
| `people` | Seleciona fontes que podem contribuir com nomes de pessoas |
| `breaches` | Seleciona fontes relacionadas a informações de vazamentos |

A lista de fontes muda conforme as versões e a disponibilidade dos provedores. Consulte a ajuda e o catálogo do projeto para verificar os nomes atuais.

### Exemplos

```bash
# Consulta duas fontes de certificados públicos
theHarvester -d example.com -b crtsh,certspotter

# Seleciona fontes que podem encontrar subdomínios
theHarvester -d example.com -b subdomains

# Seleciona fontes que podem encontrar e-mails
theHarvester -d example.com -b emails

# Combina diferentes capacidades
theHarvester -d example.com -b emails,urls,certspotter
```

Os seletores representam tipos de informação que as fontes podem fornecer. Eles não significam que a ferramenta retornará exclusivamente aquele tipo de dado.

## 2. Consultando todas as fontes passivas disponíveis

```bash
# Executa todas as fontes passivas P0 catalogadas
theHarvester -d example.com -b all
```

Essa operação pode consultar diversos provedores independentes.

É importante considerar que:

- Algumas fontes exigem API keys.
- Algumas possuem limites de requisições.
- Provedores podem ficar indisponíveis.
- A quantidade de resultados depende da cobertura de cada fonte.

Comece com poucas fontes e amplie a coleta conforme a necessidade.

## 3. Limite de resultados

```bash
# Limita os resultados por fonte
theHarvester -d example.com -b crtsh -l 100
```

O limite ajuda a controlar a quantidade de dados retornados e o volume de páginas consultadas.

Na versão atual, `--limit 0` remove o limite compartilhado de resultados por fonte e os limites locais de paginação, mas não elimina limites impostos pelos próprios provedores.

## 4. Resolução DNS

O theHarvester pode realizar resolução DNS dos hosts encontrados.

```bash
# Resolve os hosts descobertos utilizando os resolvers padrão
theHarvester -d example.com -b crtsh,certspotter -r
```

Também é possível informar um resolver específico:

```bash
# Utiliza um servidor DNS específico
theHarvester -d example.com -b crtsh -r 8.8.8.8
```

Uma lista de resolvers também pode ser utilizada:

```bash
# Utiliza uma lista de servidores DNS
theHarvester -d example.com -b crtsh -r resolvers.txt
```

O arquivo deve conter endereços IP, um por linha.

**Importante:** a resolução DNS gera consultas adicionais. Portanto, uma coleta passiva pode passar a incluir tráfego DNS direcionado aos resolvers escolhidos.

## 5. Brute force de DNS

```bash
# Realiza brute force de subdomínios
theHarvester -d example.com -b crtsh -c
```

A opção `-c` ativa a etapa de brute force DNS na versão atual.

O brute force utiliza nomes possíveis para tentar encontrar subdomínios adicionais.

Essa atividade gera consultas DNS e deve ser realizada somente dentro do escopo autorizado.

## 6. Consulta reversa

```bash
# Realiza consultas reversas relacionadas aos endereços encontrados
theHarvester -d example.com -b crtsh -n
```

A consulta reversa procura nomes associados a endereços IP por meio de registros PTR.

A disponibilidade de resultados depende dos registros publicados e dos parâmetros utilizados.

## 7. Fontes com API keys

Alguns provedores exigem credenciais para permitir consultas.

Na primeira execução, o theHarvester pode criar arquivos de configuração na pasta:

```text
~/.theHarvester/
```

Um dos arquivos é:

```text
~/.theHarvester/api-keys.yaml
```

Abra o arquivo:

```bash
# Edita as configurações de API keys
nano ~/.theHarvester/api-keys.yaml
```

As chaves devem ser preenchidas conforme o formato exigido por cada provedor.

Exemplo ilustrativo:

```yaml
apikeys:
  github:
    key: SUA_API_KEY

  censys:
    token: SEU_TOKEN
    organization_id: SEU_ORGANIZATION_ID
```

Os nomes dos campos dependem do provedor. Preserve a estrutura do arquivo gerado pela própria ferramenta.

Proteja o arquivo:

```bash
# Restringe o acesso ao arquivo de credenciais ao usuário proprietário
chmod 600 ~/.theHarvester/api-keys.yaml
```

Nunca publique API keys em repositórios GitHub ou compartilhe credenciais em relatórios.

## 8. Proxies

O theHarvester permite configurar proxies HTTP e SOCKS5 em:

```text
~/.theHarvester/proxies.yaml
```

Exemplo:

```yaml
http:
  - 127.0.0.1:8080

socks5:
  - 127.0.0.1:9050
```

Para habilitar o uso da configuração de proxy:

```bash
# Utiliza os proxies configurados
theHarvester -d example.com -b crtsh -p
```

Um proxy não torna a atividade automaticamente anônima. Consultas DNS podem seguir uma rota separada da comunicação HTTP/HTTPS com provedores.

## 9. Salvando resultados

```bash
# Salva os resultados com o nome de relatório informado
theHarvester -d example.com -b crtsh,certspotter -f relatorio
```

A versão atual pode gerar:

| Arquivo | Finalidade |
|---|---|
| `relatorio.jsonl` | Resultados em JSON Lines, úteis para automação |
| `relatorio.json` | Relatório JSON |
| `relatorio.xml` | Relatório XML |

O JSONL é especialmente útil para processamento com ferramentas como `jq` e Python.

Exemplo:

```bash
# Exibe o conteúdo do relatório JSONL
cat relatorio.jsonl

# Conta quantas linhas existem no relatório
wc -l relatorio.jsonl
```

## 10. Interpretando os resultados

O theHarvester pode apresentar diferentes tipos de evidências.

| Resultado | O que significa |
|---|---|
| Email | Endereço de e-mail encontrado em uma fonte |
| Hostname | Nome de host associado ao domínio |
| IP | Endereço IP relacionado a um resultado |
| URL | Endereço de recurso encontrado |
| ASN | Número de sistema autônomo associado à infraestrutura |
| People | Nome de pessoa encontrado em uma fonte |
| Breach | Informação relacionada a um catálogo de vazamentos |

Um resultado indica que uma fonte associou determinada informação ao alvo. Isso não garante que ela esteja atualizada, que pertença diretamente à organização ou que represente uma vulnerabilidade.

## 11. Fluxo de reconhecimento

### Primeira etapa: coleta passiva

```bash
# Consulta fontes passivas de certificados públicos
theHarvester -d example.com -b crtsh,certspotter
```

### Segunda etapa: ampliar a coleta de subdomínios

```bash
# Consulta fontes que podem contribuir com subdomínios
theHarvester -d example.com -b subdomains
```

### Terceira etapa: resolução DNS

```bash
# Resolve os hosts encontrados
theHarvester -d example.com -b crtsh,certspotter -r
```

### Quarta etapa: salvar os resultados

```bash
# Gera relatórios para análise posterior
theHarvester -d example.com -b crtsh,certspotter -f resultado
```

## 12. Integração com outras ferramentas

### DNSRecon

O theHarvester pode ajudar a encontrar nomes de hosts, enquanto o DNSRecon pode aprofundar a enumeração DNS.

```bash
# Coleta informações públicas sobre o domínio
theHarvester -d example.com -b subdomains -f harvest

# Realiza enumeração DNS do domínio
dnsrecon -d example.com -t std
```

Os resultados devem ser comparados e normalizados antes de serem utilizados em outras etapas.

### Nmap

Depois de validar quais hosts pertencem ao escopo autorizado, eles podem ser utilizados como entrada para o Nmap.

```bash
# Executa uma descoberta de hosts a partir de uma lista preparada
nmap -iL hosts.txt
```

O relatório do theHarvester não é necessariamente uma lista simples de hosts. Extraia e valide os nomes antes de utilizá-los com outras ferramentas.

## 13. Limitações e observações

- O theHarvester depende de fontes públicas e serviços externos.
- Algumas fontes exigem API keys.
- Resultados podem estar desatualizados ou incompletos.
- A ausência de resultados não prova que determinada informação não exista.
- A coleta passiva não significa que os provedores consultados não recebam o domínio pesquisado.
- Resolução DNS, brute force e outras ações podem gerar tráfego adicional.
- Um e-mail encontrado publicamente não comprova que a conta ainda exista.
- Um hostname descoberto não significa que o host esteja ativo ou vulnerável.

## Referências

- Repositório oficial: https://github.com/laramies/theHarvester
- Instalação: https://github.com/laramies/theHarvester/blob/master/docs/wiki/Installation.md
- Quick Start: https://github.com/laramies/theHarvester/blob/master/docs/wiki/Quick-Start.md
- Configuração de API keys: https://github.com/laramies/theHarvester/wiki/Configuration-and-API-Keys
