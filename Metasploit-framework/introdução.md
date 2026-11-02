# Metasploit Framework — MSFConsole

## 1. Introdução

O **MSFConsole** é a interface de linha de comando principal do Metasploit Framework.

Por meio dele, é possível pesquisar, configurar e executar módulos, gerenciar sessões, utilizar payloads e interagir com diferentes recursos do framework.

O Metasploit é organizado em módulos, cada um desenvolvido para uma finalidade específica.

Entre suas principais funcionalidades estão:

- Pesquisa de módulos.
- Execução de exploits.
- Verificação de serviços e vulnerabilidades.
- Configuração de payloads.
- Gerenciamento de conexões e sessões.
- Execução de tarefas em segundo plano.
- Automação por meio de arquivos RC.

O MSFConsole é especialmente útil porque reúne essas funcionalidades em uma única interface.

## 2. Inicializando o MSFConsole

Para iniciar o Metasploit:

```bash
msfconsole
```

Após a inicialização, será exibido o prompt:

```text
msf6 >
```

O número pode variar de acordo com a versão instalada.

### Opção -q

```bash
msfconsole -q
```

Inicia o MSFConsole sem exibir o banner de apresentação.

### Opção -r

```bash
msfconsole -r arquivo.rc
```

Inicia o MSFConsole e executa os comandos presentes em um arquivo RC.

### Opção -h

```bash
msfconsole -h
```

Exibe as opções disponíveis para inicialização.

## 3. Entendendo a interface

O prompt do MSFConsole muda conforme o contexto atual.

Exemplos:

```text
msf6 >
```

Indica que o usuário está no console principal.

```text
msf6 auxiliary(scanner/http/title) >
```

Indica que um módulo auxiliar foi selecionado.

```text
meterpreter >
```

Indica que o usuário está dentro de uma sessão Meterpreter.

Essa diferença é importante porque os comandos disponíveis dependem da interface atual.

## 4. Estrutura de módulos

O Metasploit utiliza diferentes tipos de módulos.

| Tipo | Descrição |
|---|---|
| `exploit` | Módulos utilizados para explorar vulnerabilidades. |
| `auxiliary` | Ferramentas auxiliares para reconhecimento, análise e testes. |
| `payload` | Código ou funcionalidade executada no sistema de destino. |
| `post` | Módulos utilizados após o estabelecimento de uma sessão. |
| `encoder` | Módulos responsáveis por codificar dados. |
| `nop` | Módulos que geram instruções sem operação funcional significativa. |
| `evasion` | Módulos relacionados a técnicas de evasão. |

### Exploit

Um exploit é um código ou procedimento que aproveita uma vulnerabilidade para produzir um comportamento não previsto pelo sistema.

### Auxiliary

Módulos auxiliares são utilizados em tarefas como identificação de serviços, enumeração e verificação de configurações.

### Payload

É o código ou conjunto de funcionalidades que será executado após uma exploração ou por outro mecanismo de entrega.

### Post

São módulos utilizados após a obtenção de uma sessão, permitindo realizar tarefas de análise e administração no ambiente autorizado.

### Encoder

Transforma a representação dos dados de um payload.

### NOP

Representa instruções que não realizam uma operação funcional significativa.

### Evasion

Reúne módulos relacionados a técnicas de evasão de mecanismos de segurança. Sua disponibilidade e eficácia dependem do ambiente e das proteções existentes.

## 5. Pesquisa de módulos

O comando `search` permite localizar módulos dentro do Metasploit.

Sintaxe:

```bash
search <TERMO>
```

Exemplos:

```bash
search tomcat
```

Pesquisa módulos relacionados ao Tomcat.

```bash
search ssh
```

Pesquisa módulos relacionados ao SSH.

```bash
search type:exploit
```

Exibe módulos do tipo exploit.

```bash
search type:auxiliary
```

Exibe módulos auxiliares.

```bash
search type:post
```

Exibe módulos post-exploitation.

### Filtros de pesquisa

O comando `search` permite combinar critérios.

| Filtro | Função |
|---|---|
| `type:` | Filtra pelo tipo de módulo. |
| `platform:` | Filtra pela plataforma. |
| `name:` | Pesquisa pelo nome do módulo. |
| `path:` | Pesquisa pelo caminho do módulo. |
| `cve:` | Pesquisa por identificador CVE. |
| `rank:` | Filtra pela classificação do módulo. |

Exemplos:

```bash
search type:exploit platform:windows
```

Pesquisa exploits associados ao Windows.

```bash
search cve:2021-44228
```

Pesquisa módulos relacionados ao identificador CVE informado.

```bash
search name:tomcat
```

Pesquisa módulos pelo nome.

