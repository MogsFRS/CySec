# SQLmap — SQL Injection Testing

## 1. O que é o SQLmap?

O **SQLmap** é uma ferramenta de código aberto desenvolvida em Python que automatiza a identificação e a exploração de vulnerabilidades de SQL Injection em aplicações que utilizam bancos de dados relacionais.

Seu objetivo é testar se dados enviados por um usuário estão sendo incorporados de maneira insegura em consultas SQL executadas pelo servidor.

Quando encontra uma vulnerabilidade explorável, o SQLmap consegue, dependendo das permissões e das características do banco de dados:

- Identificar parâmetros vulneráveis.
- Identificar o sistema gerenciador de banco de dados (DBMS).
- Identificar a versão do banco de dados.
- Consultar informações sobre o banco.
- Listar bancos de dados.
- Listar tabelas.
- Listar colunas.
- Recuperar registros de tabelas em um ambiente autorizado.
- Identificar usuários e privilégios do banco.
- Realizar determinados testes de acesso ao sistema de arquivos e ao sistema operacional, quando a configuração do banco permite.

O SQLmap automatiza tarefas que, manualmente, exigiriam conhecimento de HTTP, SQL, comportamento da aplicação e técnicas de injeção.

**Importante:** o SQLmap não cria uma vulnerabilidade. Ele identifica e testa vulnerabilidades que já existem na aplicação.

Projeto oficial:

https://github.com/sqlmapproject/sqlmap

Documentação:

https://github.com/sqlmapproject/sqlmap/wiki

---

# PARTE 1 — ENTENDENDO SQL INJECTION

## 2. O que é SQL?

SQL significa **Structured Query Language**. É uma linguagem utilizada para interagir com bancos de dados relacionais.

Com ela, aplicações podem:

- Consultar informações.
- Inserir registros.
- Atualizar informações.
- Excluir registros.
- Criar tabelas.
- Gerenciar usuários e permissões.

Exemplo de consulta:

```sql
SELECT * FROM users;
```

Essa instrução solicita todos os registros da tabela `users`.

Uma consulta mais específica:

```sql
SELECT * FROM users WHERE id = 10;
```

Nesse caso, o banco retorna os registros cujo identificador é igual a 10.

Outros exemplos:

```sql
INSERT INTO users (name, email)
VALUES ('Alice', 'alice@example.com');
```

Insere um registro.

```sql
UPDATE users
SET name = 'Alice Silva'
WHERE id = 10;
```

Atualiza um registro.

```sql
DELETE FROM users
WHERE id = 10;
```

Remove um registro.

O problema começa quando uma aplicação mistura instruções SQL com dados fornecidos pelo usuário de maneira insegura.

## 3. O que é SQL Injection?

**SQL Injection (SQLi)** é uma vulnerabilidade que ocorre quando uma aplicação incorpora entradas controladas pelo usuário em uma consulta SQL sem tratá-las adequadamente.

Isso pode permitir que o usuário altere a estrutura ou a lógica da consulta que será executada pelo banco de dados.

Imagine uma aplicação que possui uma página de produtos:

```text
http://localhost/product.php?id=10
```

O parâmetro `id` informa qual produto deve ser consultado.

O servidor recebe o valor e constrói uma consulta SQL.

Uma implementação insegura em PHP poderia ser:

```php
<?php

$id = $_GET['id'];

$query = "SELECT * FROM products WHERE id = $id";

$result = mysqli_query($connection, $query);

?>
```

O problema está nesta linha:

```php
$query = "SELECT * FROM products WHERE id = $id";
```

O valor recebido do usuário é incorporado diretamente na instrução SQL.

O servidor não está separando corretamente o código SQL dos dados recebidos.

Isso cria a possibilidade de SQL Injection.

## 4. Como a vulnerabilidade acontece?

Considere a consulta original:

```sql
SELECT * FROM products WHERE id = 10;
```

O banco recebe uma consulta válida e retorna o produto correspondente.

Agora imagine que a aplicação não valida corretamente o parâmetro e permite que o usuário envie conteúdo que altera a lógica da consulta.

Uma entrada de teste pode ser:

```text
10 OR 1=1
```

A consulta resultante pode se tornar:

```sql
SELECT * FROM products WHERE id = 10 OR 1=1;
```

A condição:

```sql
1=1
```

é sempre verdadeira.

Consequentemente, a lógica da consulta foi alterada.

Esse é o princípio fundamental da SQL Injection: a aplicação deveria tratar o conteúdo recebido como dado, mas permite que ele seja interpretado como parte do código SQL.

### Representação do problema

```text
Usuário
   |
   | Envia um parâmetro
   v
Aplicação Web
   |
   | Incorpora o valor diretamente na consulta
   v
Banco de Dados
   |
   | Interpreta a consulta alterada
   v
Resultado inesperado
```

O SQLmap automatiza testes para identificar esse tipo de comportamento.

## 5. Tipos de SQL Injection

Existem diferentes formas de SQL Injection. O método disponível depende de como a aplicação executa a consulta e de como o resultado é apresentado.

### 5.1. Error-Based SQL Injection

Também conhecida como SQL Injection baseada em erros.

Ocorre quando a aplicação apresenta mensagens de erro do banco de dados que podem revelar informações sobre a consulta ou o ambiente.

Exemplo conceitual:

```sql
SELECT * FROM products WHERE id = 'entrada_invalida;
```

Se a aplicação apresentar mensagens detalhadas do banco, um pesquisador pode obter informações como:

- Tipo do banco de dados.
- Sintaxe SQL utilizada.
- Estrutura da consulta.
- Nome de determinadas tabelas ou colunas, dependendo do erro.

O SQLmap consegue utilizar respostas de erro como canal para identificar e, em algumas situações, recuperar informações.

**Característica:** a aplicação revela informações por meio de erros.

### 5.2. UNION-Based SQL Injection

A técnica UNION utiliza o operador SQL `UNION` para combinar os resultados de consultas.

Exemplo:

```sql
SELECT name FROM products
UNION
SELECT username FROM users;
```

A consulta combina resultados de duas instruções SELECT compatíveis.

