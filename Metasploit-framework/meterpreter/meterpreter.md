# Metasploit Framework — Meterpreter

## 1. Introdução

O **Meterpreter** é um payload avançado do Metasploit Framework que fornece uma interface interativa para gerenciar uma sessão em um sistema remoto.

Ele disponibiliza comandos próprios para consultar informações do sistema, visualizar processos, navegar por diretórios, transferir arquivos e administrar a sessão.

Diferentemente de um shell tradicional, o Meterpreter possui uma estrutura própria de comandos e funcionalidades integradas ao Metasploit.

O Meterpreter não é um terminal convencional: seus comandos são interpretados pela própria interface do Meterpreter.

## 2. Como funciona?

O funcionamento básico envolve três componentes:

| Componente | Função |
|---|---|
| Payload | Código responsável por estabelecer a funcionalidade de comunicação. |
| Handler | Componente que aguarda e gerencia a conexão. |
| Meterpreter | Interface interativa disponibilizada pela sessão. |

Quando uma sessão compatível é estabelecida, o Metasploit registra essa sessão e permite que o operador interaja com ela pelo MSFConsole.

O Meterpreter pode funcionar de maneiras diferentes dependendo do payload, da plataforma e da arquitetura.

## 3. Acessando uma sessão

As sessões são gerenciadas pelo MSFConsole.

Para listar as sessões disponíveis:

```bash
sessions
```

A saída apresenta os identificadores das sessões existentes.

Para acessar uma sessão específica:

```bash
sessions -i <ID>
```

Exemplo:

```bash
sessions -i 1
```

O número `1` representa o identificador da sessão.

Para retornar ao MSFConsole sem encerrar a sessão:

```bash
background
```

Esse comando deixa a sessão em segundo plano.

## 4. Diferença entre background e exit

É importante entender a diferença entre esses comandos.

| Comando | Resultado |
|---|---|
| `background` | Suspende a interação atual e retorna ao MSFConsole, mantendo a sessão. |
| `exit` | Encerra a sessão atual. |

O comando `background` é especialmente útil quando existem várias sessões ou quando é necessário alternar entre elas.

## 5. Ajuda e comandos disponíveis

Para consultar os comandos disponíveis:

```bash
help
```

Ou:

```bash
?
```

Para consultar informações sobre um comando específico:

```bash
help <COMANDO>
```

A lista de comandos pode variar conforme a versão do Meterpreter, a plataforma e os recursos disponíveis na sessão.

## 6. Informações do sistema

Esses comandos permitem consultar informações básicas do ambiente remoto.

| Comando | Função |
|---|---|
| `sysinfo` | Exibe informações do sistema operacional e do ambiente. |
| `getuid` | Exibe o usuário associado à sessão. |
| `getpid` | Exibe o identificador do processo atual. |
| `getenv <VARIÁVEL>` | Consulta uma variável de ambiente. |
| `pwd` | Exibe o diretório atual. |
| `getlwd` | Exibe o diretório de trabalho local do Meterpreter. |

### sysinfo

Apresenta informações como nome do sistema, arquitetura e versão do sistema operacional, dependendo da plataforma.

### getuid

Mostra a identidade do usuário associada ao processo que executa a sessão.

É importante lembrar que o usuário exibido não representa necessariamente o nível máximo de privilégios disponível no sistema.

### getpid

Exibe o PID, ou Process ID, do processo associado à sessão.

O PID é um identificador numérico utilizado pelo sistema operacional para identificar processos.

## 7. Navegação pelo sistema de arquivos

O Meterpreter possui comandos próprios para navegar pelo sistema de arquivos.

| Comando | Função |
|---|---|
| `pwd` | Exibe o diretório atual. |
| `ls` | Lista arquivos e diretórios. |
| `cd <DIRETÓRIO>` | Altera o diretório atual. |
| `cat <ARQUIVO>` | Exibe o conteúdo de um arquivo. |
| `search` | Procura arquivos no sistema, conforme os parâmetros disponíveis. |

### pwd

Mostra o caminho do diretório atual.

### ls

Lista os arquivos e diretórios presentes no local atual.

### cd

Permite navegar entre diretórios.

### cat

Exibe o conteúdo de arquivos de texto.

## 8. Transferência de arquivos

O Meterpreter possui comandos específicos para transferir arquivos entre a máquina local e o sistema remoto.

| Comando | Função |
|---|---|
| `download` | Transfere um arquivo remoto para a máquina local. |
| `upload` | Transfere um arquivo local para o sistema remoto. |

A sintaxe geral é:

```bash
download <ARQUIVO_REMOTO>
```

```bash
upload <ARQUIVO_LOCAL>
```

O caminho e as permissões precisam ser compatíveis com o ambiente utilizado.

## 9. Processos

Um processo é uma instância de um programa em execução no sistema operacional.

O Meterpreter possui comandos para consultar informações sobre processos.

| Comando | Função |
|---|---|
| `ps` | Lista processos em execução. |
| `getpid` | Mostra o PID do processo atual. |
| `migrate <PID>` | Tenta migrar a sessão para outro processo. |

### ps

Apresenta informações sobre os processos em execução, incluindo identificadores e nomes.

### migrate

Tenta transferir a execução da sessão para outro processo.

Essa operação depende de fatores como:

- Permissões disponíveis.
- Arquitetura dos processos.
- Compatibilidade entre processos.
- Restrições do sistema operacional.
- Proteções de segurança.

A migração não é garantida e não significa que a sessão receberá privilégios adicionais automaticamente.

## 10. Informações de rede

O Meterpreter possui comandos para consultar informações relacionadas à rede.

