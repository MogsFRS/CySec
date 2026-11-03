# DNSenum — DNS Enumeration

## O que é o DNSenum?

O **DNSenum** é uma ferramenta de enumeração DNS escrita em Perl. Ela automatiza a coleta de informações relacionadas a um domínio, como endereços IP, servidores DNS, servidores de e-mail e subdomínios.

Durante um reconhecimento, essas informações ajudam a mapear a infraestrutura associada a um domínio e identificar possíveis pontos que merecem investigação.

O DNSenum pode realizar:

- Consulta de registros A, NS e MX.
- Tentativas de transferência de zona DNS (AXFR).
- Descoberta de subdomínios por meio de mecanismos de busca.
- Brute force de subdomínios usando wordlists.
- Enumeração recursiva de subdomínios.
- Consultas reversas (PTR).
- Consultas WHOIS relacionadas aos blocos de IP encontrados.
- Exportação dos resultados em XML.

**Linguagem:** Perl  
**Categoria:** Information Gathering / DNS Enumeration

## Instalação

### Kali Linux / Debian / Ubuntu

```bash
# Atualiza a lista de pacotes
sudo apt update

# Instala o DNSenum
sudo apt install dnsenum

# Verifica a instalação
dnsenum --help
```

No Kali, o pacote também pode ser consultado na documentação oficial de ferramentas da distribuição.

## Sintaxe básica

```bash
dnsenum [opções] <domínio>
```

Exemplo:

```bash
# Enumera informações DNS de um domínio
dnsenum example.com
```

Use `example.com` apenas como exemplo de sintaxe. Para testes práticos, substitua por um domínio sob seu controle ou autorizado.

## 1. Enumeração básica

```bash
# Executa a enumeração padrão do domínio
dnsenum example.com

# Executa a enumeração sem consultas reversas
dnsenum --noreverse example.com

# Exibe informações adicionais durante a execução
dnsenum --verbose example.com

# Desativa as cores da saída
dnsenum --nocolor example.com
```

A opção `--noreverse` é útil quando não há necessidade de consultar blocos de IP encontrados. Consultas reversas podem aumentar bastante o tempo de execução.

## 2. Registros DNS

O DNSenum consulta informações importantes para entender como o domínio está organizado.

| Registro | Função |
|---|---|
| A | Relaciona um nome a um endereço IPv4 |
| AAAA | Relaciona um nome a um endereço IPv6 |
| NS | Identifica os servidores responsáveis pelo DNS do domínio |
| MX | Identifica os servidores de e-mail |
| PTR | Permite a resolução reversa de um IP para um nome |
| SOA | Contém informações administrativas da zona DNS |

A enumeração padrão do DNSenum apresenta principalmente os registros A, NS e MX. Outros dados podem surgir durante as etapas adicionais da ferramenta.

## 3. Brute force de subdomínios

O DNSenum permite testar nomes de subdomínios usando uma wordlist.

```bash
# Usa uma wordlist personalizada
dnsenum -f subdomains.txt example.com

# Usa uma wordlist específica e exibe o progresso
dnsenum --file /usr/share/wordlists/dns.txt --verbose example.com
```

Cada linha da wordlist representa um possível nome de subdomínio.

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

A ferramenta combina os nomes com o domínio informado e consulta se eles existem.

### Recursão

```bash
# Ativa a enumeração recursiva de subdomínios
dnsenum --recursion -f subdomains.txt example.com
```

A recursão permite continuar a enumeração em subdomínios encontrados que possuam registros NS próprios.

## 4. Servidor DNS personalizado

```bash
# Define o servidor DNS utilizado nas consultas A, NS e MX
dnsenum --dnsserver 8.8.8.8 example.com
```

Isso permite escolher explicitamente o servidor utilizado para determinadas consultas DNS.

A opção não significa que todas as consultas da ferramenta serão necessariamente enviadas a esse servidor: operações como AXFR e PTR podem consultar servidores específicos da infraestrutura examinada.

## 5. Tentativa de transferência de zona (AXFR)

```bash
# Executa a enumeração padrão, incluindo tentativas de transferência de zona
dnsenum --enum example.com
```

Uma transferência de zona permite que um servidor DNS autorizado solicite uma cópia dos registros de uma zona.

