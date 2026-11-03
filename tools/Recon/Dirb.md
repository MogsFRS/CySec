# DIRB — Web Content Scanner

## 1. O que é?

O **DIRB** é uma ferramenta de enumeração de conteúdo web. Ela utiliza listas de palavras (*wordlists*) para procurar diretórios e arquivos que podem existir em um servidor web.

Por exemplo, uma aplicação pode possuir caminhos como:

```text
/
 /admin
 /login
 /images
 /uploads
 /docs
```

Nem todos esses caminhos precisam estar visíveis na página inicial. O DIRB testa nomes de caminhos e analisa as respostas do servidor.

**Importante:** DIRB é um scanner de conteúdo, não um scanner de vulnerabilidades.

## 2. Instalação no Kali

```bash
sudo apt update
sudo apt install dirb
```

Verifique:

```bash
dirb
```

Consulte o manual:

```bash
man dirb
```

## 3. Wordlists

O DIRB acompanha listas de palavras que podem ser utilizadas nos testes.

Local comum:

```text
/usr/share/dirb/wordlists/
```

Para listar:

```bash
ls -lh /usr/share/dirb/wordlists/
```

Uma das listas mais utilizadas é:

```text
/usr/share/dirb/wordlists/common.txt
```

Uma wordlist é simplesmente um arquivo de texto contendo nomes que serão testados pela ferramenta.

## 4. Sintaxe básica

```bash
dirb URL WORDLIST
```

Exemplo em um laboratório local:

```bash
dirb http://127.0.0.1:8080/ /usr/share/dirb/wordlists/common.txt
```

O DIRB testa os caminhos da wordlist no servidor local.

## 5. Opções importantes

| Opção | Função |
|---|---|
| `-a` | Define User-Agent |
| `-c` | Envia cookies |
| `-H` | Adiciona cabeçalho HTTP |
| `-i` | Pesquisa sem diferenciar maiúsculas e minúsculas |
| `-o` | Salva a saída em arquivo |
| `-r` | Não realiza busca recursiva |
| `-R` | Permite controlar recursão interativamente |
| `-S` | Modo silencioso |
| `-X` | Acrescenta extensões à pesquisa |
| `-N` | Ignora determinado código HTTP |
| `-z` | Define intervalo entre requisições, em milissegundos |

Consulte `man dirb` para obter a lista completa e a sintaxe exata da versão instalada.

## 6. Procurando arquivos com extensões

Exemplo:

```bash
dirb http://127.0.0.1:8080/ \
  /usr/share/dirb/wordlists/common.txt \
  -X .php,.html,.txt
```

A ferramenta também testa os nomes com as extensões indicadas.

## 7. Salvando os resultados

```bash
dirb http://127.0.0.1:8080/ \
  /usr/share/dirb/wordlists/common.txt \
  -o resultados.txt
```

## 8. Entendendo as respostas

O DIRB apresenta informações sobre os caminhos encontrados.

Exemplo ilustrativo:

```text
+ http://127.0.0.1:8080/login (CODE:200|SIZE:1200)
+ http://127.0.0.1:8080/admin (CODE:403|SIZE:500)
```

| Informação | Significado |
|---|---|
| URL | Caminho testado |
| CODE | Código HTTP retornado |
| SIZE | Tamanho da resposta |

Um `200` indica uma resposta HTTP bem-sucedida, mas não garante que o conteúdo seja o esperado.

Um `403` indica que o servidor recusou o acesso. Isso não significa que seja possível contornar a restrição.

## 9. DIRB não encontra vulnerabilidades automaticamente

Encontrar `/admin` não significa que o painel esteja vulnerável. Encontrar `/backup` não significa que seja possível acessar dados.

A ferramenta identifica possíveis recursos; a análise de segurança exige investigação adicional e autorização.

## 10. Documentação

- Kali Linux Tools: https://www.kali.org/tools/dirb/
- Manual: `man dirb`
- Wordlists: `/usr/share/dirb/wordlists/`

