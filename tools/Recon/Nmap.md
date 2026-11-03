# Nmap — Network Mapper

## O que é o Nmap?

O **Nmap (Network Mapper)** é uma ferramenta de código aberto utilizada para exploração de redes, descoberta de dispositivos e auditoria de segurança.

Seu principal objetivo é identificar dispositivos conectados a uma rede e obter informações sobre eles, como:

- Endereços IP de hosts ativos.
- Portas abertas, fechadas ou filtradas.
- Serviços e aplicações em execução.
- Versões dos serviços identificados.
- Possíveis sistemas operacionais.
- Informações adicionais através de scripts NSE.

É bastante utilizado em atividades de reconhecimento (*reconnaissance*), enumeração, administração de redes e testes de intrusão (*pentest*).

## Instalação e informações

```bash
# Atualiza a lista de pacotes disponíveis:
sudo apt update

# Instala o Nmap:
sudo apt install nmap

# Exibe a versão instalada:
nmap --version

# Exibe a lista de opções disponíveis:
nmap -h

# Abre o manual completo:
man nmap
```
## Instalação

O Nmap está disponível para Linux e Windows. A instalação pode ser feita pelo gerenciador de pacotes do sistema ou pelo instalador disponibilizado no site oficial.

### Linux

Em distribuições baseadas em Debian, como Debian, Ubuntu e Kali Linux, utilize o APT:

```bash
# Atualiza a lista de pacotes disponíveis:
sudo apt update

# Instala o Nmap:
sudo apt install nmap

# Verifica a versão instalada:
nmap --version

# Exibe a ajuda:
nmap -h
```

Em outras distribuições, utilize o gerenciador de pacotes correspondente:

```bash
# Fedora:
sudo dnf install nmap

# Arch Linux e derivados:
sudo pacman -S nmap

# openSUSE:
sudo zypper install nmap
```

**Instalação manual:**

Também é possível baixar o código-fonte pelo site oficial e compilar o Nmap manualmente. Esse método é útil quando a versão disponível nos repositórios da distribuição está desatualizada.

Documentação: https://nmap.org/book/install.html

### Windows

No Windows, a instalação é realizada por meio de um instalador executável disponibilizado pelo projeto Nmap.

1. Acesse o site oficial: https://nmap.org/download
2. Na seção Windows, baixe o instalador `nmap-<versão>-setup.exe`.
3. Execute o arquivo baixado.
4. Siga as etapas do instalador.
5. Mantenha a instalação do Npcap habilitada.
6. Selecione a opção para adicionar o Nmap ao PATH, caso esteja disponível.
7. Finalize a instalação.

**O que é o Npcap?**

O Npcap é uma biblioteca utilizada pelo Nmap no Windows para capturar e transmitir pacotes de rede. Ele é necessário para determinados tipos de scan e funcionalidades que dependem de acesso direto aos pacotes.

O instalador também pode oferecer componentes adicionais:

| Componente | Função |
|---|---|
| Nmap | Ferramenta principal de escaneamento. |
| Npcap | Captura e transmissão de pacotes de rede. |
| Zenmap | Interface gráfica para utilizar o Nmap. |
| Ncat | Ferramenta para comunicação e transferência de dados pela rede. |
| Ndiff | Compara resultados de diferentes scans. |
| Nping | Ferramenta para geração e análise de pacotes de rede. |

**Verificando a instalação:**

Após concluir a instalação, abra o PowerShell ou CMD e execute:

```powershell
# Verifica a versão instalada:
nmap --version

# Exibe as opções disponíveis:
nmap -h

# Verifica onde o executável está localizado:
where.exe nmap

# Executa um scan de teste:
nmap scanme.nmap.org
```

Caso o comando `nmap` não seja reconhecido, verifique se o diretório de instalação foi adicionado à variável de ambiente PATH. Normalmente, basta abrir um novo terminal após a instalação.

**Observação:** a instalação do Nmap não significa que todas as funcionalidades estarão disponíveis sem privilégios administrativos. Alguns tipos de scan precisam de permissões elevadas e, no Windows, dependem também do Npcap.

## Sintaxe básica

```bash
nmap [opções] [alvo]
```