A disponibilidade dos filtros pode variar conforme a versão.

## 6. Selecionando módulos

Depois de localizar um módulo, utilize `use` para selecioná-lo.

Sintaxe:

```bash
use <CAMINHO_DO_MODULO>
```

Exemplo:

```bash
use auxiliary/scanner/http/tomcat_mgr_login
```

O prompt muda para indicar o módulo selecionado.

Para retornar ao console principal:

```bash
back
```

O comando `back` sai do contexto do módulo atual sem encerrar o MSFConsole.

## 7. Consultando informações de módulos

Depois de selecionar um módulo, é possível consultar suas características.

| Comando | Função |
|---|---|
| `info` | Exibe informações detalhadas do módulo. |
| `show options` | Exibe as opções de configuração. |
| `show advanced` | Exibe opções avançadas. |
| `show payloads` | Lista payloads compatíveis, quando aplicável. |
| `show targets` | Lista os alvos suportados, quando aplicável. |
| `show actions` | Exibe ações disponíveis, quando aplicável. |

### info

```bash
info
```

Apresenta informações como:

- Nome do módulo.
- Descrição.
- Autor.
- Referências.
- Plataformas.
- Opções.
- Classificação e informações técnicas.

### show options

```bash
show options
```

Exibe as opções necessárias para configurar o módulo.

### show advanced

```bash
show advanced
```

Exibe configurações adicionais que não aparecem necessariamente na listagem básica.

### show payloads

```bash
show payloads
```

Lista os payloads compatíveis com o módulo selecionado, quando o módulo oferece essa funcionalidade.

### show targets

```bash
show targets
```

Lista os alvos ou configurações de destino suportados pelo módulo, quando aplicável.

## 8. Configurando módulos

O comando `set` permite definir valores para as opções do módulo.

Sintaxe:

```bash
set <OPÇÃO> <VALOR>
```

Exemplo:

```bash
set RHOSTS 192.168.1.100
```

Define o endereço do alvo.

### Opções comuns

| Opção | Descrição |
|---|---|
| `RHOST` | Endereço do sistema remoto. |
| `RHOSTS` | Um ou mais endereços de sistemas remotos. |
| `RPORT` | Porta do serviço remoto. |
| `LHOST` | Endereço local utilizado para comunicação. |
| `LPORT` | Porta local utilizada para comunicação. |
| `PAYLOAD` | Define o payload utilizado. |
| `TARGET` | Seleciona o alvo ou configuração de destino. |
| `THREADS` | Define a quantidade de threads, quando suportado. |
| `USERNAME` | Define um nome de usuário, quando aplicável. |
| `PASSWORD` | Define uma senha, quando aplicável. |

Nem todos os módulos utilizam essas opções. Consulte sempre `show options`.

### setg

O comando `setg` define uma variável global, que pode ser utilizada por outros módulos.

Sintaxe:

```bash
setg <OPÇÃO> <VALOR>
```

Exemplo:

```bash
setg RHOSTS 192.168.1.100
```

A variável global pode ser aproveitada em outros módulos que utilizem a mesma opção.

### unset

Remove uma configuração definida no contexto atual.

```bash
unset RHOSTS
```

### unset all

Remove as configurações definidas no contexto atual.

```bash
unset all
```

### unsetg

Remove uma configuração global.

```bash
unsetg RHOSTS
```

### get e getg

Consultam valores de opções.

```bash
get RHOSTS
```

Consulta o valor da opção no contexto atual.

```bash
getg RHOSTS
```

Consulta o valor global.

## 9. Execução de módulos

Depois de selecionar e configurar um módulo, é possível executá-lo.

### run

```bash
run
```

Executa o módulo selecionado.

### exploit

```bash
exploit
```

Executa um módulo de exploração.

### check

```bash
check
```

Quando suportado, verifica se o alvo aparenta ser vulnerável sem necessariamente executar a exploração.

A existência e a precisão dessa verificação dependem do módulo.

### Diferença entre run e exploit

| Comando | Utilização |
|---|---|
| `run` | Comando geral para executar módulos. |
| `exploit` | Comando utilizado para executar módulos de exploração. |
| `check` | Verifica a condição de vulnerabilidade, quando suportado. |

## 10. Executando tarefas em segundo plano

O MSFConsole permite executar determinados módulos como tarefas em segundo plano.

Para isso, utiliza-se a opção `-j`.

Exemplos:

```bash
run -j
```

Executa o módulo como um job.

```bash
exploit -j
```

Executa o módulo de exploração como um job.

Isso permite retornar ao console e continuar utilizando outros comandos enquanto a tarefa permanece em execução.

## 11. Jobs

Jobs são tarefas executadas em segundo plano pelo Metasploit.

