
 # 🛡️ CySec — Cybersecurity Notes

## Sobre o projeto

O **CySec** é um repositório dedicado ao estudo, à documentação e ao compartilhamento de conhecimentos sobre cibersegurança, segurança da informação e testes de invasão (Pentest).

A ideia deste projeto é reunir informações sobre ferramentas, técnicas, comandos e procedimentos utilizados durante atividades de segurança, criando uma base de consulta que possa ser útil tanto para quem está começando quanto para quem já possui alguma experiência na área.

Ao estudar cibersegurança, acabamos encontrando uma quantidade enorme de ferramentas e informações espalhadas por documentações oficiais, fóruns, artigos, cursos e comunidades. Muitas vezes, encontramos um comando interessante, mas não sabemos exatamente o que ele faz, quando utilizá-lo ou como interpretar seu resultado.

O CySec nasceu justamente dessa necessidade: organizar esse conhecimento, documentar o funcionamento das ferramentas e transformar o aprendizado em material que possa ser consultado posteriormente.

O conteúdo não se limita a apresentar comandos. A intenção é explicar os conceitos por trás de cada ferramenta, mostrar exemplos de utilização, apresentar parâmetros importantes, explorar diferentes possibilidades e entender como cada recurso se encaixa em um processo de análise de segurança.

O projeto também está aberto a melhorias e atualizações. Conforme novos conhecimentos forem adquiridos, novas ferramentas forem estudadas e outras técnicas forem exploradas, o material será ampliado e revisado.

**A proposta é aprender na prática, documentar o processo e compartilhar conhecimento com outras pessoas interessadas na área.**

---

# 🎯 Áreas de estudo

A cibersegurança é bastante ampla e envolve diferentes especializações. Dentro do CySec, o foco está principalmente em segurança ofensiva, análise de vulnerabilidades, reconhecimento de infraestrutura, exploração controlada e automação.

Abaixo estão algumas das principais áreas que fazem parte desse universo.

## 1. OSINT — Open Source Intelligence

OSINT é a coleta e análise de informações disponíveis publicamente sobre um determinado alvo, organização, domínio ou infraestrutura.

O objetivo é encontrar informações que possam ajudar a compreender melhor o ambiente analisado, sem necessariamente estabelecer uma conexão direta com seus sistemas.

Dependendo do alvo e das informações disponíveis, é possível encontrar:

- Domínios e subdomínios.
- Endereços de e-mail corporativos.
- Endereços IP e informações de infraestrutura.
- Registros DNS.
- Tecnologias utilizadas em sites.
- Documentos e arquivos publicados.
- Metadados de imagens e documentos.
- Informações sobre funcionários e serviços.
- Registros públicos e informações expostas na internet.

OSINT é especialmente importante porque permite construir uma visão inicial do alvo antes de realizar testes técnicos.

### Ferramentas utilizadas

| Ferramenta | Finalidade |
|---|---|
| theHarvester | Coleta e-mails, subdomínios e informações públicas. |
| SpiderFoot | Automatiza a coleta e correlação de informações OSINT. |
| Shodan | Pesquisa dispositivos e serviços expostos na internet. |
| Censys | Pesquisa e análise de infraestrutura conectada à internet. |
| ExifTool | Extrai e analisa metadados de arquivos. |
| DNSenum | Realiza enumeração de informações DNS. |
| DNSRecon | Coleta e analisa registros e configurações DNS. |
| Amass | Descoberta de ativos e enumeração de subdomínios. |

### Comandos básicos

**Whois — consulta informações sobre domínios:**

```bash
whois example.com
```

**Dig — consulta registros DNS:**

```bash
dig example.com
dig example.com A
dig example.com MX
dig example.com NS
dig +short example.com
```

**TheHarvester — coleta informações públicas:**

```bash
theHarvester -d example.com -b all
```

**ExifTool — analisa metadados:**

```bash
exiftool arquivo.pdf
exiftool imagem.jpg
exiftool -gps:all imagem.jpg
```

**Amass — enumera subdomínios:**

```bash
amass enum -passive -d example.com
```

> OSINT não significa necessariamente invasão ou exploração. Grande parte desse trabalho consiste em pesquisar, relacionar e interpretar informações que já estão disponíveis publicamente.