- `nmap`: executa a ferramenta.
- `[opções]`: define o tipo de scan e as informações que serão coletadas.
- `[alvo]`: endereço IP, hostname ou faixa de rede que será analisada.

```bash
# Analisa um único endereço IP:
nmap 192.168.1.100

# Analisa um hostname:
nmap exemplo.com

# Analisa vários endereços:
nmap 192.168.1.100 192.168.1.101

# Analisa uma faixa de endereços utilizando CIDR:
nmap 192.168.1.0/24

# Analisa um intervalo de endereços:
nmap 192.168.1.1-50

# Lê os alvos de um arquivo:
nmap -iL targets.txt

# Exclui um endereço da análise:
nmap 192.168.1.0/24 --exclude 192.168.1.10
```

`/24` representa uma rede com 24 bits destinados à identificação da rede. Em IPv4, esse exemplo corresponde a até 256 endereços.

---

## 1. Descoberta de hosts

A descoberta de hosts (*Host Discovery*) permite identificar quais dispositivos estão ativos em uma rede antes de realizar uma análise mais detalhada.

```bash
# Identifica os dispositivos ativos na rede:
nmap -sn 192.168.1.0/24

# Analisa somente um endereço IP para verificar sua disponibilidade:
nmap -sn 192.168.1.100

# Lista os alvos sem enviar pacotes para eles:
nmap -sL 192.168.1.0/24

# Desativa a descoberta de hosts e considera todos os alvos ativos:
nmap -Pn 192.168.1.100

# Realiza descoberta utilizando requisições ICMP Echo:
nmap -PE -sn 192.168.1.0/24

# Realiza descoberta ARP na rede local:
nmap -PR -sn 192.168.1.0/24
```

**Parâmetros:**

| Parâmetro | Função |
|---|---|
| `-sn` | Faz descoberta de hosts sem realizar scan de portas. |
| `-sL` | Apenas lista os alvos especificados, sem enviar sondagens aos hosts. |
| `-Pn` | Ignora a descoberta de hosts e tenta analisar todos os alvos informados. |
| `-PE` | Utiliza ICMP Echo Request na descoberta. |
| `-PR` | Utiliza requisições ARP na rede Ethernet local. |
| `-n` | Desativa a resolução DNS, evitando consultas de nomes. |
| `-R` | Solicita resolução DNS reversa para todos os alvos. |

**Observação:** `-Pn` não confirma que um dispositivo está ativo. Ele apenas faz o Nmap prosseguir com o scan mesmo sem uma resposta à descoberta inicial.

---

## 2. Escaneamento de portas

O escaneamento de portas (*Port Scanning*) identifica quais portas estão disponíveis em um dispositivo e qual é o estado de cada uma.

Por padrão, o Nmap analisa as 1.000 portas TCP mais comuns quando nenhum tipo de porta é especificado.

```bash
# Scan padrão:
nmap 192.168.1.100

# Analisa somente a porta 80:
nmap -p 80 192.168.1.100

# Analisa várias portas específicas:
nmap -p 21,22,80,443 192.168.1.100

# Analisa um intervalo de portas:
nmap -p 1-1000 192.168.1.100

# Analisa todas as portas TCP:
nmap -p- 192.168.1.100

# Analisa as 100 portas mais comuns:
nmap -F 192.168.1.100

# Analisa as 20 portas mais comuns:
nmap --top-ports 20 192.168.1.100

# Exibe somente as portas identificadas como abertas:
nmap --open 192.168.1.100
```

### Estados das portas

O Nmap identifica seis estados possíveis:

| Estado | Significado |
|---|---|
| `open` | Existe uma aplicação aceitando conexões ou pacotes naquela porta. |
| `closed` | A porta está acessível, mas não existe serviço escutando nela. |
| `filtered` | Algum filtro impede determinar se a porta está aberta ou fechada. |
| `unfiltered` | A porta responde às sondagens, mas não foi possível determinar se está aberta ou fechada. |
| `open|filtered` | Não foi possível diferenciar uma porta aberta de uma porta filtrada. |
| `closed|filtered` | Não foi possível diferenciar uma porta fechada de uma porta filtrada. |

**Importante:** esses estados representam o que o Nmap conseguiu observar durante o scan. Uma porta filtrada, por exemplo, não significa necessariamente que esteja fechada.

---

## 3. Tipos de scan