Para listar os jobs:

```bash
jobs
```

Para consultar informações de um job específico:

```bash
jobs -i <ID>
```

Para encerrar um job específico:

```bash
jobs -k <ID>
```

Para encerrar todos os jobs:

```bash
jobs -K
```

### Diferença entre Jobs e Sessions

| Elemento | Descrição |
|---|---|
| Job | Tarefa que está sendo executada em segundo plano. |
| Session | Conexão interativa estabelecida com um sistema remoto. |

Um handler, por exemplo, pode permanecer ativo como job enquanto aguarda uma conexão que poderá originar uma sessão.

## 12. Sessions

Sessions representam conexões interativas estabelecidas pelo Metasploit.

Para listar as sessões:

```bash
sessions
```

Para acessar uma sessão específica:

```bash
sessions -i <ID>
```

Para encerrar uma sessão:

```bash
sessions -k <ID>
```

Para encerrar todas as sessões:

```bash
sessions -K
```

### Exemplos

```bash
sessions
```

Lista as sessões existentes.

```bash
sessions -i 1
```

Acessa a sessão de identificador 1.

```bash
sessions -k 1
```

Encerra a sessão de identificador 1.

### Interação com Meterpreter

Quando a sessão utiliza Meterpreter, o comando:

```bash
sessions -i <ID>
```

permite entrar na interface Meterpreter.

Para retornar ao MSFConsole sem encerrar a sessão:

```bash
background
```

O gerenciamento detalhado dos comandos do Meterpreter está documentado em `Meterpreter.md`.

## 13. Arquivos RC

Os arquivos RC são arquivos de texto que contêm comandos do Metasploit para execução automatizada.

A extensão utilizada é `.rc`.

Eles permitem organizar uma sequência de comandos e executá-la sem precisar digitá-los individualmente no console.

### Criando um arquivo RC

Exemplo de conteúdo:

```text
use auxiliary/scanner/http/title
set RHOSTS 192.168.1.100
set RPORT 80
show options
```

Nesse exemplo, o arquivo seleciona um módulo de identificação de título HTTP, configura o endereço e a porta e apresenta as opções.

### Executando um arquivo RC na inicialização

```bash
msfconsole -r arquivo.rc
```

O Metasploit será iniciado e executará os comandos presentes no arquivo.

### Executando um arquivo RC dentro do console

```bash
resource arquivo.rc
```

Esse comando carrega e executa os comandos do arquivo na sessão atual do MSFConsole.

### Passando variáveis do Bash para um RC

É possível utilizar o shell para gerar um arquivo RC com valores dinâmicos.

Exemplo:

```bash
IP="192.168.1.100"
PORTA="80"

cat > teste.rc <<EOF
use auxiliary/scanner/http/title
set RHOSTS $IP
set RPORT $PORTA
show options
EOF
```

Depois, execute:

```bash
msfconsole -r teste.rc
```

O Bash substitui as variáveis antes de gravar o conteúdo no arquivo.

**Atenção:** o conteúdo do RC não é interpretado como Bash. A substituição ocorre no momento em que o shell cria o arquivo. Os comandos executados depois são comandos do Metasploit.

## 14. Comandos gerais

O MSFConsole possui comandos adicionais para navegação, informações e gerenciamento.

| Comando | Função |
|---|---|
| `help` | Exibe os comandos disponíveis. |
| `version` | Exibe a versão do Metasploit. |
| `banner` | Exibe o banner do Metasploit. |
| `search` | Pesquisa módulos. |
| `use` | Seleciona um módulo. |
| `back` | Retorna ao console principal. |
| `info` | Exibe informações do módulo. |
| `show` | Exibe informações e opções. |
| `set` | Define uma opção local. |
| `setg` | Define uma opção global. |
| `unset` | Remove uma opção local. |
| `unsetg` | Remove uma opção global. |
| `run` | Executa um módulo. |
| `exploit` | Executa um módulo de exploração. |
| `check` | Verifica uma condição, quando suportado. |
| `jobs` | Gerencia tarefas em segundo plano. |
| `sessions` | Gerencia sessões. |
| `resource` | Executa um arquivo RC. |
| `spool` | Registra a saída do console em um arquivo. |
| `save` | Salva configurações do Metasploit, quando aplicável. |
| `exit` | Encerra o MSFConsole. |

## 15. Histórico e registro de atividades

O Metasploit possui recursos para consultar e registrar atividades.

### history

```bash
history
```

Exibe o histórico de comandos da sessão do console, quando disponível.

### spool

```bash
spool arquivo.log
```

Inicia o registro da saída do console em um arquivo.

Para interromper o registro:

```bash
spool off
```

Esse recurso é útil para documentar testes e guardar resultados.