---

## 2. Reconnaissance — Reconhecimento

Reconnaissance, ou simplesmente Recon, é a etapa de reconhecimento do alvo. É aqui que começamos a entender melhor a infraestrutura, os serviços e as tecnologias que serão analisados.

Diferentemente do OSINT, que pode ser realizado inteiramente por meio de fontes públicas, o Recon também pode envolver interações técnicas diretas com os sistemas, dependendo do escopo autorizado.

Existem duas abordagens principais:

**Passive Reconnaissance:** coleta informações sem interagir diretamente com os sistemas do alvo. Exemplos incluem consultas DNS, pesquisa em mecanismos de busca e análise de informações públicas.

**Active Reconnaissance:** envolve interações diretas com os sistemas, como varreduras de portas, identificação de serviços e requisições HTTP.

Durante essa etapa, podemos procurar respostas para perguntas como:

- Quais dispositivos fazem parte da infraestrutura?
- Quais portas estão abertas?
- Quais serviços estão disponíveis?
- Quais versões de software estão sendo utilizadas?
- Quais tecnologias estão presentes em uma aplicação?
- Existem subdomínios ou serviços esquecidos?
- Há interfaces administrativas expostas?
- Existem configurações que merecem uma investigação mais detalhada?

### Ferramentas utilizadas

| Ferramenta | Finalidade |
|---|---|
| Nmap | Descoberta de hosts, portas e serviços. |
| Masscan | Varredura de portas em grande escala. |
| RustScan | Descoberta rápida de portas. |
| WhatWeb | Identificação de tecnologias utilizadas em sites. |
| Wappalyzer | Identificação de tecnologias web. |
| Subfinder | Descoberta passiva de subdomínios. |
| httpx | Verificação de serviços HTTP e HTTPS. |
| Gobuster | Enumeração de diretórios, arquivos e subdomínios. |

### Comandos básicos

**Nmap — descoberta de hosts:**

```bash
nmap -sn 192.168.1.0/24
```

**Nmap — análise de portas específicas:**

```bash
nmap -p 22,80,443 192.168.1.100
```

**Nmap — identificação de serviços e versões:**

```bash
nmap -sV 192.168.1.100
```

**Nmap — análise de todas as portas TCP:**

```bash
nmap -p- 192.168.1.100
```

**WhatWeb — identificação de tecnologias:**

```bash
whatweb https://example.com
```

**Subfinder — descoberta de subdomínios:**

```bash
subfinder -d example.com
```

**HTTPx — identificação de serviços web ativos:**

```bash
httpx -l subdomains.txt
```

**Gobuster — enumeração de diretórios:**

```bash
gobuster dir -u http://192.168.1.100 -w /usr/share/wordlists/dirb/common.txt
```

> O reconhecimento ajuda a definir onde vale a pena concentrar os próximos testes. Encontrar uma porta aberta ou um serviço não significa que exista uma vulnerabilidade, mas pode indicar um ponto que merece investigação.

---

## 3. Vulnerability Assessment — Avaliação de Vulnerabilidades

Depois de conhecer melhor o ambiente, o próximo passo é procurar possíveis vulnerabilidades.

Uma vulnerabilidade é uma falha que pode comprometer a confidencialidade, integridade ou disponibilidade de um sistema.

Essas falhas podem estar relacionadas a erros de programação, configurações incorretas, softwares desatualizados, autenticação inadequada, permissões excessivas ou outros problemas de segurança.

Alguns exemplos:

- SQL Injection (SQLi).
- Cross-Site Scripting (XSS).
- Cross-Site Request Forgery (CSRF).
- Server-Side Request Forgery (SSRF).
- Directory Traversal.
- Remote Code Execution (RCE).
- Broken Access Control.
- Falhas de autenticação.
- Exposição de informações sensíveis.
- Serviços desatualizados e vulneráveis.

É importante entender que encontrar uma possível vulnerabilidade não significa que ela esteja confirmada.

Um scanner pode identificar uma versão de software associada a uma CVE, mas isso não garante que o sistema esteja vulnerável. É necessário verificar a versão real, a configuração, as condições de exploração e o comportamento do serviço.