O Nmap oferece diferentes técnicas para analisar portas. Cada uma utiliza uma abordagem diferente para interpretar as respostas do alvo.

### TCP SYN Scan

```bash
# Executa um SYN Scan:
sudo nmap -sS 192.168.1.100
```

O `-sS` envia pacotes TCP SYN para verificar o estado das portas, sem completar o processo normal de estabelecimento de uma conexão TCP.

É frequentemente chamado de *Half-Open Scan*.

### TCP Connect Scan

```bash
# Executa um TCP Connect Scan:
nmap -sT 192.168.1.100
```

O `-sT` utiliza a chamada de sistema `connect()` para estabelecer uma conexão TCP completa com as portas analisadas.

É utilizado quando o usuário não possui privilégios para realizar um SYN Scan.

### UDP Scan

```bash
# Analisa portas UDP:
sudo nmap -sU 192.168.1.100

# Analisa portas UDP específicas:
sudo nmap -sU -p 53,67,123,161 192.168.1.100
```

O `-sU` verifica serviços que utilizam o protocolo UDP, como DNS, DHCP, NTP e SNMP.

Scans UDP podem demorar mais porque muitos serviços não respondem a pacotes sem conteúdo específico.

### ACK Scan

```bash
# Executa um ACK Scan:
sudo nmap -sA 192.168.1.100
```

O `-sA` utiliza pacotes TCP com a flag ACK para analisar como as portas são tratadas pelos filtros de rede.

É útil para investigar regras de firewall, mas não determina diretamente quais portas estão abertas.

### FIN, NULL e Xmas Scan

```bash
# FIN Scan:
sudo nmap -sF 192.168.1.100

# NULL Scan:
sudo nmap -sN 192.168.1.100

# Xmas Scan:
sudo nmap -sX 192.168.1.100
```

Esses scans utilizam combinações específicas de flags TCP:

| Tipo | Característica |
|---|---|
| `-sF` | Envia pacotes com a flag FIN. |
| `-sN` | Envia pacotes sem flags TCP definidas. |
| `-sX` | Envia pacotes com as flags FIN, PSH e URG. |

Os resultados dependem da implementação TCP do sistema analisado e podem ser menos confiáveis em determinados sistemas operacionais.

---

## 4. Detecção de serviços e versões

A detecção de serviços (*Service Detection*) permite identificar quais aplicações estão executando nas portas encontradas.

Além do nome do serviço, o Nmap pode identificar fabricante, aplicação e versão.

```bash
# Identifica os serviços encontrados:
nmap -sV 192.168.1.100

# Analisa portas específicas e identifica suas versões:
nmap -sV -p 21,22,80,443 192.168.1.100

# Utiliza sondagens mais leves para identificar versões:
nmap -sV --version-light 192.168.1.100

# Utiliza todas as sondagens disponíveis para detecção:
nmap -sV --version-all 192.168.1.100
```

**Parâmetros:**

| Parâmetro | Função |
|---|---|
| `-sV` | Ativa a detecção de serviços e versões. |
| `--version-light` | Utiliza menos sondagens para acelerar a identificação. |
| `--version-all` | Tenta todas as sondagens disponíveis. |
| `--version-intensity` | Define a intensidade da detecção, de 0 a 9. |

Exemplo:

```bash
# Define intensidade 9 para a detecção de versões:
nmap -sV --version-intensity 9 192.168.1.100
```

Quanto maior a intensidade, maior a quantidade de sondagens que podem ser realizadas, aumentando o tempo de execução.

---

## 5. Detecção de sistema operacional

O Nmap consegue tentar identificar o sistema operacional de um dispositivo analisando características das respostas recebidas durante o scan.

```bash
# Tenta identificar o sistema operacional:
sudo nmap -O 192.168.1.100

# Combina detecção de sistema operacional com detecção de versões:
sudo nmap -O -sV 192.168.1.100

# Permite uma tentativa de identificação mais agressiva:
sudo nmap -O --osscan-guess 192.168.1.100
```

**Parâmetros:**

| Parâmetro | Função |
|---|---|
| `-O` | Ativa a detecção de sistema operacional. |
| `--osscan-guess` | Tenta apresentar uma identificação provável quando não há correspondência exata. |
| `--osscan-limit` | Limita a detecção de SO a alvos considerados adequados para essa análise. |