Quando um servidor permite AXFR indevidamente a qualquer origem, pode revelar uma quantidade significativa de registros internos ou públicos da zona.

**Importante:** a tentativa de AXFR não significa que a transferência será aceita. O servidor normalmente restringe essa operação a servidores secundários autorizados.

## 6. Consultas reversas e WHOIS

```bash
# Executa consultas WHOIS para blocos de rede encontrados
dnsenum --whois example.com

# Ignora consultas reversas
dnsenum --noreverse example.com
```

A opção `--whois` pode ampliar a investigação para blocos de rede associados aos endereços encontrados.

**Atenção:** essa etapa pode gerar muitas consultas e demorar bastante, principalmente quando são encontrados blocos de rede grandes.

## 7. Controle de execução

| Opção | Descrição |
|---|---|
| `--threads <n>` | Define a quantidade de threads |
| `-t, --timeout <n>` | Define o tempo limite das consultas TCP/UDP, em segundos |
| `-v, --verbose` | Exibe mais informações da execução |
| `--nocolor` | Desativa cores |
| `--noreverse` | Ignora consultas reversas |
| `--dnsserver <IP>` | Define o servidor DNS para consultas A, NS e MX |
| `-h, --help` | Exibe a ajuda |

## 8. Descoberta por mecanismos de busca

O DNSenum também possui opções de coleta de nomes por meio de resultados de mecanismos de busca.

```bash
# Define a quantidade máxima de subdomínios coletados
dnsenum --scrap 20 example.com

# Define quantas páginas serão consultadas
dnsenum --pages 10 --scrap 30 example.com
```

Essas opções dependem da disponibilidade e do comportamento dos serviços externos. Resultados podem variar ou deixar de funcionar quando um provedor altera suas páginas ou limita consultas.

## 9. Salvando resultados

```bash
# Salva os resultados em XML
dnsenum -o resultado.xml example.com

# Salva os subdomínios válidos em um arquivo
dnsenum --subfile subdominios.txt example.com

# Salva resultados e ignora consultas reversas
dnsenum --noreverse -o resultado.xml example.com
```

O arquivo XML pode ser utilizado em ferramentas que aceitam esse formato. O arquivo de subdomínios facilita o reaproveitamento dos nomes em outras etapas de reconhecimento.

## 10. Exemplos de utilização

### Enumeração inicial

```bash
# Obtém informações DNS básicas do domínio
dnsenum example.com
```

### Enumeração com wordlist

```bash
# Procura subdomínios usando uma lista personalizada
dnsenum -f subdomains.txt example.com
```

### Enumeração com recursão

```bash
# Continua a enumeração em subdomínios que possuem NS próprios
dnsenum -r -f subdomains.txt example.com
```

### Enumeração sem consultas reversas e com relatório

```bash
# Reduz o tempo gasto com consultas reversas e salva o relatório XML
dnsenum --noreverse -o dns-report.xml example.com
```

## 11. Integração com outras ferramentas

### Nmap

É possível aproveitar os subdomínios encontrados como entrada para outras ferramentas.

```bash
# Enumera subdomínios e salva os nomes encontrados
dnsenum --subfile subdominios.txt example.com

# Utiliza a lista como entrada para o Nmap
nmap -iL subdominios.txt
```

O Nmap pode resolver os nomes e realizar a descoberta de hosts e serviços conforme as opções utilizadas.

Antes de realizar qualquer varredura, confirme se todos os hosts encontrados estão dentro do escopo autorizado.

## 12. Limitações e observações

- O DNSenum depende da disponibilidade dos servidores DNS e dos serviços externos consultados.
- Uma wordlist pequena pode deixar de encontrar subdomínios existentes.
- Um subdomínio encontrado não significa que exista uma vulnerabilidade.
- Uma transferência AXFR recusada não significa que o DNS esteja livre de outros problemas.
- Consultas reversas e WHOIS podem aumentar bastante o tempo de execução.
- Resultados podem conter registros antigos, duplicados ou desatualizados.
- Algumas opções podem apresentar diferenças conforme a versão instalada.

## Referências

- Kali Linux Tools: https://www.kali.org/tools/dnsenum/
- Código e versões do projeto: https://github.com/SparrowOchon/dnsenum2
- Manual de referência: https://manpages.debian.org/