| Comando | Função |
|---|---|
| `ipconfig` | Exibe informações das interfaces de rede. |
| `route` | Exibe informações da tabela de roteamento. |
| `arp` | Consulta informações da tabela ARP. |
| `netstat` | Exibe conexões e informações de rede. |

A disponibilidade e a saída desses comandos podem variar conforme o sistema operacional.

### Conceitos importantes

**IP:** endereço utilizado para identificar uma interface em uma rede.

**Gateway:** equipamento utilizado para encaminhar tráfego para outras redes.

**ARP:** protocolo utilizado para relacionar endereços IP e endereços físicos em redes locais IPv4.

**Rota:** regra que determina por onde o tráfego de rede deve ser encaminhado.

## 11. Gerenciamento de sessões pelo MSFConsole

Embora o Meterpreter tenha seus próprios comandos, o gerenciamento das sessões é realizado pelo MSFConsole.

| Comando | Função |
|---|---|
| `sessions` | Lista as sessões existentes. |
| `sessions -i <ID>` | Acessa uma sessão. |
| `sessions -k <ID>` | Encerra uma sessão específica. |
| `sessions -K` | Encerra todas as sessões. |

### Exemplo de gerenciamento

Listar sessões:

```bash
sessions
```

Acessar a sessão de identificador 1:

```bash
sessions -i 1
```

Retornar ao console:

```bash
background
```

Encerrar a sessão de identificador 1:

```bash
sessions -k 1
```

**Importante:** `sessions -k` e `sessions -K` são comandos do MSFConsole, não comandos internos do Meterpreter.

## 12. Shell e Meterpreter

O Meterpreter também pode disponibilizar um shell do sistema operacional.

É importante não confundir as duas interfaces.

| Característica | Shell | Meterpreter |
|---|---|---|
| Interface | Terminal do sistema operacional | Interface própria do Metasploit |
| Comandos | Comandos do sistema | Comandos específicos do Meterpreter |
| Gerenciamento | Depende do shell e do sistema | Integrado ao MSFConsole |
| Informações do sistema | Utiliza ferramentas do sistema | Possui comandos próprios |
| Transferência de arquivos | Depende de ferramentas disponíveis | Possui `upload` e `download` |
| Ajuda | Depende do shell | Comando `help` |

O comando `shell`, quando disponível, abre uma interface de terminal do sistema operacional.

Para retornar ao Meterpreter, o procedimento depende do tipo de shell e da plataforma.

## 13. Scripts e extensões

O Meterpreter possui suporte a extensões e funcionalidades adicionais.

As extensões podem disponibilizar comandos que não fazem parte do conjunto básico da sessão.

O comando:

```bash
load
```

é utilizado para carregar extensões compatíveis.

Para consultar extensões disponíveis e seus comandos, utilize a ajuda da versão instalada:

```bash
help
```

A disponibilidade depende da plataforma, da versão e do tipo de sessão.

## 14. Diferença entre Meterpreter e MSFConsole

Essas ferramentas trabalham juntas, mas possuem responsabilidades diferentes.

| Ferramenta | Responsabilidade |
|---|---|
| MSFConsole | Interface principal para gerenciar o Metasploit. |
| Meterpreter | Interface interativa de uma sessão. |
| MSFVenom | Geração de payloads. |
| Handler | Gerenciamento de conexões de payloads. |

O MSFConsole é utilizado para administrar módulos, sessões e tarefas. O Meterpreter é utilizado dentro de uma sessão compatível.

## 15. Fluxo básico de uma sessão

1. Um payload compatível estabelece uma conexão com o handler.
2. O Metasploit registra a sessão.
3. O comando `sessions` lista as sessões existentes.
4. O comando `sessions -i <ID>` acessa uma sessão.
5. O comando `sysinfo` consulta informações do sistema.
6. O comando `ps` apresenta os processos em execução.
7. O comando `background` retorna ao MSFConsole.
8. O comando `sessions -k <ID>` encerra a sessão quando necessário.

Esse fluxo representa o gerenciamento básico de uma sessão em um laboratório autorizado.

## 16. Tabela de referência rápida

| Comando | Função |
|---|---|
| `help` | Exibe a ajuda. |
| `?` | Exibe a ajuda. |
| `sysinfo` | Informações do sistema. |
| `getuid` | Usuário associado à sessão. |
| `getpid` | PID atual. |
| `getenv` | Consulta variável de ambiente. |
| `ps` | Lista processos. |
| `ipconfig` | Informações de rede. |
| `route` | Tabela de roteamento. |
| `arp` | Tabela ARP. |
| `netstat` | Informações de conexões. |
| `ls` | Lista arquivos. |
| `pwd` | Diretório atual. |
| `cd` | Navegação entre diretórios. |
| `cat` | Exibe conteúdo de arquivos. |
| `download` | Transfere arquivos para a máquina local. |
| `upload` | Transfere arquivos para o sistema remoto. |
| `background` | Retorna ao MSFConsole mantendo a sessão. |
| `exit` | Encerra a sessão atual. |
| `load` | Carrega uma extensão compatível. |

## 17. Observações importantes

- Os comandos disponíveis podem variar de acordo com a versão do Meterpreter.
- Algumas funcionalidades dependem do sistema operacional.
- Nem todos os comandos possuem o mesmo comportamento em Windows e Linux.
- O acesso a informações e arquivos depende das permissões da sessão.
- Uma sessão Meterpreter não representa automaticamente acesso administrativo.
- A migração de processos não garante elevação de privilégios.
- O encerramento de uma sessão não significa que o processo remoto foi necessariamente finalizado.

## 18. Referências

- Documentação oficial: https://docs.metasploit.com/
- Repositório oficial: https://github.com/rapid7/metasploit-framework
- Ajuda interna: `help`