A identificação não é garantida. Firewalls, filtros e configurações de rede podem dificultar a obtenção de resultados precisos.

---

## 6. Scan agressivo

A opção `-A` ativa um conjunto de funcionalidades de reconhecimento mais abrangente.

```bash
# Executa um scan agressivo:
sudo nmap -A 192.168.1.100

# Combina scan agressivo com análise de todas as portas TCP:
sudo nmap -A -p- 192.168.1.100
```

O `-A` habilita:

- Detecção de sistema operacional (`-O`).
- Detecção de serviços e versões (`-sV`).
- Scripts NSE padrão (`-sC`).
- Traceroute (`--traceroute`).

**Observação:** `-A` não significa que o Nmap irá explorar automaticamente todas as vulnerabilidades encontradas. Ele realiza uma análise mais abrangente do alvo.

---

## 7. Nmap Scripting Engine (NSE)

O NSE é um mecanismo integrado ao Nmap que permite executar scripts para automatizar tarefas de reconhecimento e análise.

Os scripts são escritos em Lua e podem realizar diferentes atividades, como:

- Descoberta de informações adicionais.
- Enumeração de serviços.
- Verificação de configurações.
- Identificação de possíveis vulnerabilidades.
- Testes específicos de protocolos.

### Executando scripts

```bash
# Executa os scripts padrão do Nmap:
nmap -sC 192.168.1.100

# Executa um script específico:
nmap --script ftp-anon 192.168.1.100

# Executa dois scripts:
nmap --script ftp-anon,ftp-syst 192.168.1.100

# Executa scripts relacionados a HTTP:
nmap --script "http-*" 192.168.1.100

# Executa scripts da categoria discovery:
nmap --script discovery 192.168.1.100

# Executa scripts da categoria vuln:
nmap --script vuln 192.168.1.100
```

### Categorias de scripts NSE

| Categoria | Função |
|---|---|
| `auth` | Testes relacionados à autenticação. |
| `broadcast` | Descoberta de dispositivos por mensagens broadcast. |
| `brute` | Testes de autenticação por força bruta. |
| `default` | Scripts executados por padrão com `-sC`. |
| `discovery` | Coleta informações adicionais sobre os alvos. |
| `dos` | Scripts relacionados a testes de negação de serviço. |
| `exploit` | Scripts relacionados à exploração de vulnerabilidades. |
| `external` | Consulta serviços externos. |
| `fuzzer` | Envia dados de teste para identificar comportamentos inesperados. |
| `intrusive` | Scripts que podem interferir no funcionamento do alvo. |
| `malware` | Investiga possíveis indicadores relacionados a malware. |
| `safe` | Scripts classificados como seguros pelos mantenedores. |
| `version` | Complementa a identificação de serviços e versões. |
| `vuln` | Verifica possíveis vulnerabilidades conhecidas. |

### Exemplos de scripts

```bash
# Verifica se o FTP permite acesso anônimo:
nmap -p 21 --script ftp-anon 192.168.1.100

# Obtém informações do sistema informado pelo servidor FTP:
nmap -p 21 --script ftp-syst 192.168.1.100

# Obtém informações sobre o servidor HTTP:
nmap -p 80 --script http-title,http-server-header 192.168.1.100

# Enumera informações do serviço SMB:
nmap -p 445 --script smb-os-discovery 192.168.1.100

# Verifica possíveis vulnerabilidades associadas ao SMB:
nmap -p 445 --script smb-vuln* 192.168.1.100

# Executa scripts padrão e identifica versões:
nmap -sC -sV 192.168.1.100
```

### Localizando scripts NSE

```bash
# Localiza o diretório de scripts do Nmap:
find /usr/share/nmap/scripts -name "*.nse"

# Procura um script específico:
find /usr/share/nmap/scripts -name "ftp-anon.nse"

# Pesquisa scripts relacionados a FTP:
ls /usr/share/nmap/scripts/ftp-*

# Consulta informações de um script:
nmap --script-help ftp-anon

# Atualiza o banco de dados de scripts:
sudo nmap --script-updatedb
```