Em uma aplicação vulnerável, a técnica pode permitir que dados de outra tabela apareçam na resposta da aplicação.

Para que o UNION funcione, as consultas precisam ter estruturas compatíveis, incluindo a quantidade de colunas e tipos de dados compatíveis.

O SQLmap pode automatizar a identificação da quantidade de colunas e a construção de consultas compatíveis.

**Característica:** os resultados da consulta injetada podem ser exibidos diretamente na resposta HTTP.

### 5.3. Boolean-Based Blind SQL Injection

Ocorre quando a aplicação não apresenta diretamente os dados do banco, mas seu comportamento muda de acordo com o resultado de uma condição SQL.

Imagine duas condições:

```sql
1=1
```

```sql
1=2
```

A primeira é verdadeira e a segunda é falsa.

Se a aplicação apresentar respostas diferentes para essas condições, existe a possibilidade de utilizar essa diferença como um canal de informação.

Exemplo:

```text
Condição verdadeira:
Página apresenta o produto.

Condição falsa:
Página apresenta resultado vazio.
```

O SQLmap compara as respostas e utiliza essas diferenças para avaliar as condições testadas.

**Característica:** a informação é recuperada por meio de diferenças no comportamento da aplicação.

### 5.4. Time-Based Blind SQL Injection

É uma técnica de SQL Injection cega baseada no tempo de resposta.

Ela é utilizada quando a aplicação não revela erros nem apresenta diferenças visíveis suficientes na página.

O princípio consiste em avaliar se determinadas condições fazem o banco demorar para responder.

Exemplo conceitual:

```text
Requisição normal:
Resposta em 0,2 segundo.

Requisição com condição verdadeira:
Resposta em 5 segundos.

Requisição com condição falsa:
Resposta em 0,2 segundo.
```

Se o comportamento for consistente, o tempo de resposta pode funcionar como um canal de informação.

O SQLmap possui mecanismos para automatizar esse processo.

**Característica:** o tempo de resposta é utilizado como indicador.

Essa técnica pode ser lenta, pois depende de várias requisições e comparações.

### 5.5. Stacked Queries

Stacked Queries ocorre quando o banco de dados e a aplicação permitem que múltiplas instruções SQL sejam executadas na mesma sequência.

Exemplo conceitual:

```sql
SELECT * FROM products WHERE id = 10;

SELECT CURRENT_USER;
```

A possibilidade de executar instruções adicionais depende do DBMS, do driver e da maneira como a aplicação realiza as consultas.

Essa técnica pode ter impacto maior porque determinadas instruções adicionais podem modificar dados.

**Característica:** execução de instruções SQL adicionais, quando suportada.

### 5.6. Inline Queries

São técnicas que utilizam subconsultas ou expressões SQL inseridas dentro de outra consulta.

O SQLmap também contempla esse tipo de técnica em seu mecanismo de detecção.

---

## 6. Técnicas de SQL Injection suportadas pelo SQLmap

O SQLmap possui seis categorias principais de técnicas de SQL Injection:

| Letra | Técnica | Descrição |
|---|---|---|
| B | Boolean-based blind | Analisa condições verdadeiras e falsas |
| E | Error-based | Utiliza erros do banco |
| U | UNION query-based | Combina resultados de consultas |
| S | Stacked queries | Testa múltiplas instruções SQL |
| T | Time-based blind | Analisa o tempo de resposta |
| Q | Inline queries | Utiliza consultas e expressões SQL internas |

Por padrão, o SQLmap utiliza:

```bash
--technique=BEUSTQ
```

Isso significa que ele pode testar todas as técnicas suportadas.

É possível selecionar técnicas específicas:

```bash
--technique=BE
```

Nesse caso, o SQLmap limita os testes a Error-Based e Boolean-Based Blind.

Outro exemplo:

```bash
--technique=BT
```

Utiliza Boolean-Based Blind e Time-Based Blind.

---

# PARTE 2 — PREVENÇÃO E LABORATÓRIO

## 7. Como prevenir SQL Injection?

Entender como corrigir SQL Injection é tão importante quanto saber identificá-la.

A principal proteção é utilizar **consultas parametrizadas**, também conhecidas como prepared statements.

### Implementação vulnerável

```php
<?php

$id = $_GET['id'];

$query = "SELECT * FROM products WHERE id = $id";

$result = mysqli_query($connection, $query);

?>
```

O valor recebido é incorporado diretamente à consulta.

### Implementação protegida

```php
<?php

$id = $_GET['id'];

$query = "SELECT * FROM products WHERE id = ?";

$stmt = mysqli_prepare($connection, $query);

mysqli_stmt_bind_param($stmt, "i", $id);

mysqli_stmt_execute($stmt);

$result = mysqli_stmt_get_result($stmt);

?>
```

Agora o valor é enviado separadamente da estrutura SQL.

O banco interpreta o parâmetro como dado, não como parte da instrução SQL.

### Outras medidas de proteção

| Medida | Objetivo |
|---|---|
| Prepared statements | Separar dados da consulta |
| Validação de entrada | Verificar se os valores possuem o formato esperado |
| Privilégio mínimo | Limitar o que a conta do banco pode fazer |
| Tratamento de erros | Evitar exposição de detalhes internos |
| Atualização de componentes | Corrigir falhas conhecidas |
| Monitoramento | Identificar comportamentos suspeitos |

A validação de entrada é complementar. Ela não substitui consultas parametrizadas.

Também é importante evitar que a aplicação utilize contas administrativas do banco de dados sem necessidade.

Referência OWASP:

https://owasp.org/www-community/attacks/SQL_Injection

---

## 8. Preparando um laboratório

Para aprender SQLmap, é recomendável utilizar uma aplicação propositalmente vulnerável.

Algumas opções:

- OWASP Juice Shop.
- DVWA.
- Web Security Academy.
- Aplicações de treinamento próprias.

### Opção A: PortSwigger Web Security Academy

A PortSwigger oferece laboratórios de SQL Injection que podem ser realizados diretamente pelo navegador.

https://portswigger.net/web-security/sql-injection

É uma opção interessante porque apresenta exercícios com diferentes tipos de vulnerabilidade.

