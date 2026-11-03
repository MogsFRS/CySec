# Burp Suite — Análise e Testes de Aplicações Web

## 1. O que é?

O **Burp Suite** é uma plataforma de testes de segurança para aplicações web. Ele permite observar, interceptar, modificar e reenviar as requisições HTTP e HTTPS feitas entre um navegador e um servidor.

É especialmente útil para estudar:
- Como uma aplicação web se comunica com o servidor.
- Como formulários enviam dados.
- Como funcionam cookies e sessões.
- Como APIs recebem e respondem a requisições.
- Como testar controles de autenticação e autorização.
- Como identificar possíveis falhas de segurança.

O Burp Suite não é simplesmente um scanner de vulnerabilidades: boa parte do seu valor está na análise manual das requisições e respostas.

## 2. Edições

Existem duas edições principais para desktop:

| Edição | Características |
|---|---|
| Community | Gratuita; inclui proxy, histórico HTTP, Repeater, Decoder, Sequencer e recursos básicos de Intruder |
| Professional | Paga; adiciona scanner de vulnerabilidades, recursos avançados de automação e outras funcionalidades |

A edição Community é suficiente para aprender os fundamentos de análise HTTP.

## 3. Instalação

No Kali Linux, é possível instalar pelo APT:

```bash
sudo apt update
sudo apt install burpsuite
```

Para conferir a instalação:

```bash
burpsuite
```

Também é possível baixar a edição Community diretamente:

https://portswigger.net/burp/communitydownload

## 4. Como o Burp funciona?

O Burp atua como um proxy intermediário:

```text
Navegador
    |
    | Requisição HTTP/HTTPS
    v
Burp Suite
    |
    | Requisição encaminhada
    v
Servidor Web
    |
    | Resposta
    v
Burp Suite
    |
    | Resposta encaminhada
    v
Navegador
```

Isso permite visualizar e modificar os dados enviados e recebidos.

Para analisar HTTPS, o navegador precisa confiar no certificado da autoridade certificadora do Burp. Use essa configuração somente em um navegador ou ambiente de laboratório.

## 5. Principais ferramentas

### Proxy

Intercepta e registra o tráfego HTTP/HTTPS.

É possível:
- Visualizar cabeçalhos.
- Analisar cookies.
- Modificar parâmetros.
- Encaminhar ou descartar requisições.
- Consultar o histórico de tráfego.

### Repeater

Permite reenviar uma requisição manualmente e modificar seus dados entre os testes.

Exemplo de uso:
1. Acesse uma aplicação de laboratório.
2. Faça uma requisição normal.
3. Envie a requisição para o Repeater.
4. Modifique um parâmetro.
5. Reenvie a requisição.
6. Compare as respostas.

É muito útil para entender como o servidor processa entradas diferentes.

### Intruder

Automatiza o envio de requisições com diferentes valores.

Pode ser utilizado para testar:
- Parâmetros.
- Campos de formulários.
- Valores de cabeçalhos.
- Comportamento de entradas.

Na edição Community, o Intruder possui limitações em comparação com a edição Professional.

### Decoder

Converte e transforma dados em formatos como:
- URL encoding.
- HTML encoding.
- Base64.
- Hexadecimal.

### Sequencer

Analisa a aleatoriedade de tokens, como identificadores de sessão.

### Target

Organiza os endereços e recursos identificados durante a análise. Também permite definir o escopo do teste.

## 6. Primeiro exercício: interceptar uma requisição

1. Abra o Burp Suite.
2. Selecione um projeto temporário.
3. Inicie o Burp.
4. Abra o navegador integrado do Burp.
5. Acesse uma aplicação de laboratório, como um exercício da Web Security Academy.
6. Abra a aba Proxy.
7. Observe as requisições no histórico HTTP.
8. Ative a interceptação e faça outra requisição.
9. Analise os cabeçalhos e os parâmetros apresentados.

Web Security Academy:

https://portswigger.net/web-security

## 7. Exemplo de requisição HTTP

Uma requisição pode ser semelhante a esta:

```http
GET /products?id=10 HTTP/1.1
Host: lab.example
User-Agent: Mozilla/5.0
Cookie: session=abc123
Accept: text/html
```

Elementos importantes:

| Elemento | Significado |
|---|---|
| GET | Método HTTP |
| /products?id=10 | Caminho e parâmetro |
| Host | Servidor de destino |
| User-Agent | Identificação do cliente |
| Cookie | Dados associados à sessão |
| Accept | Tipos de conteúdo aceitos |

O Repeater permite alterar o valor de `id` e observar como a aplicação responde. Em um laboratório, isso ajuda a estudar validação de entrada e controle de acesso.

## 8. Cuidados

- Não intercepte tráfego de outras pessoas.
- Não instale certificados do Burp em dispositivos de terceiros.
- Não faça testes em aplicações sem autorização.
- Não execute testes automatizados em sistemas de produção sem autorização e definição de limites.
- Defina o escopo antes de iniciar testes.

## 9. Documentação oficial

- Documentação: https://portswigger.net/burp/documentation
- Primeiros passos: https://portswigger.net/burp/documentation/desktop/getting-started
- Download Community: https://portswigger.net/burp/communitydownload
- Laboratórios: https://portswigger.net/web-security