**Atenção:** scripts NSE não são todos inofensivos. Algumas categorias podem realizar tentativas de autenticação, gerar tráfego intenso ou interferir no serviço analisado. Leia a documentação do script antes de executá-lo.

---

## 8. Controle de velocidade

O Nmap permite ajustar a velocidade dos scans por meio de perfis de temporização.

```bash
# T0: extremamente lento:
nmap -T0 192.168.1.100

# T1: muito lento:
nmap -T1 192.168.1.100

# T2: mais lento:
nmap -T2 192.168.1.100

# T3: velocidade padrão:
nmap -T3 192.168.1.100

# T4: mais rápido:
nmap -T4 192.168.1.100

# T5: extremamente rápido:
nmap -T5 192.168.1.100
```

| Parâmetro | Característica |
|---|---|
| `-T0` | Paranoid |
| `-T1` | Sneaky |
| `-T2` | Polite |
| `-T3` | Normal |
| `-T4` | Aggressive |
| `-T5` | Insane |

Aumentar a velocidade pode gerar mais tráfego, perder respostas e reduzir a precisão em determinadas redes. O perfil `-T3` é o padrão.

---

## 9. Exibição e armazenamento de resultados

O Nmap permite salvar os resultados em diferentes formatos, facilitando a documentação e a análise posterior.

```bash
# Exibe mais informações durante o scan:
nmap -v 192.168.1.100

# Aumenta o nível de detalhamento:
nmap -vv 192.168.1.100

# Exibe o motivo pelo qual uma porta recebeu determinado estado:
nmap --reason 192.168.1.100

# Salva o resultado em formato normal:
nmap -oN resultado.txt 192.168.1.100

# Salva o resultado em XML:
nmap -oX resultado.xml 192.168.1.100

# Salva o resultado em formato grepable:
nmap -oG resultado.gnmap 192.168.1.100

# Salva simultaneamente nos formatos normal, XML e grepable:
nmap -oA resultado 192.168.1.100
```

| Parâmetro | Função |
|---|---|
| `-v` | Aumenta o detalhamento da saída. |
| `-vv` | Aumenta ainda mais o detalhamento. |
| `--reason` | Exibe o motivo da classificação de cada porta. |
| `-oN` | Salva a saída em formato normal. |
| `-oX` | Salva a saída em XML. |
| `-oG` | Salva a saída em formato grepable. |
| `-oA` | Salva nos três formatos anteriores. |

**Dica:** o formato XML é especialmente útil quando os resultados serão processados por scripts em Python ou outras ferramentas.

---

## 10. Traceroute

O traceroute permite identificar os roteadores intermediários entre a máquina que executa o Nmap e o alvo.

```bash
# Identifica a rota até o alvo:
nmap --traceroute 192.168.1.100

# Combina traceroute com detecção de serviços:
nmap -sV --traceroute 192.168.1.100
```

O resultado pode ajudar a entender o caminho percorrido pelos pacotes e identificar possíveis pontos de filtragem.

---

## 11. Exemplos de utilização

### Descobrir dispositivos na rede local

```bash
# Identifica os hosts ativos na rede:
nmap -sn 192.168.1.0/24
```

### Realizar reconhecimento inicial de um servidor

```bash
# Identifica portas abertas e serviços disponíveis:
nmap -sV 192.168.1.100
```

### Enumerar serviços e versões em todas as portas TCP

```bash
# Analisa todas as portas TCP e tenta identificar os serviços:
sudo nmap -sV -p- 192.168.1.100
```

### Obter informações mais completas de um servidor

```bash
# Combina identificação de SO, versões, scripts padrão e traceroute:
sudo nmap -A 192.168.1.100
```

### Analisar um servidor FTP

```bash
# Analisa a porta FTP e executa scripts de enumeração:
nmap -sV -p 21 --script ftp-anon,ftp-syst 192.168.1.100
```

### Analisar serviços HTTP

```bash
# Identifica a versão do serviço e coleta informações da página:
nmap -sV -p 80,443 --script http-title,http-server-header 192.168.1.100
```

### Realizar uma análise TCP e UDP

```bash
# Analisa as portas TCP e UDP mais comuns:
sudo nmap -sS -sU 192.168.1.100
```

### Salvar os resultados de uma análise completa

```bash
# Analisa o alvo e salva os resultados em três formatos:
sudo nmap -sV -O -p- -oA analise 192.168.1.100
```