### Opção B: DVWA

O DVWA é uma aplicação desenvolvida para treinamento de segurança web.

Projeto:

https://github.com/digininja/DVWA

Pode ser executado em ambiente local com Docker.

### Opção C: OWASP Juice Shop

Projeto:

https://github.com/juice-shop/juice-shop

É uma aplicação intencionalmente vulnerável, com desafios relacionados a diversas categorias de segurança web.

### Endereço de laboratório

Nos exemplos deste documento, será utilizado:

```text
http://127.0.0.1:8080
```

Esse endereço representa uma aplicação executada localmente.

Adapte os caminhos e parâmetros conforme a aplicação que estiver utilizando.

**Não execute os exemplos contra sites de terceiros sem autorização explícita.**

---

# PARTE 3 — INSTALAÇÃO DO SQLMAP

## 9. Instalando no Kali Linux

Como o Kali possui o SQLmap nos repositórios, a instalação pode ser realizada pelo APT.

Atualize a lista de pacotes:

```bash
sudo apt update
```

Instale:

```bash
sudo apt install sqlmap
```

Verifique:

```bash
sqlmap --version
```

Consulte a ajuda:

```bash
sqlmap -h
```

Para visualizar a ajuda avançada:

```bash
sqlmap -hh
```

## 10. Instalação pelo GitHub

Também é possível obter a versão de desenvolvimento diretamente do projeto oficial.

Clone o repositório:

```bash
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git
```

Entre no diretório:

```bash
cd sqlmap
```

Execute:

```bash
python3 sqlmap.py -h
```

Para verificar a versão:

```bash
python3 sqlmap.py --version
```

O SQLmap é escrito em Python e pode ser executado diretamente, sem um processo tradicional de compilação.

### Diferença entre APT e GitHub

| Método | Característica |
|---|---|
| APT | Instalação integrada ao sistema e atualizações pelo gerenciador de pacotes |
| GitHub | Acesso direto ao código do projeto e atualizações do repositório |

Se utilizar o GitHub, o executável ficará dentro da pasta clonada.

---

# PARTE 4 — ENTENDENDO A ESTRUTURA DO SQLMAP

## 11. Sintaxe básica

A estrutura geral é:

```bash
sqlmap [opções]
```

Um comando pode conter:

```bash
sqlmap -u "URL" [parâmetros]
```

O SQLmap precisa saber qual aplicação ou requisição deve testar.

As opções determinam:

- Qual é o alvo.
- Quais parâmetros serão analisados.
- Como as requisições serão enviadas.
- Quais técnicas serão utilizadas.
- Quais informações serão consultadas.
- Como os resultados serão apresentados.

## 12. Principais parâmetros de execução

| Parâmetro | Função |
|---|---|
| `-h` | Exibe ajuda básica |
| `-hh` | Exibe ajuda avançada |
| `--version` | Exibe a versão |
| `-v` | Define o nível de detalhamento |
| `--batch` | Utiliza respostas padrão para perguntas interativas |
| `--flush-session` | Limpa os dados de sessão do alvo atual |
| `--output-dir` | Define o diretório de saída |
| `--no-logging` | Desativa o registro em arquivo |
| `--dependencies` | Verifica dependências opcionais |
| `--purge` | Remove os dados armazenados pelo SQLmap |

Exemplos:

```bash
sqlmap -h
```

```bash
sqlmap -hh
```

```bash
sqlmap --version
```

```bash
sqlmap -v 3
```

O nível de verbosidade vai de 0 a 6.

Quanto maior o número, mais informações são apresentadas durante a execução.

---

# PARTE 5 — DEFININDO O ALVO

## 13. Utilizando -u

O parâmetro `-u` ou `--url` define a URL que será analisada.

Exemplo em laboratório:

```bash
sqlmap -u "http://127.0.0.1:8080/product.php?id=1"
```

O SQLmap identifica os parâmetros da requisição e tenta determinar se algum deles é vulnerável.

Neste exemplo:

```text
http://127.0.0.1:8080/product.php?id=1
```

Temos:

| Elemento | Significado |
|---|---|
| `http://` | Protocolo |
| `127.0.0.1` | Endereço local |
| `8080` | Porta |
| `product.php` | Recurso acessado |
| `id` | Parâmetro |
| `1` | Valor do parâmetro |

O parâmetro `id` é o elemento que será investigado.

## 14. Definindo um parâmetro específico com -p

Por padrão, o SQLmap testa os parâmetros GET e POST encontrados na requisição.

Para especificar um parâmetro:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1" \
  -p id
```

Isso restringe os testes ao parâmetro `id`.

É útil quando uma requisição contém vários parâmetros.

## 15. Ignorando parâmetros com --skip

Para ignorar um parâmetro:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1&category=2" \
  --skip=category
```

O SQLmap deixa de testar `category`.

Também é possível excluir mais de um:

```bash
--skip="category,search"
```

## 16. Definindo o DBMS com --dbms

DBMS significa Database Management System.

É o sistema responsável por gerenciar o banco de dados.

Exemplos:

- MySQL.
- PostgreSQL.
- Microsoft SQL Server.
- Oracle.
- SQLite.
- MariaDB.

O SQLmap tenta identificar automaticamente o DBMS.

Caso você já saiba qual é o sistema utilizado, pode informar:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1" \
  --dbms=MySQL
```

Outros exemplos:

```bash
--dbms=PostgreSQL
```

```bash
--dbms="Microsoft SQL Server"
```

Não é necessário informar essa opção quando o sistema ainda é desconhecido.

---

# PARTE 6 — DETECÇÃO DE SQL INJECTION

## 17. Primeiro teste

Um teste inicial em uma aplicação local:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1"
```

O SQLmap começa a enviar requisições e analisar o comportamento da aplicação.

Ele procura diferenças que possam indicar que o parâmetro está sendo interpretado dentro de uma consulta SQL.

Se identificar um possível ponto de injeção, apresenta informações sobre o parâmetro e a técnica detectada.

## 18. Interpretando a saída

Uma saída ilustrativa pode ser:

