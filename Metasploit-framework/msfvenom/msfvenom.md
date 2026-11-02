# Metasploit Framework — MSFVenom

## 1. Introdução

O **MSFVenom** é uma ferramenta integrada ao Metasploit Framework utilizada para gerar payloads em diferentes formatos e plataformas.

Um payload é um código que representa uma determinada funcionalidade a ser executada no sistema de destino. Dependendo do payload escolhido, ele pode executar uma ação local, estabelecer uma conexão ou fornecer uma interface de comunicação remota.

O MSFVenom permite personalizar a geração desses arquivos, definindo características como:

- Tipo de payload.
- Sistema operacional de destino.
- Arquitetura do processador.
- Formato do arquivo.
- Parâmetros específicos do payload.
- Codificação dos dados.

Ele combina funcionalidades que anteriormente eram realizadas pelas ferramentas `msfpayload` e `msfencode`.

## 2. Como funciona?

A geração de um payload envolve algumas escolhas importantes.

| Elemento | Descrição |
|---|---|
| Payload | Define o comportamento que será gerado. |
| Plataforma | Determina o sistema operacional de destino. |
| Arquitetura | Define a arquitetura de processador compatível. |
| Formato | Determina como o resultado será armazenado. |
| Opções | Configuram parâmetros específicos do payload. |
| Saída | Define o nome e o destino do arquivo gerado. |

Essas características precisam ser compatíveis entre si. Por exemplo, um payload destinado ao Windows não é automaticamente compatível com Linux.

## 3. Sintaxe básica

```bash
msfvenom [opções]
```

Para consultar a ajuda:

```bash
msfvenom -h
```

A ajuda apresenta os parâmetros disponíveis e uma descrição de suas funcionalidades.

## 4. Listagem de recursos

O MSFVenom possui comandos para consultar os recursos disponíveis na instalação.

### Payloads

```bash
msfvenom -l payloads
```

Lista os payloads disponíveis.

Um payload pode ser específico para uma plataforma ou arquitetura, ou possuir características próprias de execução e comunicação.

### Formatos

```bash
msfvenom -l formats
```

Lista os formatos nos quais os payloads podem ser gerados.

### Plataformas

```bash
msfvenom -l platforms
```

Lista as plataformas suportadas.

### Arquiteturas

```bash
msfvenom -l archs
```

Lista as arquiteturas disponíveis.

### Encoders

```bash
msfvenom -l encoders
```

Lista os encoders disponíveis.

### NOPs

```bash
msfvenom -l nops
```

Lista os módulos NOP disponíveis.

## 5. Payloads

O payload é um dos elementos mais importantes do MSFVenom.

Ele determina o que será executado quando o código gerado for utilizado.

Os payloads do Metasploit possuem diferentes características e podem ser classificados de acordo com seu funcionamento.

### Single

Payloads que executam uma funcionalidade específica sem depender de uma etapa posterior de carregamento de um estágio adicional.

### Staged

Payloads divididos em duas partes:

- **Stage 0:** estabelece a comunicação e prepara o ambiente para receber a próxima etapa.
- **Stage:** contém funcionalidades adicionais que serão carregadas posteriormente.

### Stageless

Payloads que possuem suas funcionalidades reunidas em uma única estrutura, sem depender do carregamento de um estágio separado.

### Diferenças

| Tipo | Característica |
|---|---|
| Single | Executa uma funcionalidade específica. |
| Staged | Carrega funcionalidades adicionais durante a execução. |
| Stageless | Reúne as funcionalidades em uma estrutura única. |

A escolha depende das características do ambiente, das limitações de execução e da compatibilidade com o handler.

## 6. Consultando as opções de um payload

Cada payload pode possuir parâmetros diferentes.

Para consultar suas opções:

```bash
msfvenom -p <PAYLOAD> --list-options
```

Exemplo de consulta:

```bash
msfvenom -p <PAYLOAD> --list-options
```

Entre os parâmetros que podem aparecer estão:

| Parâmetro | Descrição |
|---|---|
| `LHOST` | Endereço local utilizado para comunicação reversa. |
| `LPORT` | Porta local utilizada para comunicação. |
| `RHOST` | Endereço do sistema remoto, quando aplicável. |
| `RPORT` | Porta do serviço remoto, quando aplicável. |

Nem todos os payloads possuem os mesmos parâmetros. Sempre consulte as opções do payload escolhido.

## 7. Arquiteturas

A arquitetura representa a organização e o conjunto de instruções do processador para o qual o código será preparado.

| Arquitetura | Descrição |
|---|---|
| `x86` | Arquitetura de 32 bits. |
| `x64` | Arquitetura de 64 bits. |
| `armle` | ARM little-endian. |
| `aarch64` | ARM de 64 bits. |
| `mips` | MIPS. |
| `mipsle` | MIPS little-endian. |
| `mips64` | MIPS de 64 bits. |
| `ppc` | PowerPC. |

A arquitetura escolhida precisa ser compatível com o sistema de destino e com as características do payload.

**Importante:** a arquitetura do sistema operacional e a arquitetura do processador estão relacionadas, mas não são exatamente a mesma coisa. Um sistema operacional de 64 bits pode executar determinados programas de 32 bits, desde que possua compatibilidade para isso.