### Ferramentas utilizadas

| Ferramenta | Finalidade |
|---|---|
| Nikto | Analisa servidores web em busca de problemas conhecidos. |
| Nuclei | Executa verificações utilizando templates de segurança. |
| Nessus | Realiza avaliações automatizadas de vulnerabilidades. |
| OpenVAS / Greenbone | Identifica possíveis vulnerabilidades em sistemas e redes. |
| Burp Suite | Analisa e testa requisições e aplicações web. |
| OWASP ZAP | Proxy e scanner para testes de segurança web. |
| SQLmap | Automatiza a identificação e validação de SQL Injection. |
| Nmap NSE | Executa scripts para investigar serviços e possíveis problemas. |

### Comandos básicos

**Nikto — análise de servidor web:**

```bash
nikto -h http://192.168.1.100
```

**Nuclei — execução de verificações:**

```bash
nuclei -u http://192.168.1.100
```

**Nmap — identificação de versões:**

```bash
nmap -sV 192.168.1.100
```

**SQLmap — investigação de um parâmetro em laboratório:**

```bash
sqlmap -u "http://127.0.0.1/lab/item.php?id=1" --batch
```

**FFUF — descoberta de caminhos e recursos web:**

```bash
ffuf -u http://127.0.0.1/FUZZ -w /usr/share/wordlists/dirb/common.txt
```

> A avaliação de vulnerabilidades é uma etapa de investigação. O objetivo não é simplesmente acumular alertas, mas entender quais problemas realmente existem, quais condições são necessárias para reproduzi-los e qual seria seu impacto.

---

## 4. Exploitation — Exploração de Vulnerabilidades

Exploitation é a etapa em que uma vulnerabilidade identificada é testada para verificar se pode realmente ser explorada.

Em outras palavras, é o momento de sair da hipótese e buscar uma comprovação técnica do problema.

Por exemplo, imagine que durante uma análise foi identificado um serviço utilizando uma versão antiga de determinado software. Essa versão pode possuir uma vulnerabilidade conhecida, mas ainda é necessário verificar se o sistema está configurado de maneira que permita sua exploração.

A exploração pode demonstrar diferentes tipos de impacto:

- Acesso não autorizado a funcionalidades.
- Leitura de informações que deveriam estar protegidas.
- Execução de comandos em um ambiente vulnerável.
- Contorno de mecanismos de autenticação.
- Acesso indevido a arquivos.
- Comprometimento de aplicações ou serviços.

Uma exploração bem-sucedida não significa necessariamente que todo o sistema esteja comprometido. O impacto depende das permissões obtidas, da configuração do ambiente e das limitações da vulnerabilidade.

### Ferramentas utilizadas

| Ferramenta | Finalidade |
|---|---|
| Metasploit Framework | Plataforma para pesquisa e execução de módulos de exploração. |
| MSFConsole | Interface de interação com o Metasploit. |
| MSFVenom | Geração de payloads em diferentes formatos. |
| Burp Suite | Manipulação e teste de requisições web. |
| SQLmap | Testes de exploração de SQL Injection. |
| Searchsploit | Pesquisa de exploits no Exploit Database. |
| Python | Desenvolvimento de scripts e provas de conceito. |

### Comandos básicos

**Searchsploit — pesquisa de vulnerabilidades e exploits:**

```bash
searchsploit apache
searchsploit "nome do software"
```

**Metasploit — iniciar a interface:**

```bash
msfconsole
```

**Pesquisar módulos:**

```text
search type:exploit nome_do_servico
```

**Consultar informações de um módulo:**

```text
info nome_do_modulo
```

**Selecionar um módulo:**

```text
use caminho/do/modulo
```

**Visualizar opções:**

```text
show options
```

**Definir um alvo de laboratório:**

```text
set RHOSTS 192.168.1.100
```

**Verificar se o módulo oferece suporte a uma verificação prévia:**

```text
check
```

**Executar o módulo, quando apropriado e autorizado:**

```text
run
```

> Nem todo módulo oferece suporte ao comando `check`. Antes de executar qualquer exploração, é importante entender o funcionamento do módulo, seus requisitos e os possíveis efeitos sobre o sistema.