```text
[INFO] testing connection to the target URL
[INFO] testing if the target URL content is stable
[INFO] testing if GET parameter 'id' is dynamic
[INFO] heuristic test showed that GET parameter 'id' might be injectable

[INFO] testing SQL injection on GET parameter 'id'
[INFO] GET parameter 'id' appears to be injectable

[INFO] the back-end DBMS is MySQL
```

Essas mensagens representam etapas diferentes.

| Mensagem | Significado |
|---|---|
| Testing connection | Verifica a comunicação com o alvo |
| Content is stable | Avalia a estabilidade da resposta |
| Parameter is dynamic | Verifica se o parâmetro influencia a resposta |
| Might be injectable | Indica um possível comportamento de injeção |
| Appears to be injectable | Indica uma vulnerabilidade identificada |
| Back-end DBMS | Identificação do banco de dados |

Uma indicação heurística não deve ser tratada como confirmação definitiva.

A confirmação depende dos testes e das evidências apresentadas pelo SQLmap.

## 19. Definindo o nível de teste com --level

O parâmetro `--level` controla a quantidade e a abrangência dos testes de detecção.

Os níveis vão de 1 a 5.

| Nível | Característica |
|---|---|
| 1 | Testes básicos |
| 2 | Inclui mais pontos de entrada, como cookies |
| 3 | Inclui outros cabeçalhos HTTP, como User-Agent e Referer |
| 4 | Amplia a quantidade de testes |
| 5 | Realiza uma bateria mais abrangente |

Exemplo:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1" \
  --level=3
```

Quanto maior o nível, maior pode ser a quantidade de requisições.

## 20. Definindo o risco com --risk

O parâmetro `--risk` controla o risco associado aos testes executados.

Os valores vão de 1 a 3.

| Risco | Característica |
|---|---|
| 1 | Testes considerados menos arriscados |
| 2 | Adiciona determinados testes mais pesados |
| 3 | Inclui testes potencialmente mais perigosos |

Exemplo:

```bash
--risk=1
```

O padrão é `1`.

**Atenção:** risco não é sinônimo de dificuldade. O parâmetro determina quais testes serão utilizados e seu potencial de impacto.

Alguns testes de nível de risco mais elevado podem alterar dados em determinadas situações, especialmente quando a aplicação utiliza consultas de atualização ou exclusão.

Não aumente o risco indiscriminadamente.

## 21. Diferença entre level e risk

Essa distinção é importante:

- `--level`: controla a abrangência e a quantidade de testes.
- `--risk`: controla a inclusão de testes potencialmente mais perigosos.

Exemplo:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1" \
  --level=3 \
  --risk=1
```

Esse comando amplia os testes, mas mantém o nível de risco padrão.

---

# PARTE 7 — MÉTODOS HTTP E REQUISIÇÕES

## 22. Requisições GET

GET é utilizado quando os dados são enviados pela URL.

Exemplo:

```http
GET /product.php?id=1 HTTP/1.1
Host: 127.0.0.1:8080
```

Para analisar esse parâmetro:

```bash
sqlmap -u "http://127.0.0.1:8080/product.php?id=1"
```

## 23. Requisições POST

POST normalmente envia dados no corpo da requisição.

Exemplo:

```http
POST /login.php HTTP/1.1
Host: 127.0.0.1:8080
Content-Type: application/x-www-form-urlencoded

username=admin&password=123456
```

Para informar os dados ao SQLmap, utiliza-se `--data`.

Exemplo de laboratório:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/search.php" \
  --data="id=1"
```

O SQLmap entende que os dados devem ser enviados por POST.

Também é possível utilizar múltiplos parâmetros:

```bash
--data="id=1&category=2"
```

## 24. Utilizando cookies

Algumas aplicações exigem autenticação para acessar determinadas funcionalidades.

Nesse caso, pode ser necessário enviar um cookie de sessão.

O parâmetro é:

```bash
--cookie
```

Exemplo com sessão fictícia:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/profile.php?id=1" \
  --cookie="PHPSESSID=SESSAO_DO_LABORATORIO"
```

O cookie permite que o SQLmap envie requisições utilizando o contexto de autenticação fornecido.

Não compartilhe cookies reais ou tokens de sessão em relatórios públicos.

## 25. Utilizando cabeçalhos HTTP

O parâmetro `-H` permite adicionar cabeçalhos personalizados.

Exemplo:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1" \
  -H "X-Test: laboratorio"
```

Também é possível utilizar:

```bash
--user-agent="Mozilla/5.0"
```

Para informar um User-Agent específico.

E:

```bash
--referer="http://127.0.0.1:8080/"
```

Para definir o Referer.

## 26. Carregando uma requisição com -r

Uma das funcionalidades mais úteis do SQLmap é a possibilidade de carregar uma requisição HTTP salva em arquivo.

Isso é especialmente importante quando a aplicação exige:

- Autenticação.
- Cookies.
- Cabeçalhos específicos.
- Dados POST.
- Tokens CSRF.
- Parâmetros que não aparecem diretamente na URL.

### Capturando pelo Burp Suite

1. Abra o Burp Suite.
2. Acesse a aplicação do laboratório pelo navegador integrado.
3. Faça a operação que deseja testar.
4. Abra o histórico HTTP.
5. Localize a requisição.
6. Salve a requisição em um arquivo.

Exemplo de nome:

```text
request.txt
```

Uma requisição fictícia pode ser:

```http
GET /product.php?id=1 HTTP/1.1
Host: 127.0.0.1:8080
User-Agent: Mozilla/5.0
Accept: text/html
Connection: close
```

Execute:

```bash
sqlmap -r request.txt
```

O SQLmap utiliza os dados presentes no arquivo para reproduzir a requisição.

### Requisição POST

Um arquivo pode conter:

```http
POST /search.php HTTP/1.1
Host: 127.0.0.1:8080
Content-Type: application/x-www-form-urlencoded
Cookie: PHPSESSID=SESSAO_DO_LABORATORIO