---

## 12. Integração com outras ferramentas

O Nmap pode ser utilizado em conjunto com ferramentas de automação, scripts Bash, Python e outras ferramentas de segurança.

### Utilizando grep

```bash
# Executa o Nmap e filtra a saída para mostrar somente linhas
# que contenham a palavra open:
nmap 192.168.1.100 | grep "open"
```

### Utilizando Bash

```bash
# Recebe o endereço IP através de uma variável:
TARGET="192.168.1.100"

# Executa o scan utilizando o endereço armazenado:
nmap -sV "$TARGET"
```

### Utilizando Python

```python
import subprocess

target = "192.168.1.100"

# Executa o Nmap e captura a saída do terminal:
resultado = subprocess.run(
    ["nmap", "-sV", target],
    capture_output=True,
    text=True
)

# Exibe o resultado:
print(resultado.stdout)

# Exibe possíveis mensagens de erro:
print(resultado.stderr)

# Consulta o código de saída:
print(resultado.returncode)
```

O `subprocess` permite executar programas externos e capturar suas saídas, possibilitando automatizar análises e processar os resultados utilizando Python.

---

## 13. Referência rápida

| Comando | Função |
|---|---|
| `nmap ALVO` | Scan padrão. |
| `nmap -sn ALVO` | Descoberta de hosts sem scan de portas. |
| `nmap -Pn ALVO` | Ignora descoberta de hosts. |
| `nmap -p 80 ALVO` | Analisa uma porta específica. |
| `nmap -p 1-1000 ALVO` | Analisa um intervalo de portas. |
| `nmap -p- ALVO` | Analisa todas as portas TCP. |
| `nmap -F ALVO` | Scan rápido das portas mais comuns. |
| `nmap -sS ALVO` | TCP SYN Scan. |
| `nmap -sT ALVO` | TCP Connect Scan. |
| `nmap -sU ALVO` | UDP Scan. |
| `nmap -sA ALVO` | ACK Scan. |
| `nmap -sV ALVO` | Identifica serviços e versões. |
| `nmap -O ALVO` | Tenta identificar o sistema operacional. |
| `nmap -A ALVO` | Scan agressivo. |
| `nmap -sC ALVO` | Executa scripts NSE padrão. |
| `nmap --script SCRIPT ALVO` | Executa um script NSE específico. |
| `nmap -T4 ALVO` | Utiliza temporização mais rápida. |
| `nmap --open ALVO` | Exibe somente portas abertas. |
| `nmap -oN arquivo.txt ALVO` | Salva o resultado em formato normal. |
| `nmap -oX arquivo.xml ALVO` | Salva o resultado em XML. |
| `nmap -oA arquivo ALVO` | Salva em vários formatos. |
| `nmap --traceroute ALVO` | Identifica a rota até o alvo. |

---

## 14. Documentação oficial

- [Nmap — Site oficial](https://nmap.org/)
- [Nmap — Guia de referência](https://nmap.org/book/man.html)
- [Nmap — Guia de referência em português](https://nmap.org/man/pt_BR/)
- [Nmap — Descoberta de hosts](https://nmap.org/book/man-host-discovery.html)
- [Nmap — Técnicas de scan](https://nmap.org/book/man-port-scanning-techniques.html)
- [Nmap — Detecção de serviços e versões](https://nmap.org/book/man-version-detection.html)
- [Nmap — Nmap Scripting Engine](https://nmap.org/book/nse.html)
- [Nmap — Documentação dos scripts NSE](https://nmap.org/nsedoc/)

---

## 15. Observações

- O Nmap não garante que todos os dispositivos ou serviços de uma rede serão identificados.
- Uma porta aberta indica a existência de um serviço acessível, não necessariamente uma vulnerabilidade.
- A identificação de versões pode ajudar a direcionar investigações de segurança, mas não confirma a existência de uma falha.
- A ausência de respostas pode ser causada por firewalls, filtros ou configurações do próprio dispositivo.
- Alguns tipos de scan precisam de privilégios administrativos, por isso é comum utilizar `sudo`.
- A escolha das opções depende do objetivo da análise e das características da rede.
- Execute scans somente em redes e dispositivos próprios ou para os quais você tenha autorização.