## 8. Plataformas

A plataforma representa o sistema operacional ou ambiente para o qual o payload será preparado.

Alguns exemplos:

| Plataforma | Ambiente |
|---|---|
| `windows` | Microsoft Windows. |
| `linux` | Linux. |
| `osx` | macOS. |
| `android` | Android. |
| `unix` | Sistemas Unix. |
| `php` | Ambiente PHP. |
| `java` | Ambiente Java. |

A lista pode variar conforme a versão instalada.

## 9. Formatos de saída

O formato define como o conteúdo será armazenado no arquivo final.

| Formato | Descrição |
|---|---|
| `elf` | Executável no formato ELF, utilizado em Linux e outros sistemas Unix-like. |
| `elf-so` | Biblioteca compartilhada no formato ELF. |
| `exe` | Executável do Windows. |
| `exe-only` | Formato executável Windows. |
| `exe-service` | Executável Windows preparado para uso como serviço. |
| `dll` | Biblioteca dinâmica do Windows. |
| `war` | Pacote de aplicação web Java. |
| `asp` | Código ASP. |
| `aspx` | Código ASP.NET. |
| `aspx-exe` | Executável ASP.NET. |
| `axis2` | Pacote destinado ao ambiente Apache Axis2. |
| `raw` | Saída em formato bruto. |
| `python` | Código-fonte Python. |
| `bash` | Código-fonte Bash. |
| `powershell` | Código PowerShell. |

A disponibilidade dos formatos depende da versão e dos componentes instalados.

### ELF

ELF significa Executable and Linkable Format.

É um formato utilizado principalmente por sistemas Linux e Unix-like para executáveis, bibliotecas e outros arquivos binários.

Um ELF não é necessariamente de 64 bits: pode ser compilado para diferentes arquiteturas.

### PE

PE significa Portable Executable.

É o formato utilizado pelo Windows para arquivos como:

- `.exe`
- `.dll`
- `.sys`

### WAR

WAR significa Web Application Archive.

É um pacote utilizado para distribuir aplicações web Java em servidores compatíveis, como o Apache Tomcat.

Não é um executável nativo do Linux ou Windows.

## 10. Principais parâmetros

| Parâmetro | Função |
|---|---|
| `-p` | Seleciona o payload. |
| `-f` | Define o formato de saída. |
| `-o` | Define o arquivo de saída. |
| `-a` | Define a arquitetura. |
| `--platform` | Define a plataforma. |
| `-e` | Seleciona um encoder. |
| `-i` | Define o número de iterações de codificação. |
| `-b` | Especifica bytes que devem ser evitados. |
| `-n` | Adiciona NOPs ao conteúdo. |
| `-x` | Utiliza um executável como modelo. |
| `-k` | Mantém o comportamento original do executável modelo, quando suportado. |
| `-v` | Define o número de vezes que o conteúdo será exibido na saída, conforme o contexto de uso. |

Consulte `msfvenom -h` para verificar a sintaxe e a disponibilidade de cada parâmetro na sua versão.

## 11. Encoders

Um encoder transforma a representação dos bytes de um payload.

Esse recurso pode ser utilizado para atender a determinadas restrições de formato ou de caracteres durante a geração.

Principais parâmetros:

| Parâmetro | Função |
|---|---|
| `-e` | Seleciona o encoder. |
| `-i` | Define o número de iterações. |
| `-b` | Define bytes que devem ser evitados. |

**Atenção:** codificação não é sinônimo de criptografia e não garante que um payload seja indetectável por antivírus ou ferramentas de segurança.

## 12. NOPs

NOP significa No Operation.

É uma instrução que não realiza uma operação funcional significativa, sendo utilizada em determinados contextos de programação de baixo nível e exploração de memória.

O parâmetro `-n` permite adicionar NOPs ao conteúdo gerado.

O parâmetro `-l nops` permite consultar os módulos disponíveis.

## 13. Integração com o MSFConsole

O MSFVenom e o MSFConsole possuem funções diferentes, mas complementares.

| Ferramenta | Responsabilidade |
|---|---|
| MSFVenom | Geração e personalização de payloads. |
| MSFConsole | Gerenciamento de módulos, handlers e sessões. |
| Handler | Aguarda e gerencia conexões de payloads compatíveis. |
| Meterpreter | Interface interativa disponibilizada por determinados payloads. |

Um handler precisa ser compatível com o payload utilizado, incluindo seu tipo, endereço e porta de comunicação.

## 14. Resumo rápido

| Comando | Função |
|---|---|
| `msfvenom -h` | Exibe a ajuda. |
| `msfvenom -l payloads` | Lista payloads. |
| `msfvenom -l formats` | Lista formatos. |
| `msfvenom -l platforms` | Lista plataformas. |
| `msfvenom -l archs` | Lista arquiteturas. |
| `msfvenom -l encoders` | Lista encoders. |
| `msfvenom -l nops` | Lista módulos NOP. |
| `msfvenom -p <PAYLOAD> --list-options` | Consulta parâmetros do payload. |

## 15. Referências

- Documentação oficial: https://docs.metasploit.com/
- Repositório oficial: https://github.com/rapid7/metasploit-framework
- Ajuda local: `msfvenom -h`