id=1
```

Execução:

```bash
sqlmap -r request.txt
```

Essa abordagem é frequentemente mais confiável do que tentar reconstruir manualmente uma requisição complexa.

## 27. Marcando um ponto específico de injeção

O SQLmap também permite marcar manualmente o ponto que deve ser testado usando um asterisco:

```text
*
```

Isso é útil quando o ponto de entrada não é um parâmetro tradicional.

Exemplo ilustrativo de caminho:

```bash
sqlmap -u "http://127.0.0.1:8080/product/1*/details"
```

Também pode ser utilizado em parâmetros e cabeçalhos, respeitando a sintaxe documentada.

---

# PARTE 8 — ENUMERAÇÃO DO BANCO DE DADOS

A enumeração é uma das etapas mais importantes do uso do SQLmap.

Depois que uma injeção é identificada, a ferramenta pode consultar informações sobre o DBMS e seus objetos.

Nos exemplos seguintes, utilize exclusivamente um banco de dados de laboratório.

## 28. Identificando o banner

O parâmetro:

```bash
--banner
```

Solicita informações sobre o DBMS.

Exemplo:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1" \
  --banner
```

O banner pode apresentar informações sobre a versão do banco.

## 29. Identificando o usuário atual

Utilize:

```bash
--current-user
```

Exemplo:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1" \
  --current-user
```

O resultado informa a identidade utilizada pela conexão com o banco de dados.

Isso é importante para avaliar os privilégios disponíveis.

## 30. Identificando o banco de dados atual

Utilize:

```bash
--current-db
```

Exemplo:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1" \
  --current-db
```

O resultado indica o banco de dados selecionado para a conexão atual.

## 31. Listando os bancos de dados

Utilize:

```bash
--dbs
```

Exemplo:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1" \
  --dbs
```

O SQLmap tenta enumerar os bancos de dados acessíveis por meio do ponto de injeção.

## 32. Listando as tabelas

Para listar tabelas, é necessário selecionar um banco de dados.

Utilize:

```bash
-D NOME_DO_BANCO --tables
```

Exemplo:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1" \
  -D loja \
  --tables
```

A opção `-D` seleciona o banco de dados.

A opção `--tables` solicita a enumeração das tabelas.

Uma saída ilustrativa:

```text
Database: loja
[3 tables]
+-----------+
| products  |
| users     |
| orders    |
+-----------+
```

## 33. Listando colunas

Para identificar as colunas de uma tabela:

```bash
-T NOME_DA_TABELA --columns
```

Exemplo:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1" \
  -D loja \
  -T users \
  --columns
```

Saída ilustrativa:

```text
Database: loja
Table: users

+----------+
| id       |
| username |
| email    |
| password |
+----------+
```

As colunas representam os campos armazenados na tabela.

## 34. Consultando registros

O parâmetro:

```bash
--dump
```

Solicita a recuperação dos registros da tabela selecionada.

Exemplo em banco de laboratório:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1" \
  -D loja \
  -T products \
  --dump
```

É possível selecionar colunas específicas:

```bash
-C "id,name,price" --dump
```

Exemplo completo:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1" \
  -D loja \
  -T products \
  -C "id,name,price" \
  --dump
```

Isso reduz a consulta às colunas indicadas.

**Atenção:** `--dump` pode recuperar informações sensíveis. Em um teste profissional, limite a extração aos dados estritamente necessários para comprovar o impacto da falha. Não extraia dados pessoais de terceiros.

## 35. Limitando a quantidade de registros

O SQLmap possui opções para limitar a enumeração:

| Parâmetro | Função |
|---|---|
| `--start` | Define o primeiro registro |
| `--stop` | Define o último registro |
| `--first` | Define a primeira posição de caracteres |
| `--last` | Define a última posição de caracteres |

Exemplo:

```bash
--start=1 --stop=5
```

Isso limita a faixa de registros consultada.

## 36. Identificando privilégios

O parâmetro:

```bash
--is-dba
```

Verifica se o usuário atual possui privilégios de administrador do banco, quando essa informação pode ser determinada.

Exemplo:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1" \
  --is-dba
```

O resultado pode ajudar a entender o impacto da vulnerabilidade.

Uma aplicação que utiliza uma conta excessivamente privilegiada pode ampliar muito o impacto de uma SQL Injection.

---

# PARTE 9 — OPÇÕES DE DETECÇÃO E AJUSTE

## 37. Selecionando técnicas com --technique

É possível escolher quais técnicas de SQL Injection serão testadas.

Exemplos:

```bash
--technique=B
```

Boolean-Based Blind.

```bash
--technique=E
```

Error-Based.

```bash
--technique=U
```

UNION-Based.

```bash
--technique=T
```

Time-Based Blind.

```bash
--technique=BE
```

Boolean-Based e Error-Based.

O padrão é:

```bash
--technique=BEUSTQ
```

## 38. Configurando o tempo de espera

A opção:

```bash
--time-sec
```

Define o intervalo utilizado nos testes baseados em tempo.

Exemplo:

```bash
--time-sec=5
```

Esse valor representa o atraso utilizado nas condições de teste de Time-Based Blind.

Não confunda essa opção com o timeout geral de conexão.

## 39. Comparando respostas

Em determinados casos, a aplicação apresenta conteúdo dinâmico, dificultando a comparação entre respostas.

O SQLmap oferece opções para orientar a análise.

| Parâmetro | Função |
|---|---|
| `--string` | Define uma string que deve aparecer na resposta verdadeira |
| `--not-string` | Define uma string associada à resposta falsa |
| `--regexp` | Define uma expressão regular para identificar uma resposta |
| `--code` | Define o código HTTP esperado |
| `--titles` | Compara títulos HTML |
| `--text-only` | Compara somente o conteúdo textual |
| `--smart` | Utiliza heurísticas para selecionar testes mais completos |

Exemplo:

```bash
--string="Produto encontrado"
```

Pode ser útil quando essa frase aparece somente quando a consulta retorna o resultado esperado.

## 40. Controlando a quantidade de requisições

Algumas opções permitem ajustar a comunicação com o servidor.

| Parâmetro | Função |
|---|---|
| `--threads` | Define a quantidade de requisições simultâneas |
| `--delay` | Define intervalo entre requisições |
| `--timeout` | Define tempo máximo de espera |
| `--retries` | Define tentativas adicionais |
| `--keep-alive` | Mantém conexões HTTP persistentes |
| `--random-agent` | Utiliza um User-Agent aleatório |