---

## 5. Post-Exploitation — Pós-Exploração

Post-Exploitation é a etapa que vem depois de uma exploração bem-sucedida.

O objetivo é compreender o nível de acesso obtido e avaliar o impacto que aquela vulnerabilidade pode causar no ambiente.

É uma fase importante porque conseguir acesso inicial não significa necessariamente possuir controle completo sobre o sistema.

Durante um teste autorizado, essa etapa pode envolver:

- Identificação do usuário e das permissões disponíveis.
- Identificação do sistema operacional.
- Análise de processos em execução.
- Verificação de interfaces e configurações de rede.
- Avaliação de privilégios.
- Identificação de possíveis caminhos de acesso a outros recursos.
- Análise do impacto da vulnerabilidade.
- Coleta controlada de evidências para documentação.

Alguns conceitos importantes dessa etapa são:

**Privilege Escalation:** processo de obtenção de permissões superiores às inicialmente disponíveis, quando existe uma condição que permite isso.

**Persistence:** técnicas que permitem manter acesso a um ambiente. Em um pentest, qualquer teste relacionado a persistência precisa estar expressamente autorizado e ter limites definidos.

**Lateral Movement:** movimentação entre sistemas dentro de uma infraestrutura, quando o escopo e as regras do teste permitem.

**Credential Access:** avaliação de riscos relacionados ao armazenamento, exposição e utilização de credenciais.

**Defense Evasion:** técnicas que podem dificultar a identificação de atividades. Também é um conceito importante para compreender como sistemas de monitoramento e defesa funcionam.

### Ferramentas utilizadas

| Ferramenta | Finalidade |
|---|---|
| Meterpreter | Ambiente de interação com sessões do Metasploit. |
| LinPEAS | Auxilia na identificação de possíveis caminhos de escalação de privilégios no Linux. |
| WinPEAS | Auxilia na identificação de possíveis caminhos de escalação de privilégios no Windows. |
| BloodHound | Analisa relações e permissões em ambientes Active Directory. |
| Impacket | Coleção de ferramentas e bibliotecas para protocolos de rede, especialmente ambientes Windows. |
| enum4linux-ng | Auxilia na enumeração de informações SMB e Windows. |

### Comandos básicos

**Meterpreter — informações do sistema:**

```text
sysinfo
```

**Identificar o usuário atual:**

```text
getuid
```

**Consultar interfaces de rede:**

```text
ipconfig
```

**Listar processos:**

```text
ps
```

**Consultar o diretório atual:**

```text
pwd
```

**Listar arquivos:**

```text
ls
```

**Colocar uma sessão em segundo plano:**

```text
background
```

**Listar sessões no Metasploit:**

```text
sessions
```

**Interagir com uma sessão específica:**

```text
sessions -i ID
```

> A pós-exploração deve ser conduzida com cuidado. Em um teste profissional, o objetivo é demonstrar o impacto de forma controlada, sem coletar dados desnecessários, alterar informações ou comprometer a disponibilidade dos sistemas.

---

## 6. Reporting & Remediation — Relatórios e Correções

Uma parte fundamental de qualquer teste de invasão é documentar os resultados.

Não basta encontrar uma vulnerabilidade: é necessário explicar o que foi encontrado, como o problema foi identificado, quais são os riscos envolvidos e o que pode ser feito para corrigi-lo.

Um bom relatório deve permitir que outra pessoa compreenda o problema e consiga reproduzir a evidência dentro das condições autorizadas.

Normalmente, um relatório técnico apresenta:

- Nome e descrição da vulnerabilidade.
- Sistema ou ativo afetado.
- Evidências da descoberta.
- Condições necessárias para reprodução.
- Impacto técnico e possíveis consequências.
- Classificação de severidade.
- Referências, como CVE e CWE, quando aplicáveis.
- Recomendações de correção.
- Resultado de uma eventual nova validação.

A etapa de correção também é importante. O trabalho não termina quando a vulnerabilidade é identificada: é necessário ajudar a compreender como reduzir o risco e verificar se a solução realmente resolveu o problema.

---

# 🧰 Ferramentas e tecnologias

