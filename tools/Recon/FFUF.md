# FFUF — Web Fuzzing e Descoberta de Conteúdo

## 1. O que é?

O **FFUF (Fuzz Faster U Fool)** é uma ferramenta de fuzzing web escrita em Go.

É utilizada para testar diferentes valores em partes de uma requisição HTTP e observar como a aplicação responde.

Usos comuns:
- Descoberta de diretórios e arquivos.
- Identificação de virtual hosts.
- Testes de parâmetros.
- Testes de cabeçalhos.
- Testes de dados enviados por POST.
- Identificação de respostas incomuns.

O FFUF não é um scanner que confirma vulnerabilidades automaticamente. Ele ajuda a encontrar comportamentos e recursos que merecem investigação.

Projeto: https://github.com/ffuf/ffuf

## 2. Instalação no Kali

```bash
sudo apt update
sudo apt install ffuf
```

Verifique:

```bash
ffuf -h
```

Também é possível instalar pelo Go:

```bash
go install github.com/ffuf/ffuf/v2@latest
```

Se necessário, adicione o diretório de binários do Go ao PATH.

## 3. Como funciona o FUZZ?

O elemento central do FFUF é a palavra-chave:

```text
FUZZ
```

Ela indica onde a ferramenta deve inserir cada palavra da lista fornecida.

Exemplo conceitual:

```text
URL: http://127.0.0.1:8080/FUZZ
Wordlist:
    admin
    login
    images
```

A ferramenta testa caminhos como:

```text
http://127.0.0.1:8080/admin
http://127.0.0.1:8080/login
http://127.0.0.1:8080/images
```

## 4. Estrutura básica

```bash
ffuf -w WORDLIST -u URL
```

| Parâmetro | Função |
|---|---|
| `-w` | Define a wordlist |
| `-u` | Define a URL |
| `-H` | Adiciona cabeçalho HTTP |
| `-X` | Define o método HTTP |
| `-d` | Envia dados no corpo da requisição |
| `-fc` | Filtra códigos HTTP |
| `-fs` | Filtra respostas por tamanho |
| `-fw` | Filtra respostas por quantidade de palavras |
| `-mc` | Define códigos HTTP que devem corresponder |
| `-t` | Define número de threads |
| `-o` | Salva resultados em arquivo |
| `-of` | Define formato da saída |

Consulte `ffuf -h` para confirmar os parâmetros da versão instalada.

## 5. Descoberta de diretórios

Em um laboratório local:

```bash
ffuf \
  -w /usr/share/wordlists/dirb/common.txt \
  -u http://127.0.0.1:8080/FUZZ
```

A ferramenta testa cada palavra da lista no local indicado por `FUZZ`.

## 6. Filtrando respostas

Servidores podem responder de maneiras diferentes para caminhos existentes e inexistentes.

Exemplo:

```bash
ffuf \
  -w /usr/share/wordlists/dirb/common.txt \
  -u http://127.0.0.1:8080/FUZZ \
  -fc 404
```

O parâmetro `-fc 404` filtra respostas com código 404.

Também é possível filtrar por tamanho:

```bash
ffuf \
  -w /usr/share/wordlists/dirb/common.txt \
  -u http://127.0.0.1:8080/FUZZ \
  -fs 1234
```

Esse exemplo ignora respostas com 1234 bytes.

**Atenção:** filtros mal escolhidos podem esconder resultados importantes. Compare respostas de caminhos conhecidos e inexistentes antes de decidir o que filtrar.

## 7. Teste de extensão de arquivos

Em um laboratório:

```bash
ffuf \
  -w /usr/share/wordlists/dirb/common.txt \
  -u http://127.0.0.1:8080/FUZZ \
  -e .php,.html,.txt
```

O parâmetro `-e` acrescenta extensões às palavras testadas.

## 8. Fuzzing de parâmetros

O FFUF também pode inserir valores em parâmetros de URL.

Exemplo em uma aplicação de laboratório:

```bash
ffuf \
  -w parametros.txt \
  -u "http://127.0.0.1:8080/search?FUZZ=teste"
```

O programa substitui `FUZZ` por cada palavra da lista.

## 9. Salvando resultados

```bash
ffuf \
  -w /usr/share/wordlists/dirb/common.txt \
  -u http://127.0.0.1:8080/FUZZ \
  -o resultados.json \
  -of json
```

O arquivo JSON pode ser analisado posteriormente com Python ou outras ferramentas.

## 10. Interpretando resultados

Observe principalmente:

- Status HTTP.
- Tamanho da resposta.
- Número de palavras.
- Número de linhas.
- URL encontrada.
- Diferenças entre respostas.

Um código 200 não significa necessariamente que existe um recurso real: algumas aplicações usam páginas de erro personalizadas que também respondem com 200.

## 11. Cuidados

- Use listas adequadas ao objetivo.
- Evite concorrência excessiva.
- Não faça fuzzing em aplicações sem autorização.
- Em produção, combine limites de requisições com uma janela de teste aprovada.
- Não confunda uma resposta diferente com uma vulnerabilidade confirmada.

## 12. Documentação

- GitHub: https://github.com/ffuf/ffuf
- Wiki: https://github.com/ffuf/ffuf/wiki
- Releases: https://github.com/ffuf/ffuf/releases
