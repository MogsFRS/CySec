# DNSRecon — DNS Enumeration and Scanning

## O que é o DNSRecon?

O **DNSRecon** é uma ferramenta de reconhecimento e enumeração DNS escrita em Python. Ela reúne diferentes métodos de consulta para identificar registros DNS, subdomínios, servidores de nomes e possíveis configurações incorretas.

É utilizada durante a fase de reconhecimento de um pentest para mapear a infraestrutura DNS de um domínio.

Entre suas funcionalidades estão:

- Enumeração de registros DNS.
- Tentativas de transferência de zona (AXFR).
- Brute force de subdomínios.
- Identificação de registros SRV.
- Consultas reversas (PTR).
- Verificação de resolução wildcard.
- Enumeração por mecanismos de busca.
- Consultas a certificados públicos via crt.sh.
- Análise de registros SPF e informações WHOIS.
- Exportação em XML, CSV e JSON.

**Linguagem:** Python  
**Categoria:** Information Gathering / DNS Enumeration

## Instalação

### Kali Linux / Debian / Ubuntu

```bash
# Atualiza a lista de pacotes
sudo apt update

# Instala o DNSRecon
sudo apt install dnsrecon

# Verifica a instalação
dnsrecon -h
```

## Sintaxe básica

```bash
dnsrecon -d <domínio> [opções]
```

Exemplo:

```bash
# Executa a enumeração padrão do domínio
dnsrecon -d example.com
```

## 1. Enumeração padrão

```bash
# Executa a enumeração padrão
dnsrecon -d example.com -t std
```

O tipo `std` realiza uma enumeração geral, incluindo informações DNS como:

- A e AAAA.
- NS.
- MX.
- SOA.
- TXT.
- SPF e informações relacionadas.
- Verificações adicionais conforme a versão e configuração.

A enumeração padrão é um bom ponto de partida para entender a infraestrutura DNS de um domínio.

## 2. Tipos de enumeração

A opção `-t` define o tipo de operação que será executada.

| Tipo | Descrição |
|---|---|
| `std` | Enumeração DNS padrão |
| `axfr` | Testa transferência de zona |
| `brt` | Brute force de subdomínios |
| `srv` | Enumera registros SRV |
| `tld` | Expansão de nomes com outros TLDs |
| `zonewalk` | Verificação de possibilidade de zone walking DNSSEC |
| `cache` | Verificação de registros presentes em cache DNS |
| `bing` | Descoberta de nomes por meio do Bing |
| `yand` | Descoberta de nomes por meio do Yandex |
| `crt` | Consulta de nomes associados a certificados públicos |

Os tipos disponíveis podem variar entre versões. Consulte `dnsrecon -h` para verificar a lista da instalação atual.

## 3. Enumeração de registros DNS

```bash
# Executa a enumeração padrão de registros
dnsrecon -d example.com -t std
```

Registros importantes:

| Registro | Função |
|---|---|
| A | Endereço IPv4 |
| AAAA | Endereço IPv6 |
| NS | Servidores DNS responsáveis pela zona |
| MX | Servidores de e-mail |
| SOA | Informações administrativas da zona |
| TXT | Informações textuais associadas ao domínio |
| SRV | Localização de serviços específicos |
| PTR | Resolução reversa de endereços IP |

## 4. Transferência de zona (AXFR)

```bash
# Tenta realizar uma transferência de zona
dnsrecon -d example.com -t axfr
```

A transferência de zona permite que um servidor DNS autorizado obtenha uma cópia dos registros de uma zona.

Se o servidor aceitar solicitações AXFR de origens não autorizadas, poderá expor informações sobre os hosts e serviços associados ao domínio.

O resultado depende das regras de acesso configuradas no servidor DNS.

## 5. Brute force de subdomínios

```bash
# Executa brute force usando uma wordlist
dnsrecon -d example.com -t brt -D subdomains.txt
```

Exemplo de wordlist:

```text
www
mail
ftp
dev
test
admin
api
vpn
```

A ferramenta testa os nomes da lista e verifica quais resolvem para registros DNS.

### Filtrando wildcard

```bash
# Ignora resultados que correspondam ao endereço wildcard identificado
dnsrecon -d example.com -t brt -D subdomains.txt -f
```

Uma configuração wildcard pode fazer com que nomes inexistentes resolvam para o mesmo endereço IP. Isso pode gerar falsos positivos durante o brute force.

A opção `-f` ajuda a filtrar esses resultados.

## 6. Definindo um servidor DNS

```bash
# Define um servidor DNS específico
dnsrecon -d example.com -n 8.8.8.8 -t std
```

Também é possível informar mais de um servidor, separados por vírgula:

```bash
dnsrecon -d example.com -n 8.8.8.8,1.1.1.1 -t std
```

## 7. Enumeração reversa

A consulta reversa procura nomes associados a endereços IP por meio de registros PTR.

```bash
# Consulta reversa em uma faixa de IPs
dnsrecon -r 192.168.1.1-192.168.1.254
```

Também é possível utilizar notação CIDR:

```bash
# Consulta reversa em uma rede /24
dnsrecon -r 192.168.1.0/24
```

Essa operação é útil quando você possui uma faixa de endereços autorizada e deseja identificar nomes associados aos IPs.

## 8. Enumeração de registros SRV

```bash
# Procura registros SRV do domínio
dnsrecon -d example.com -t srv
```

Registros SRV são utilizados para indicar servidores responsáveis por serviços específicos.

Eles podem revelar informações sobre serviços como:

- LDAP.
- Kerberos.
- SIP.
- XMPP.
- Serviços Microsoft.

A existência de um registro SRV não confirma que o serviço esteja acessível ou vulnerável.

