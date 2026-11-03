# DirBuster — Descoberta de Diretórios e Arquivos Web

## 1. O que é?

O **DirBuster** é uma ferramenta de descoberta de diretórios e arquivos em servidores web.

Ele foi desenvolvido em Java e utiliza listas de palavras para testar caminhos de uma aplicação.

Seu objetivo é encontrar recursos que podem não estar disponíveis por meio dos links visíveis do site.

Exemplos de caminhos:

```text
/admin
/backup
/uploads
/images
/config
/docs
```

O DirBuster é uma ferramenta de enumeração de conteúdo, não um scanner que confirma vulnerabilidades.

## 2. Instalação no Kali

```bash
sudo apt update
sudo apt install dirbuster
```

O pacote depende de um ambiente Java Runtime.

Confira:

```bash
java -version
```

Para abrir a interface gráfica:

```bash
dirbuster
```

A disponibilidade do lançador pode variar de acordo com o pacote. Consulte também:

```bash
dpkg -L dirbuster
```

## 3. Interface gráfica

O DirBuster possui uma interface visual com configurações para o teste.

Os principais campos são:

| Campo | Função |
|---|---|
| Target URL | Endereço da aplicação |
| Wordlist | Lista de nomes que serão testados |
| Threads | Quantidade de conexões simultâneas |
| File extensions | Extensões de arquivos a testar |
| Start point | Caminho inicial |
| Recursive | Controla a busca recursiva |

A busca recursiva significa que, quando um diretório é encontrado, a ferramenta pode continuar procurando conteúdo dentro dele.

## 4. Wordlists

No Kali, as listas podem ser encontradas em:

```text
/usr/share/dirbuster/wordlists/
```

Para listar:

```bash
ls -lh /usr/share/dirbuster/wordlists/
```

Uma lista conhecida é:

```text
directory-list-2.3-small.txt
```

A escolha da lista afeta a duração e a abrangência do teste.

## 5. Executando pela interface gráfica

1. Inicie o DirBuster.
2. Informe a URL do laboratório.
3. Selecione uma wordlist.
4. Configure o número de threads de acordo com a capacidade do laboratório.
5. Escolha as extensões que deseja testar.
6. Defina o caminho inicial.
7. Inicie a enumeração.
8. Analise os caminhos encontrados.

Exemplo de alvo local:

```text
http://127.0.0.1:8080/
```

## 6. Execução pelo terminal

A instalação do Kali também disponibiliza uma opção de execução sem interface gráfica (*headless*).

Exemplo:

```bash
dirbuster -H -u http://127.0.0.1:8080/
```

Opções comuns da versão empacotada:

| Opção | Função |
|---|---|
| `-h` | Mostra a ajuda |
| `-H` | Executa em modo headless |
| `-u` | Define a URL |
| `-l` | Define a wordlist |
| `-t` | Define a quantidade de threads |
| `-e` | Define extensões |
| `-s` | Define o ponto inicial |
| `-v` | Ativa saída detalhada |
| `-R` | Desativa a recursão |
| `-r` | Define o arquivo do relatório |

Exemplo:

```bash
dirbuster \
  -H \
  -u http://127.0.0.1:8080/ \
  -l /usr/share/dirbuster/wordlists/directory-list-2.3-small.txt \
  -t 10 \
  -r relatorio.txt
```

Os argumentos podem variar entre versões. Confirme a sintaxe com `dirbuster -h`.

## 7. Como interpretar os resultados?

Observe:
- Caminho encontrado.
- Código HTTP.
- Tamanho da resposta.
- Extensão do arquivo.
- Se o recurso foi encontrado por busca direta ou recursiva.

Códigos como 200, 301, 302 e 403 podem merecer investigação, mas não comprovam uma falha de segurança.

## 8. DirBuster, DIRB e Gobuster

| Ferramenta | Característica |
|---|---|
| DirBuster | Aplicação Java com interface gráfica e modo headless |
| DIRB | Scanner de conteúdo web com execução simples pelo terminal |
| Gobuster | Ferramenta em Go, com múltiplos modos de enumeração |
| FFUF | Fuzzer web flexível, com filtros e posições de substituição |

As quatro ferramentas podem realizar descoberta de conteúdo, mas diferem em interface, desempenho, opções e flexibilidade.

## 9. Cuidados

- Utilize apenas aplicações próprias ou autorizadas.
- Evite threads excessivas.
- Faça testes em laboratório antes de utilizar a ferramenta em produção.
- Não interprete diretórios encontrados como vulnerabilidades confirmadas.

## 10. Referências

- Kali Linux Tools: https://www.kali.org/tools/dirbuster/
- Wordlists: `/usr/share/dirbuster/wordlists/`
