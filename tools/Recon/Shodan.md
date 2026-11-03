# Shodan — Busca por Dispositivos e Serviços Expostos na Internet

## 1. O que é?

O **Shodan** é um mecanismo de busca especializado em dispositivos e serviços conectados à internet.

Enquanto mecanismos de busca tradicionais indexam páginas e conteúdos, o Shodan coleta informações sobre serviços que respondem em endereços IP públicos.

Ele pode apresentar informações como:
- Endereço IP.
- Portas e serviços identificados.
- Banners de serviços.
- Servidor web e versão anunciada.
- Certificados.
- Organização e localização aproximada.
- Informações de determinados dispositivos conectados.

É utilizado em OSINT, inventário de ativos, pesquisa de exposição e análise de superfície de ataque.

Site: https://www.shodan.io/

## 2. Como funciona?

O Shodan realiza varreduras na internet e registra respostas dos serviços encontrados.

Uma unidade importante desses registros é o **banner**: um conjunto de informações que um serviço fornece quando o Shodan se conecta a ele.

Exemplo ilustrativo:

```text
IP: 203.0.113.10
Porta: 80
Serviço: HTTP
Servidor: nginx
Resposta: HTTP/1.1 200 OK
```

O banner não prova que o serviço possui uma vulnerabilidade. Ele representa informações observadas durante a coleta.

## 3. Pesquisa pelo site

A interface web permite pesquisar serviços usando palavras e filtros.

Exemplos de sintaxe:

```text
apache
```

Procura registros que contenham o termo no conteúdo pesquisável.

```text
port:22
```

Procura serviços identificados na porta 22.

```text
country:BR
```

Filtra por país.

```text
org:"Example Organization"
```

Filtra por organização.

```text
hostname:example.com
```

Pesquisa registros associados ao hostname informado.

Os filtros podem ser combinados:

```text
port:443 country:BR
```

Isso restringe os resultados a registros que correspondam aos dois critérios.

**Importante:** exemplos com `example.com` ou organizações fictícias servem apenas para demonstrar a sintaxe. Para estudar ativos reais, utilize somente os ativos que você possui ou está autorizado a avaliar.

## 4. Instalação da CLI no Kali

A interface de linha de comando é distribuída como pacote Python.

Em ambientes com Python gerenciado pelo sistema, prefira um ambiente virtual:

```bash
python3 -m venv ~/.venvs/shodan
source ~/.venvs/shodan/bin/activate
pip install --upgrade shodan
```

Confira:

```bash
shodan --help
```

## 5. Configuração da API

Para utilizar a CLI, crie uma conta e obtenha uma chave de API na plataforma Shodan.

Depois inicialize a ferramenta:

```bash
shodan init SUA_API_KEY
```

Não compartilhe sua chave e não a publique em repositórios.

## 6. Comandos principais

### Consultar ajuda

```bash
shodan --help
```

### Consultar informações de um IP

```bash
shodan host 203.0.113.10
```

Esse IP pertence a uma faixa reservada para documentação. Substitua-o por um endereço do seu laboratório ou de um ativo autorizado.

### Pesquisar registros

```bash
shodan search 'port:443'
```

### Limitar os resultados

```bash
shodan search --limit 10 'port:443'
```

### Selecionar campos

```bash
shodan search --fields ip_str,port,org 'port:443'
```

### Consultar a versão

```bash
shodan version
```

## 7. Entendendo os resultados

| Campo | Significado |
|---|---|
| IP | Endereço do dispositivo |
| Port | Porta do serviço |
| Hostname | Nome associado ao endereço |
| Org | Organização associada ao IP |
| Data | Conteúdo do banner |
| Location | Dados geográficos aproximados |

Os resultados podem estar desatualizados. Um serviço pode ter sido removido, atualizado ou configurado de outra maneira desde a última coleta.

## 8. Shodan CLI e créditos

A CLI utiliza a API do Shodan. Algumas operações consomem créditos ou dependem do plano da conta.

A documentação oficial explica as diferenças entre `search`, `download` e `parse`, além das limitações de consulta.

## 9. Cuidados

- Não interprete uma porta aberta como prova de vulnerabilidade.
- Não tente acessar ou explorar dispositivos encontrados sem autorização.
- Não publique chaves de API.
- Considere a data da coleta ao analisar um resultado.
- Use os dados como ponto de partida para uma investigação, não como confirmação definitiva.

## 10. Documentação oficial

- Site: https://www.shodan.io/
- Central de ajuda: https://help.shodan.io/
- Sintaxe de pesquisa: https://help.shodan.io/the-basics/search-query-fundamentals
- Instalação da CLI: https://help.shodan.io/command-line-interface/0-installation
- CLI: https://help.shodan.io/command-line-interface/1-getting-started