Além das ferramentas mencionadas nas etapas anteriores, o CySec também reúne conteúdos sobre tecnologias e recursos que fazem parte do cotidiano de quem trabalha com segurança da informação.

### Linux e terminal

O Linux é amplamente utilizado em ambientes de segurança, especialmente em distribuições como Kali Linux.

Conhecimentos importantes:

- Navegação pelo sistema de arquivos.
- Gerenciamento de permissões.
- Processos e serviços.
- Gerenciamento de pacotes.
- Redes e interfaces.
- Shell scripting.
- Manipulação de arquivos e logs.

Comandos básicos:

```bash
pwd
ls -la
cd /var/www/html
find / -name "arquivo.txt" 2>/dev/null
grep -R "palavra" /var/log/
ps aux
ss -tulnp
ip addr
```

### Bash e automação

Bash permite automatizar tarefas e integrar diferentes ferramentas através de scripts.

Algumas aplicações:

- Automatizar processos de reconhecimento.
- Executar ferramentas em sequência.
- Processar listas de domínios e IPs.
- Filtrar resultados.
- Organizar relatórios.
- Criar pequenos utilitários para o terminal.

Exemplo simples:

```bash
#!/bin/bash

# Verifica se um domínio foi informado.
if [ -z "$1" ]; then
    echo "Uso: $0 dominio.com"
    exit 1
fi

DOMAIN="$1"

# Consulta informações DNS.
echo "[+] Consultando DNS de $DOMAIN"
dig "$DOMAIN"

# Verifica os cabeçalhos HTTP.
echo "[+] Consultando cabeçalhos HTTP"
curl -I "https://$DOMAIN"
```

### Python e programação

A programação é uma habilidade importante para quem deseja aprofundar seus conhecimentos em segurança.

Python, por exemplo, pode ser utilizado para desenvolver ferramentas próprias, automatizar tarefas, analisar resultados e integrar diferentes recursos.

Algumas possibilidades:

- Desenvolvimento de scanners.
- Análise de arquivos e logs.
- Processamento de resultados de ferramentas.
- Automação de requisições HTTP.
- Manipulação de APIs.
- Desenvolvimento de scripts de reconhecimento.
- Criação de utilitários para testes em laboratório.

Exemplo simples de requisição HTTP:

```python
import requests

url = "https://example.com"

response = requests.get(url, timeout=10)

print("Status:", response.status_code)
print("Servidor:", response.headers.get("Server"))
print("URL final:", response.url)
```

---

# 📚 Onde estudar e encontrar mais informações?

O CySec não pretende substituir as documentações oficiais ou os materiais completos de cada ferramenta. Pelo contrário, a ideia é servir como um ponto de partida e uma referência complementar.

Abaixo estão alguns sites e projetos interessantes para estudar, consultar documentações, acompanhar pesquisas e praticar em ambientes controlados.

## Documentação e referências

