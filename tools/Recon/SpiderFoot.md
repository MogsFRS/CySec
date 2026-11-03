# SpiderFoot — OSINT Automation

## O que é o SpiderFoot?

O **SpiderFoot** é uma ferramenta de OSINT que automatiza a coleta, análise e correlação de informações públicas sobre um alvo.

Diferentemente de ferramentas focadas exclusivamente em DNS, o SpiderFoot trabalha com diversos tipos de informação e utiliza módulos para consultar diferentes fontes.

Ele possui uma interface web e também pode ser utilizado pelo terminal.

Entre suas funcionalidades estão:

- Descoberta de domínios e subdomínios.
- Coleta de endereços de e-mail.
- Identificação de endereços IP e redes.
- Pesquisa de nomes de pessoas, usuários e telefones.
- Consultas a serviços de inteligência e reputação.
- Pesquisa em fontes de vazamentos de dados.
- Identificação de possíveis subdomain takeovers.
- Coleta de informações de certificados.
- Análise de metadados.
- Consultas a serviços como Shodan e Have I Been Pwned, quando configurados.
- Correlação de informações encontradas por diferentes módulos.

**Linguagem:** Python  
**Categoria:** OSINT / Information Gathering / Attack Surface Mapping

## 1. Como funciona?

O SpiderFoot trabalha com módulos. Cada módulo é responsável por uma atividade específica, como consultar um serviço externo, identificar um hostname ou pesquisar um endereço IP.

Os módulos podem compartilhar os resultados encontrados.

Exemplo simplificado:

```text
              DOMÍNIO
                 |
                 v
          SPIDERFOOT
                 |
       +---------+---------+
       |         |         |
       v         v         v
      DNS     CERTIFICADOS EMAIL
       |         |         |
       v         v         v
  SUBDOMÍNIOS  HOSTS     ENDEREÇOS
       |         |         |
       +---------+---------+
                 |
                 v
          CORRELAÇÃO
                 |
                 v
           RESULTADOS
```

A correlação permite relacionar informações que, isoladamente, poderiam parecer desconectadas.

## 2. Instalação

### Kali Linux / Debian

A instalação pelo código-fonte é uma opção para manter o ambiente isolado das dependências do sistema.

```bash
# Instala os pacotes necessários
sudo apt update
sudo apt install git python3 python3-venv python3-pip

# Clona o repositório oficial
git clone https://github.com/smicallef/spiderfoot.git

# Entra na pasta do projeto
cd spiderfoot

# Cria um ambiente virtual Python
python3 -m venv .venv

# Ativa o ambiente virtual
source .venv/bin/activate

# Instala as dependências do projeto
python -m pip install -r requirements.txt
```

O ambiente virtual evita instalar as dependências diretamente no Python gerenciado pelo sistema operacional.

## 3. Iniciando a interface web

```bash
# Inicia a interface web somente no endereço local
python3 sf.py -l 127.0.0.1:5001
```

Depois de iniciar o servidor, abra no navegador:

```text
http://127.0.0.1:5001
```

O endereço `127.0.0.1` faz com que a interface escute somente na própria máquina.

Para interromper o servidor, utilize:

```text
CTRL + C
```

**Atenção:** não exponha a interface em uma rede pública sem configurar controles de acesso e as proteções adequadas.

## 4. Utilizando a interface web

O fluxo básico de utilização é:

1. Inicie o SpiderFoot.
2. Abra a interface pelo navegador.
3. Acesse a área de criação de uma nova varredura.
4. Informe o alvo.
5. Escolha o tipo de investigação ou os módulos.
6. Revise as atividades selecionadas.
7. Inicie a coleta.
8. Acompanhe os resultados e as relações identificadas.

O SpiderFoot permite trabalhar com diferentes tipos de alvos:

- Domínios.
- Hostnames.
- Endereços IP.
- Redes em formato CIDR.
- ASNs.
- E-mails.
- Nomes de pessoas.
- Nomes de usuário.
- Números de telefone.

A disponibilidade de cada módulo depende do tipo de alvo e das fontes configuradas.

## 5. Tipos de investigação

A ferramenta possui perfis que selecionam automaticamente grupos de módulos.