## 9. Fontes externas e certificados

```bash
# Consulta nomes associados a certificados públicos
dnsrecon -d example.com -t crt
```

Certificados digitais publicados em registros de Certificate Transparency podem revelar nomes de hosts e subdomínios utilizados pela organização.

A disponibilidade dessa função depende da versão e das fontes externas utilizadas.

## 10. Opções adicionais de enumeração

A enumeração padrão pode ser ampliada com opções adicionais:

```bash
# Enumeração padrão com tentativa de AXFR
dnsrecon -d example.com -t std -a

# Enumeração padrão com consultas reversas de IPs encontrados em SPF
dnsrecon -d example.com -t std -s

# Enumeração padrão usando Bing
dnsrecon -d example.com -t std -b

# Enumeração padrão usando Yandex
dnsrecon -d example.com -t std -y

# Enumeração padrão consultando crt.sh
dnsrecon -d example.com -t std -k

# Análise WHOIS aprofundada e consultas reversas de faixas encontradas
dnsrecon -d example.com -t std -w
```

Essas opções complementam a enumeração padrão. Algumas dependem de serviços externos, e seus resultados podem variar.

## 11. Controle de execução

| Opção | Descrição |
|---|---|
| `-d, --domain` | Define o domínio-alvo |
| `-iL, --input-list` | Lê uma lista de domínios |
| `-n, --name_server` | Define o servidor DNS |
| `-r, --range` | Define uma faixa de IPs para consultas reversas |
| `-D, --dictionary` | Define a wordlist |
| `-f` | Filtra resultados wildcard durante brute force |
| `-a` | Executa AXFR junto da enumeração padrão |
| `-s` | Consulta reversa de faixas IPv4 presentes em SPF |
| `-b` | Enumeração por Bing |
| `-y` | Enumeração por Yandex |
| `-k` | Enumeração por crt.sh |
| `-w` | Análise WHOIS aprofundada |
| `-z` | Executa DNSSEC zone walk |
| `--threads` | Define a quantidade de threads |
| `--lifetime` | Define o tempo de espera por resposta DNS |
| `--tcp` | Realiza consultas usando TCP |
| `-h` | Exibe a ajuda |

## 12. Salvando resultados

O DNSRecon permite exportar os resultados em diferentes formatos.

```bash
# Salva os resultados em XML
dnsrecon -d example.com -t std -x resultado.xml

# Salva os resultados em CSV
dnsrecon -d example.com -t std -c resultado.csv

# Salva os resultados em JSON
dnsrecon -d example.com -t std -j resultado.json

# Salva os registros em um banco SQLite
dnsrecon -d example.com -t std --db resultado.sqlite
```

### Qual formato utilizar?

| Formato | Uso |
|---|---|
| XML | Integração com ferramentas que aceitam XML |
| CSV | Análise em planilhas e scripts |
| JSON | Automação e processamento com Python |
| SQLite | Armazenamento e consultas estruturadas |

## 13. Exemplos de utilização

### Reconhecimento inicial

```bash
# Enumeração geral do domínio
dnsrecon -d example.com -t std
```

### Enumeração com wordlist

```bash
# Procura subdomínios usando uma lista
dnsrecon -d example.com -t brt -D subdomains.txt
```

### Enumeração e AXFR

```bash
# Executa enumeração padrão e verifica transferência de zona
dnsrecon -d example.com -t std -a
```

### Enumeração com relatório JSON

```bash
# Executa a enumeração e exporta os resultados
dnsrecon -d example.com -t std -j dns-results.json
```

### Vários domínios

```bash
# Lê os domínios de um arquivo, um por linha
dnsrecon -iL domains.txt -t std
```

## 14. Integração com outras ferramentas

### Nmap

Os nomes descobertos podem ser utilizados como entrada para o Nmap.

```bash
# Executa a enumeração DNS e salva o relatório
dnsrecon -d example.com -t std -j dns-results.json

# Para automatizar, prefira exportar uma lista de hosts limpa
# e utilizá-la como entrada do Nmap
nmap -iL hosts.txt
```

O arquivo JSON do DNSRecon contém dados estruturados, não necessariamente uma lista simples de hosts. Para utilizá-lo diretamente em automações, é necessário extrair e normalizar os nomes primeiro.

## 15. DNSRecon x DNSenum

| Característica | DNSenum | DNSRecon |
|---|---|---|
| Linguagem | Perl | Python |
| Enumeração de registros | Sim | Sim |
| Brute force | Sim | Sim |
| AXFR | Sim | Sim |
| Consultas reversas | Sim | Sim |
| Registros SRV | Não é seu foco principal | Sim |
| Wildcard | Não é seu foco principal | Sim |
| Exportação | XML | XML, CSV, JSON e SQLite |
| Integração com fontes externas | Sim | Sim |

Ambas são ferramentas de enumeração DNS, mas possuem opções e fluxos de trabalho diferentes.

## 16. Limitações e observações

- A descoberta de um subdomínio não confirma uma vulnerabilidade.
- A transferência AXFR depende das permissões do servidor DNS.
- Wildcards podem gerar resultados que parecem subdomínios válidos.
- Consultas reversas dependem da existência de registros PTR.
- Fontes externas podem impor limites ou mudar seus métodos de consulta.
- Os tipos e opções disponíveis variam conforme a versão.
- Algumas operações podem gerar tráfego diretamente contra a infraestrutura examinada.

## Referências

- Kali Linux Tools: https://www.kali.org/tools/dnsrecon/
- Repositório oficial: https://github.com/darkoperator/dnsrecon
- Documentação do projeto: https://github.com/darkoperator/dnsrecon/wiki