| Recurso | Descrição |
|---|---|
| [Kali Linux Tools](https://www.kali.org/tools/) | Catálogo de ferramentas disponíveis no Kali Linux. |
| [Kali Linux Documentation](https://www.kali.org/docs/) | Documentação oficial do Kali Linux. |
| [OWASP](https://owasp.org/) | Projetos e materiais relacionados à segurança de aplicações. |
| [OWASP WSTG](https://owasp.org/www-project-web-security-testing-guide/) | Guia de testes de segurança para aplicações web. |
| [MITRE ATT&CK](https://attack.mitre.org/) | Base de conhecimento sobre táticas e técnicas utilizadas por adversários. |
| [NIST](https://www.nist.gov/cybersecurity) | Publicações e referências sobre segurança da informação. |
| [Exploit Database](https://www.exploit-db.com/) | Base de dados de exploits e pesquisas de segurança. |
| [CVE](https://www.cve.org/) | Catálogo de identificadores de vulnerabilidades conhecidas. |
| [NVD](https://nvd.nist.gov/) | Base de dados de vulnerabilidades e informações complementares. |

## Ferramentas e projetos

| Recurso | Descrição |
|---|---|
| [Metasploit](https://www.metasploit.com/) | Plataforma para testes de invasão e validação de vulnerabilidades. |
| [ProjectDiscovery](https://projectdiscovery.io/) | Conjunto de ferramentas para reconhecimento, descoberta e análise de ativos. |
| [Nmap](https://nmap.org/) | Documentação e referência oficial do Nmap. |
| [Burp Suite](https://portswigger.net/burp) | Plataforma para análise e testes de aplicações web. |
| [SQLmap](https://sqlmap.org/) | Ferramenta para automatização de testes de SQL Injection. |
| [Shodan](https://www.shodan.io/) | Mecanismo de pesquisa de dispositivos e serviços conectados à internet. |
| [Censys](https://search.censys.io/) | Plataforma de pesquisa de infraestrutura e ativos expostos. |

## Plataformas para praticar

Estudar a teoria é importante, mas praticar é essencial para compreender como as vulnerabilidades realmente funcionam.

Existem plataformas que disponibilizam laboratórios, máquinas vulneráveis e aplicações criadas especificamente para treinamento.

| Plataforma | Descrição |
|---|---|
| [PortSwigger Web Security Academy](https://portswigger.net/web-security) | Cursos e laboratórios gratuitos sobre vulnerabilidades web. |
| [TryHackMe](https://tryhackme.com/) | Plataforma de aprendizado com salas práticas e trilhas de cibersegurança. |
| [Hack The Box](https://www.hackthebox.com/) | Laboratórios, máquinas e desafios de segurança. |
| [OverTheWire](https://overthewire.org/wargames/) | Jogos e desafios para aprender Linux, redes e segurança. |
| [OWASP Juice Shop](https://owasp.org/www-project-juice-shop/) | Aplicação web intencionalmente vulnerável para treinamento. |
| [DVWA](https://github.com/digininja/DVWA) | Aplicação web vulnerável para praticar testes de segurança. |
| [OWASP WebGoat](https://owasp.org/www-project-webgoat/) | Aplicação educacional com lições práticas sobre vulnerabilidades. |
| [OWASP Vulnerable Web Applications Directory](https://vwad.owasp.org/) | Diretório de aplicações vulneráveis para treinamento. |

---

# ⚖️ Uso responsável e autorização

As ferramentas e técnicas documentadas neste repositório podem ser utilizadas para diferentes finalidades, desde administração de sistemas e auditorias de segurança até testes de invasão e pesquisas.

Entretanto, é importante compreender que o uso de uma ferramenta não torna automaticamente uma atividade autorizada.

Antes de realizar qualquer teste, é necessário possuir autorização do responsável pelo sistema e respeitar os limites definidos para a atividade.

Alguns cuidados importantes:

- Realize testes em sistemas próprios ou ambientes nos quais você tenha autorização explícita.
- Respeite o escopo definido em programas de Bug Bounty.
- Não acesse, copie ou divulgue informações de terceiros sem autorização.
- Evite testes que possam interromper serviços ou causar perda de dados.
- Utilize laboratórios para aprender técnicas de exploração.
- Documente os procedimentos e resultados de maneira responsável.

O conhecimento sobre técnicas ofensivas também pode ser utilizado para melhorar mecanismos de defesa, identificar falhas antes que sejam exploradas e compreender melhor como proteger sistemas e infraestruturas.

---

# 🚀 Sobre a evolução do CySec

Este repositório é um projeto em andamento. Nem todas as ferramentas, técnicas e áreas estão documentadas ainda, e parte do material poderá passar por revisões conforme os estudos avançarem.

A intenção é construir uma biblioteca cada vez mais completa, com explicações que vão desde os fundamentos até funcionalidades mais avançadas.

Sempre que possível, os documentos individuais das ferramentas irão incluir:

- Introdução e funcionamento.
- Instalação e configuração.
- Sintaxe e estrutura dos comandos.
- Explicação dos principais parâmetros.
- Exemplos práticos.
- Interpretação dos resultados.
- Integração com outras ferramentas.
- Limitações e cuidados durante a utilização.
- Referências e documentações oficiais.

Se você também está estudando cibersegurança, espero que encontre aqui alguma informação útil para seus estudos.

**Aprender, testar, entender, documentar e evoluir. Esse é o propósito do CySec.** 🛡️