| Perfil | Finalidade |
|---|---|
| `passive` | Coleta baseada em fontes passivas |
| `footprint` | Mapeamento da presença e infraestrutura do alvo |
| `investigate` | Investigação mais ampla do alvo |
| `all` | Utiliza todos os módulos disponíveis |

A seleção automática facilita o início da investigação. Para maior controle, também é possível selecionar módulos específicos.

Os perfis e módulos disponíveis dependem da versão instalada.

## 6. Utilizando pelo terminal (CLI)

O SpiderFoot também permite realizar investigações sem abrir a interface web.

Sintaxe geral:

```bash
python3 sf.py -s <alvo> [opções]
```

### Coleta passiva

```bash
# Realiza uma investigação passiva sobre o domínio
python3 sf.py -s example.com -u passive
```

O perfil `passive` seleciona módulos voltados à coleta passiva.

Mesmo nesse perfil, revise os módulos disponíveis e suas configurações antes de executar a coleta. A definição de passivo depende do comportamento de cada módulo e da fonte consultada.

### Investigação de footprint

```bash
# Executa a investigação utilizando o perfil footprint
python3 sf.py -s example.com -u footprint
```

### Investigação mais ampla

```bash
# Executa a investigação utilizando o perfil investigate
python3 sf.py -s example.com -u investigate
```

### Utilizando módulos específicos

```bash
# Executa a investigação utilizando módulos selecionados
python3 sf.py -s example.com -m sfp_dnsresolve,sfp_dnsbrute
```

Os nomes dos módulos são exemplos. Confira os módulos realmente disponíveis na sua instalação antes de utilizá-los.

## 7. Listando módulos e tipos de eventos

```bash
# Exibe os módulos disponíveis
python3 sf.py -M

# Exibe os tipos de eventos que podem ser coletados
python3 sf.py -T
```

Esses comandos ajudam a descobrir o que a instalação atual consegue pesquisar.

A lista de módulos é extensa e pode variar de acordo com a versão e as dependências instaladas.

## 8. Selecionando tipos de eventos

A opção `-t` permite definir quais tipos de eventos devem ser coletados.

```bash
# Coleta eventos relacionados a DNS e e-mails
python3 sf.py -s example.com -t INTERNET_NAME,EMAILADDR
```

É possível informar mais de um tipo, separados por vírgula.

Os nomes de eventos aceitos devem ser consultados com:

```bash
# Lista os tipos de eventos disponíveis
python3 sf.py -T
```

A opção `-t` seleciona tipos de informação, enquanto `-m` seleciona módulos. São formas diferentes de controlar a investigação.

## 9. Exportando resultados

A opção `-o` define o formato de saída no modo CLI.

```bash
# Exibe os resultados em formato de tabela
python3 sf.py -s example.com -u passive -o tab

# Exporta os resultados em CSV
python3 sf.py -s example.com -u passive -o csv

# Exporta os resultados em JSON
python3 sf.py -s example.com -u passive -o json
```

| Formato | Utilização |
|---|---|
| `tab` | Leitura diretamente no terminal |
| `csv` | Planilhas e análise de dados |
| `json` | Integração com scripts e automações |

## 10. Opções principais da CLI

| Opção | Descrição |
|---|---|
| `-h` | Exibe a ajuda |
| `-d` | Ativa o modo de depuração |
| `-l IP:porta` | Inicia o servidor web no endereço indicado |
| `-s ALVO` | Define o alvo da investigação |
| `-u PERFIL` | Seleciona um perfil de investigação |
| `-m MODULOS` | Define módulos específicos |
| `-M` | Lista os módulos disponíveis |
| `-t TIPOS` | Define os tipos de eventos |
| `-T` | Lista os tipos de eventos |
| `-o FORMATO` | Define a saída: tab, csv ou json |
| `-C ID` | Executa a correlação sobre uma varredura existente |

Consulte a ajuda da sua instalação para conferir as opções completas:

```bash
python3 sf.py -h
```

## 11. API keys e integrações

Alguns módulos utilizam serviços externos que exigem API keys.

O SpiderFoot possui integrações com serviços de inteligência e pesquisa, como:

- Shodan.
- Have I Been Pwned.
- GreyNoise.
- AlienVault OTX.
- AbuseIPDB.
- Outros provedores de inteligência.

A configuração depende de cada módulo.

Antes de utilizar um serviço, verifique:

1. Se ele exige uma API key.
2. Se existe uma modalidade gratuita.
3. Quais são os limites de consultas.
4. Quais dados são enviados ao provedor.
5. Quais permissões a chave concede.

Não publique credenciais em repositórios ou relatórios.

## 12. Entendendo os resultados

O SpiderFoot pode produzir diversos tipos de eventos.

| Evento ou informação | Significado |
|---|---|
| INTERNET_NAME | Nome de host ou domínio identificado |
| IP_ADDRESS | Endereço IP encontrado |
| EMAILADDR | Endereço de e-mail |
| NETBLOCK_OWNER | Informação sobre proprietário de uma rede |
| ASN | Sistema autônomo associado à infraestrutura |
| PHONE_NUMBER | Número de telefone encontrado |
| HUMAN_NAME | Nome de pessoa identificado |
| SOCIAL_MEDIA | Informação relacionada a perfis sociais |
| VULNERABILITY | Informação classificada como vulnerabilidade por uma fonte ou módulo |

Os nomes dos eventos e suas classificações podem variar entre versões.

Um evento classificado como vulnerabilidade não deve ser considerado confirmação automática. É necessário verificar a origem, a evidência e as condições do achado.

## 13. Correlação de resultados

Uma das principais vantagens do SpiderFoot é a possibilidade de relacionar informações encontradas por diferentes módulos.

Por exemplo:

```text
example.com
     |
     +---- mail.example.com
     |          |
     |          +---- IP encontrado
     |
     +---- dev.example.com
     |          |
     |          +---- Certificado identificado
     |
     +---- contato@example.com
```

Essa relação ajuda a identificar conexões entre domínios, endereços IP, certificados e outras informações públicas.

A correlação não garante que todos os dados pertençam à mesma organização. É necessário validar os vínculos encontrados.

## 14. SpiderFoot e outras ferramentas

| Ferramenta | Principal objetivo |
|---|---|
| DNSenum | Enumeração DNS, brute force e AXFR |
| DNSRecon | Enumeração e análise de registros DNS |
| theHarvester | Coleta de informações públicas sobre domínios e organizações |
| SpiderFoot | Automação e correlação de OSINT em várias fontes |

O SpiderFoot pode complementar as outras ferramentas, pois reúne informações de diferentes categorias e fontes em uma única investigação.

## 15. Fluxo de reconhecimento

Um fluxo possível para um domínio autorizado:

### Etapa 1 — Coleta inicial

```bash
# Coleta informações públicas com o theHarvester
theHarvester -d example.com -b subdomains,emails
```

### Etapa 2 — Enumeração DNS

```bash
# Consulta registros e informações DNS
dnsrecon -d example.com -t std
```

### Etapa 3 — Investigação ampla

```bash
# Inicia uma investigação passiva no SpiderFoot
python3 sf.py -s example.com -u passive
```

### Etapa 4 — Análise

Compare os resultados, remova duplicidades e valide os dados antes de iniciar qualquer teste ativo.

## 16. Limitações e observações

- A quantidade de resultados depende dos módulos e fontes habilitados.
- Alguns módulos precisam de API keys.
- Serviços externos podem impor limites de consultas.
- Resultados podem estar desatualizados ou apresentar associações incorretas.
- Alguns módulos podem realizar consultas diretas ao alvo.
- Uma coleta passiva não significa que todos os módulos sejam passivos.
- A presença de um hostname, e-mail ou IP não confirma uma vulnerabilidade.
- Uma investigação ampla pode demorar e gerar muitos resultados.
- Revise o escopo e as atividades dos módulos antes de iniciar uma coleta.

## Referências

- Repositório oficial: https://github.com/smicallef/spiderfoot
- Documentação: https://www.spiderfoot.net/documentation/
- Lista de módulos: https://github.com/smicallef/spiderfoot/tree/master/modules
- Código principal e opções da CLI: https://github.com/smicallef/spiderfoot/blob/master/sf.py