Exemplo de configuração conservadora:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1" \
  --delay=1 \
  --timeout=15 \
  --retries=2 \
  --threads=1
```

Essa configuração reduz a concorrência e adiciona um intervalo entre requisições.

Para aplicações de produção, a intensidade do teste deve ser definida previamente com os responsáveis pelo sistema.

---

# PARTE 10 — RECURSOS AVANÇADOS

## 41. Utilizando --forms

O parâmetro:

```bash
--forms
```

Solicita que o SQLmap analise formulários encontrados na página.

Exemplo:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/login.php" \
  --forms
```

Isso pode ajudar quando os parâmetros não estão diretamente na URL.

A ferramenta identifica formulários e pode solicitar informações para utilizá-los durante os testes.

## 42. Utilizando --crawl

O parâmetro:

```bash
--crawl
```

Permite que o SQLmap percorra links a partir de uma URL inicial para encontrar outras páginas e possíveis pontos de entrada.

Exemplo:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/" \
  --crawl=2
```

O valor indica a profundidade de navegação.

A opção pode aumentar bastante a quantidade de requisições, por isso deve ser usada com cuidado.

Também existe:

```bash
--crawl-exclude
```

Para excluir URLs que correspondam a uma expressão regular.

## 43. Utilizando --proxy

O parâmetro `--proxy` permite enviar as requisições por um proxy HTTP.

Exemplo com proxy local:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1" \
  --proxy="http://127.0.0.1:8081"
```

Isso pode ser útil para observar as requisições em um ambiente de laboratório.

Também permite integrar o SQLmap a ferramentas de análise HTTP.

## 44. Utilizando --force-ssl

Força a utilização de HTTPS:

```bash
--force-ssl
```

É útil quando o alvo exige comunicação criptografada.

## 45. Utilizando --batch

Durante a execução, o SQLmap pode apresentar perguntas interativas.

Por exemplo:

```text
Do you want to continue?
```

O parâmetro:

```bash
--batch
```

faz com que o SQLmap utilize as respostas padrão.

Exemplo:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1" \
  --batch
```

Isso é útil em scripts e automações.

**Atenção:** `--batch` não significa que todos os testes serão seguros. Ele apenas automatiza as respostas às perguntas.

## 46. Salvando resultados

O SQLmap mantém informações das execuções em seu diretório de dados.

Para definir um diretório específico:

```bash
--output-dir=./resultados
```

Exemplo:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1" \
  --batch \
  --output-dir=./resultados
```

Os resultados também podem ser analisados posteriormente.

## 47. Limpando sessões anteriores

O SQLmap armazena informações das sessões.

Para limpar os dados da sessão do alvo atual:

```bash
--flush-session
```

Exemplo:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1" \
  --flush-session
```

Isso pode ser útil quando uma execução anterior está interferindo em um novo teste.

O parâmetro não substitui o gerenciamento dos arquivos de saída.

## 48. Utilizando --save e --config-file

É possível salvar configurações para reutilização.

Exemplo:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1" \
  --batch \
  --save=sqlmap.conf
```

Depois, é possível carregar configurações de um arquivo:

```bash
sqlmap -c sqlmap.conf
```

Isso é útil para padronizar testes recorrentes em laboratórios.

Revise o arquivo antes de reutilizá-lo, especialmente se ele contiver cookies, tokens ou outras informações de autenticação.

---

# PARTE 11 — TAMPER SCRIPTS E WAF

## 49. O que são Tamper Scripts?

O SQLmap possui scripts chamados **Tamper Scripts**.

Eles transformam partes dos dados enviados pelo SQLmap antes de a requisição ser transmitida.

Esses scripts podem ser utilizados para testar a compatibilidade de aplicações com diferentes representações de entradas e mecanismos de filtragem.

O parâmetro é:

```bash
--tamper
```

O SQLmap disponibiliza uma lista de scripts:

```bash
sqlmap --list-tampers
```

Os scripts ficam no diretório:

```text
tamper/
```

### Como funcionam conceitualmente?

Considere uma entrada SQL:

```sql
SELECT
```

Um mecanismo de transformação pode modificar sua representação antes do envio.

O objetivo é avaliar como diferentes camadas de processamento interpretam os dados.

### Atenção aos WAFs

WAF significa Web Application Firewall.

É um mecanismo de segurança que analisa requisições HTTP e pode bloquear padrões associados a ataques.

Um WAF pode:
- Identificar entradas suspeitas.
- Bloquear requisições.
- Aplicar limites.
- Registrar atividades.
- Interromper padrões de tráfego.

Tamper scripts não garantem que um WAF possa ser contornado.

Em uma avaliação autorizada, seu uso precisa estar previsto no escopo. A documentação oficial apresenta a lista e o comportamento dos scripts.

---

# PARTE 12 — ENTENDENDO O IMPACTO DE SQL INJECTION

## 50. O que uma SQL Injection pode permitir?

O impacto depende de diversos fatores:

- Tipo de banco de dados.
- Permissões da conta utilizada pela aplicação.
- Tipo de consulta vulnerável.
- Técnicas de injeção disponíveis.
- Configuração do servidor.
- Controles de segurança existentes.

Uma SQL Injection pode permitir:

| Impacto | Descrição |
|---|---|
| Leitura de dados | Consultar registros que não deveriam estar acessíveis |
| Alteração de dados | Modificar informações |
| Exclusão de dados | Remover registros |
| Exposição de usuários | Revelar contas e informações associadas |
| Exposição de credenciais | Revelar hashes ou outros dados de autenticação |
| Acesso a informações internas | Consultar metadados e estrutura do banco |
| Impacto no servidor | Em configurações específicas, alcançar recursos além do banco |

Nem toda SQL Injection permite todos esses impactos.

Por exemplo, uma vulnerabilidade que permite somente inferência booleana pode ter capacidades diferentes de uma injeção que permite consultas UNION ou instruções empilhadas.

## 51. A relação entre privilégios e impacto

Imagine dois cenários.

### Cenário A