Tenha cuidado para não registrar ou compartilhar credenciais, tokens e outros dados sensíveis.

## 16. Tabulação e autocompletar

O MSFConsole possui suporte à conclusão automática de comandos.

Pressione `TAB` para tentar completar:

- Nomes de comandos.
- Caminhos de módulos.
- Opções disponíveis.
- Valores reconhecidos pelo contexto atual.

Exemplo:

```text
msf6 > use auxiliary/scanner/http/
```

Pressionar `TAB` pode apresentar os módulos disponíveis naquele caminho.

A conclusão depende do contexto e dos recursos carregados.

## 17. Integração com MSFVenom

O MSFVenom é utilizado para gerar payloads, enquanto o MSFConsole pode ser utilizado para gerenciar handlers e sessões.

| Ferramenta | Função |
|---|---|
| MSFVenom | Gera payloads. |
| MSFConsole | Gerencia módulos e sessões. |
| Handler | Aguarda e gerencia conexões compatíveis. |
| Meterpreter | Disponibiliza uma interface interativa para determinadas sessões. |

As configurações do payload e do handler precisam ser compatíveis para que a comunicação seja estabelecida.

## 18. Diferença entre MSFConsole, MSFVenom e Meterpreter

| Componente | Responsabilidade |
|---|---|
| MSFConsole | Interface principal do Metasploit. |
| MSFVenom | Geração de payloads. |
| Meterpreter | Interface de uma sessão avançada. |
| Handler | Gerenciamento de conexões de payloads. |
| Modules | Recursos utilizados pelo framework para diferentes tarefas. |

## 19. Fluxo de utilização

Um fluxo comum de trabalho no Metasploit pode ser dividido em etapas:

1. Inicializar o MSFConsole.
2. Pesquisar módulos com `search`.
3. Selecionar um módulo com `use`.
4. Consultar informações com `info`.
5. Verificar opções com `show options`.
6. Configurar os parâmetros com `set`.
7. Verificar as configurações.
8. Executar o módulo com `run` ou `exploit`, conforme o tipo.
9. Consultar jobs com `jobs`.
10. Consultar sessões com `sessions`.
11. Interagir com uma sessão usando `sessions -i <ID>`.
12. Encerrar tarefas ou sessões quando necessário.

Esse fluxo é uma referência geral. Nem todo módulo exige todas as etapas.

## 20. Tabela de referência rápida

| Comando | Função |
|---|---|
| `msfconsole` | Inicia o console. |
| `msfconsole -q` | Inicia sem banner. |
| `msfconsole -r <ARQUIVO>` | Executa um RC na inicialização. |
| `help` | Exibe ajuda. |
| `version` | Mostra a versão. |
| `search <TERMO>` | Pesquisa módulos. |
| `use <MÓDULO>` | Seleciona módulo. |
| `back` | Sai do contexto do módulo. |
| `info` | Consulta informações. |
| `show options` | Mostra opções. |
| `show advanced` | Mostra opções avançadas. |
| `show payloads` | Mostra payloads compatíveis. |
| `set` | Define opções locais. |
| `setg` | Define opções globais. |
| `unset` | Remove opções locais. |
| `unsetg` | Remove opções globais. |
| `run` | Executa módulo. |
| `exploit` | Executa exploit. |
| `check` | Verifica vulnerabilidade, quando suportado. |
| `jobs` | Lista jobs. |
| `jobs -k <ID>` | Encerra um job. |
| `sessions` | Lista sessões. |
| `sessions -i <ID>` | Acessa sessão. |
| `sessions -k <ID>` | Encerra sessão. |
| `resource <ARQUIVO>` | Executa arquivo RC. |
| `spool <ARQUIVO>` | Registra a saída do console. |
| `exit` | Encerra o console. |

## 21. Observações importantes

- O MSFConsole é uma interface de gerenciamento, não um exploit por si só.
- Cada módulo possui suas próprias opções e limitações.
- Nem todos os módulos aceitam payloads.
- Nem todos os módulos possuem suporte ao comando `check`.
- `run` e `exploit` dependem do tipo de módulo.
- Jobs e sessions representam recursos diferentes.
- Variáveis globais podem influenciar a configuração de outros módulos.
- Arquivos RC executam comandos do Metasploit, não comandos arbitrários do Bash.
- A disponibilidade dos comandos pode variar entre versões.
- O sucesso de uma exploração depende da existência da vulnerabilidade, das condições do ambiente e das configurações do alvo.

## 22. Referências

- Documentação oficial: https://docs.metasploit.com/
- Repositório oficial: https://github.com/rapid7/metasploit-framework
- Ajuda local: `msfconsole -h`
- Ajuda interna: `help`