A aplicação utiliza uma conta com permissões limitadas:

```text
SELECT: permitido
INSERT: negado
UPDATE: negado
DELETE: negado
```

Nesse caso, uma vulnerabilidade pode permitir leitura de dados, mas não necessariamente alteração ou exclusão.

### Cenário B

A aplicação utiliza uma conta administrativa:

```text
SELECT: permitido
INSERT: permitido
UPDATE: permitido
DELETE: permitido
```

O impacto potencial é muito maior.

Por isso, o princípio do menor privilégio é uma medida de segurança fundamental.

## 52. Recursos de sistema de arquivos e sistema operacional

O SQLmap possui funcionalidades avançadas relacionadas ao acesso ao sistema de arquivos e à interação com o sistema operacional.

Entretanto, esses recursos não funcionam automaticamente em qualquer SQL Injection.

Dependem de fatores como:

- DBMS utilizado.
- Permissões do usuário do banco.
- Recursos habilitados.
- Configuração do servidor.
- Técnicas de injeção disponíveis.
- Permissões do processo do banco de dados.

Uma SQL Injection não significa automaticamente execução de comandos no sistema operacional.

Em auditorias, esses recursos devem ser tratados como testes de impacto elevado e realizados somente quando houver autorização expressa e ambiente controlado.

Para demonstrar o impacto de uma vulnerabilidade, normalmente não é necessário executar comandos no servidor: evidências controladas de leitura ou de alteração em dados sintéticos podem ser suficientes.

---

# PARTE 13 — OUTROS TIPOS DE INJEÇÃO NO SQLMAP

## 53. O SQLmap também trabalha com outras classes de injeção?

Sim. Nas versões atuais, além de SQL Injection tradicional, o projeto apresenta opções específicas para alguns outros tipos de injeção.

| Opção | Tecnologia |
|---|---|
| `--nosql` | NoSQL Injection |
| `--graphql` | Injeções alcançadas por endpoints GraphQL |
| `--ldap` | LDAP Injection |
| `--xpath` | XPath Injection |
| `--ssti` | Server-Side Template Injection |
| `--xxe` | XML External Entity |
| `--hql` | HQL/JPQL Injection |

Esses recursos são distintos das técnicas tradicionais de SQL Injection.

Por exemplo:

- SQL Injection envolve consultas SQL.
- NoSQL Injection envolve consultas e operadores de bancos NoSQL.
- LDAP Injection envolve filtros e consultas LDAP.
- SSTI envolve a interpretação de entradas por mecanismos de templates.
- XXE envolve o processamento inseguro de entidades XML externas.

Não confunda essas categorias. O fato de estarem presentes no mesmo programa não significa que sejam a mesma vulnerabilidade.

A documentação do projeto apresenta as opções e limitações de cada modalidade.

---

# PARTE 14 — AUTOMAÇÃO E INTEGRAÇÃO

## 54. Integrando SQLmap com Bash

É possível automatizar testes em laboratórios utilizando scripts Bash.

Exemplo:

```bash
#!/bin/bash

# URL da aplicação local
TARGET="http://127.0.0.1:8080/product.php?id=1"

# Diretório para armazenar os resultados
OUTPUT="./sqlmap-results"

# Executa um teste inicial
sqlmap \
    -u "$TARGET" \
    --batch \
    --risk=1 \
    --level=1 \
    --output-dir="$OUTPUT"

# Verifica o código de saída do processo
if [ $? -eq 0 ]; then
    echo "[+] Execução finalizada."
else
    echo "[-] Ocorreu um erro durante a execução."
fi
```

Salve como:

```text
sqlmap-test.sh
```

Dê permissão:

```bash
chmod +x sqlmap-test.sh
```

Execute:

```bash
./sqlmap-test.sh
```

O código de saída zero indica que o processo terminou sem reportar um erro de execução. Isso não significa que uma vulnerabilidade foi encontrada.

## 55. Integrando SQLmap com Python

Como o SQLmap é escrito em Python, também pode ser chamado por outros programas.

Exemplo:

```python
import subprocess

# Alvo local de laboratório
target = "http://127.0.0.1:8080/product.php?id=1"

# Monta os argumentos do processo
command = [
    "sqlmap",
    "-u", target,
    "--batch",
    "--risk=1",
    "--level=1"
]

# Executa e captura a saída
result = subprocess.run(
    command,
    capture_output=True,
    text=True
)

# Exibe o resultado
print(result.stdout)

# Exibe possíveis erros
if result.stderr:
    print(result.stderr)

# Código de retorno
print("Exit code:", result.returncode)
```

### Entendendo o subprocess

O módulo `subprocess` permite executar programas externos pelo Python.

| Elemento | Função |
|---|---|
| `subprocess.run()` | Executa o programa |
| `command` | Lista com o comando e seus argumentos |
| `capture_output=True` | Captura stdout e stderr |
| `text=True` | Retorna os dados como texto |
| `result.stdout` | Saída padrão |
| `result.stderr` | Saída de erro |
| `result.returncode` | Código de saída |

Utilizar uma lista de argumentos evita problemas comuns de interpretação de comandos pelo shell.

## 56. API do SQLmap

O projeto também possui uma API REST que permite controlar execuções programaticamente.

Isso possibilita integrar o SQLmap a:

- Aplicações Python.
- Interfaces próprias.
- Sistemas de automação.
- Pipelines de auditoria.
- Ferramentas internas de laboratório.

A API permite criar tarefas, iniciar testes, consultar status e recuperar resultados.

Documentação:

https://github.com/sqlmapproject/sqlmap/wiki/Usage#api

---

# PARTE 15 — EXEMPLO DE FLUXO DE TRABALHO

## 57. Como realizar uma avaliação organizada?

Um processo de teste pode ser dividido em etapas.

### Etapa 1 — Identificar os parâmetros

Observe quais parâmetros são utilizados pela aplicação.

Exemplo:

```text
/product.php?id=1
/search.php?term=notebook
/profile.php?user=10
```

### Etapa 2 — Capturar a requisição

Utilize o navegador ou Burp Suite para observar a requisição HTTP.

Verifique:

- Método HTTP.
- URL.
- Parâmetros.
- Cookies.
- Cabeçalhos.
- Dados POST.

### Etapa 3 — Executar um teste inicial

Em uma aplicação de laboratório:

```bash
sqlmap \
  -u "http://127.0.0.1:8080/product.php?id=1" \
  --batch
```

### Etapa 4 — Interpretar a detecção

Observe:

- Parâmetro identificado.
- Tipo de SQL Injection.
- DBMS.
- Evidências apresentadas.
- Possíveis falsos positivos.

### Etapa 5 — Avaliar o impacto de maneira controlada

Em um banco sintético, verifique somente as informações necessárias para demonstrar o problema.

### Etapa 6 — Documentar

Registre:

- URL e parâmetro afetado.
- Requisição HTTP.
- Técnica identificada.
- Evidência da vulnerabilidade.
- Impacto possível.
- Recomendações de correção.

### Etapa 7 — Corrigir e testar novamente

Implemente consultas parametrizadas e repita o teste para confirmar que o comportamento vulnerável foi eliminado.

---

# PARTE 16 — REFERÊNCIA RÁPIDA

## 58. Parâmetros mais utilizados

| Parâmetro | Descrição |
|---|---|
| `-u` | Define a URL |
| `-r` | Carrega requisição HTTP de arquivo |
| `-p` | Seleciona parâmetros |
| `--data` | Envia dados POST |
| `--cookie` | Define cookies |
| `-H` | Adiciona cabeçalhos |
| `--dbms` | Define o tipo de banco |
| `--level` | Define abrangência dos testes |
| `--risk` | Define risco dos testes |
| `--technique` | Seleciona técnicas de injeção |
| `--batch` | Automatiza respostas interativas |
| `--banner` | Consulta informações do DBMS |
| `--current-user` | Consulta usuário atual |
| `--current-db` | Consulta banco atual |
| `--dbs` | Lista bancos de dados |
| `--tables` | Lista tabelas |
| `--columns` | Lista colunas |
| `--dump` | Recupera registros |
| `-D` | Seleciona banco |
| `-T` | Seleciona tabela |
| `-C` | Seleciona colunas |
| `--is-dba` | Verifica privilégios administrativos |
| `--forms` | Analisa formulários |
| `--crawl` | Percorre links |
| `--proxy` | Utiliza proxy |
| `--threads` | Define concorrência |
| `--delay` | Define intervalo entre requisições |
| `--timeout` | Define timeout |
| `--retries` | Define novas tentativas |
| `--output-dir` | Define diretório de resultados |
| `--flush-session` | Limpa a sessão atual |
| `--list-tampers` | Lista Tamper Scripts |

## 59. Comandos de referência para laboratório

### Ajuda

```bash
sqlmap -h
```

### Ajuda avançada

```bash
sqlmap -hh
```

### Versão

```bash
sqlmap --version
```

### Teste de URL

```bash
sqlmap -u "http://127.0.0.1:8080/product.php?id=1"
```

### Teste de parâmetro específico

```bash
sqlmap -u "http://127.0.0.1:8080/product.php?id=1" -p id
```

### Teste de requisição salva

```bash
sqlmap -r request.txt
```

### Informações do DBMS

```bash
sqlmap -u "http://127.0.0.1:8080/product.php?id=1" --banner
```

### Banco de dados atual

```bash
sqlmap -u "http://127.0.0.1:8080/product.php?id=1" --current-db
```

### Usuário atual

```bash
sqlmap -u "http://127.0.0.1:8080/product.php?id=1" --current-user
```

### Listar bancos

```bash
sqlmap -u "http://127.0.0.1:8080/product.php?id=1" --dbs
```

### Listar tabelas

```bash
sqlmap -u "http://127.0.0.1:8080/product.php?id=1" -D loja --tables
```

### Listar colunas

```bash
sqlmap -u "http://127.0.0.1:8080/product.php?id=1" -D loja -T users --columns
```

### Recuperar dados sintéticos de laboratório

```bash
sqlmap -u "http://127.0.0.1:8080/product.php?id=1" -D loja -T products -C "id,name" --dump
```

---

# PARTE 17 — CONSIDERAÇÕES FINAIS

## 60. O que você deve dominar para utilizar SQLmap?

O SQLmap é uma ferramenta poderosa, mas seu uso correto depende de conhecimentos que vão além dos parâmetros do programa.

É importante compreender:

1. **SQL:** como consultas são construídas e executadas.
2. **HTTP:** como requisições e respostas funcionam.
3. **Parâmetros:** como dados são enviados por GET, POST, cookies e cabeçalhos.
4. **SQL Injection:** como uma entrada pode alterar uma consulta.
5. **DBMS:** diferenças entre MySQL, PostgreSQL, SQL Server e outros.
6. **Técnicas de injeção:** como o SQLmap identifica e utiliza cada canal.
7. **Privilégios:** como permissões do banco afetam o impacto.
8. **Análise de resultados:** como diferenciar evidências de suspeitas.
9. **Correção:** como consultas parametrizadas eliminam a causa principal.

O SQLmap automatiza grande parte do processo, mas não substitui a compreensão técnica do pesquisador.

Uma pessoa que sabe utilizar SQLmap, mas não entende SQL, HTTP ou a aplicação testada, terá dificuldade para interpretar os resultados e identificar situações mais complexas.

## 61. Referências oficiais

- Projeto SQLmap: https://github.com/sqlmapproject/sqlmap
- Documentação de utilização: https://github.com/sqlmapproject/sqlmap/wiki/Usage
- Introdução: https://github.com/sqlmapproject/sqlmap/wiki/Introduction
- Recursos: https://github.com/sqlmapproject/sqlmap/wiki/Features
- FAQ: https://github.com/sqlmapproject/sqlmap/wiki/FAQ
- OWASP SQL Injection: https://owasp.org/www-community/attacks/SQL_Injection
- OWASP Prevention Cheat Sheet: https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html
- PortSwigger SQL Injection: https://portswigger.net/web-security/sql-injection
- DVWA: https://github.com/digininja/DVWA
- OWASP Juice Shop: https://github.com/juice-shop/juice-shop
