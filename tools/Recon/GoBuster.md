# Gobuster — Enumeração de Diretórios, DNS e Virtual Hosts

## 1. O que é?

O **Gobuster** é uma ferramenta de enumeração escrita em Go. Ela utiliza wordlists para testar nomes e identificar recursos que podem existir em diferentes serviços.

É capaz de trabalhar com diferentes modos, incluindo:
- Diretórios e arquivos web.
- Subdomínios DNS.
- Virtual hosts.
- Buckets de armazenamento em nuvem.
- Fuzzing de parâmetros e outros elementos, conforme a versão.

Projeto: https://github.com/OJ/gobuster

## 2. Instalação no Kali

```bash
sudo apt update
sudo apt install gobuster
```

Verifique:

```bash
gobuster version
```

Consulte a ajuda:

```bash
gobuster help
```

## 3. Como funciona?

O Gobuster recebe uma lista de palavras e testa cada uma de acordo com o modo escolhido.

Sua sintaxe geral é:

```bash
gobuster MODO OPÇÕES
```

O modo é importante porque determina o tipo de enumeração.

## 4. Modo DIR

O modo `dir` procura diretórios e arquivos em servidores web.

Exemplo em laboratório:

```bash
gobuster dir \
  -u http://127.0.0.1:8080/ \
  -w /usr/share/wordlists/dirb/common.txt
```

Parâmetros:

| Opção | Função |
|---|---|
| `dir` | Seleciona enumeração de diretórios |
| `-u` | Define a URL |
| `-w` | Define a wordlist |
| `-x` | Define extensões |
| `-t` | Define threads |
| `-s` | Define códigos HTTP aceitos |
| `-b` | Define códigos HTTP ignorados |
| `-o` | Salva resultados |

Exemplo com extensões:

```bash
gobuster dir \
  -u http://127.0.0.1:8080/ \
  -w /usr/share/wordlists/dirb/common.txt \
  -x php,html,txt
```

## 5. Modo DNS

O modo `dns` tenta identificar subdomínios utilizando uma wordlist.

Exemplo estrutural para um domínio autorizado:

```bash
gobuster dns \
  -do exemplo.com \
  -w subdominios.txt
```

Parâmetros importantes:

| Opção | Função |
|---|---|
| `dns` | Seleciona enumeração DNS |
| `-do` | Define o domínio |
| `-w` | Define a wordlist |
| `-t` | Define threads |
| `-r` | Define servidor DNS |

Um nome encontrado precisa ser analisado e confirmado. A resposta DNS pode mudar e nem todo nome identificado representa um serviço web ativo.

## 6. Modo VHOST

O modo `vhost` procura virtual hosts associados a um servidor.

Virtual hosts permitem que um mesmo servidor hospede diferentes sites, dependendo do nome informado na requisição HTTP.

Exemplo em um laboratório próprio:

```bash
gobuster vhost \
  -u http://127.0.0.1:8080 \
  -w vhosts.txt
```

O Gobuster testa diferentes nomes e compara as respostas do servidor.

## 7. Modo FUZZ

Nas versões que oferecem esse modo, o Gobuster também pode testar valores em posições marcadas com `FUZZ`.

Exemplo:

```bash
gobuster fuzz \
  -u "http://127.0.0.1:8080/search?param=FUZZ" \
  -w valores.txt
```

Consulte `gobuster help fuzz` para verificar os recursos disponíveis na versão instalada.

## 8. Outros modos

Dependendo da versão, o Gobuster também pode oferecer modos para:
- S3: descoberta de buckets Amazon S3.
- GCS: descoberta de buckets Google Cloud Storage.
- TFTP: enumeração de arquivos via TFTP.

Nem todos os modos estão presentes em todas as versões ou pacotes.

## 9. Wordlists

O Gobuster depende bastante da qualidade da wordlist.

No Kali, alguns caminhos comuns são:

```text
/usr/share/wordlists/dirb/
/usr/share/wordlists/dirbuster/
/usr/share/seclists/
```

Para localizar uma lista:

```bash
find /usr/share/wordlists -type f
```

Se o SecLists não estiver instalado:

```bash
sudo apt install seclists
```

## 10. Interpretando resultados

Observe:
- Caminho ou nome identificado.
- Código HTTP ou resposta DNS.
- Tamanho da resposta, quando exibido.
- Diferenças entre respostas.
- Possíveis falsos positivos.

Um servidor pode responder com o mesmo conteúdo para qualquer caminho inexistente. Isso pode produzir resultados enganosos. Compare respostas conhecidas e ajuste os filtros.

## 11. Comparação com FFUF e DIRB

| Ferramenta | Ponto forte |
|---|---|
| Gobuster | Vários modos de enumeração em uma única ferramenta |
| FFUF | Fuzzing flexível e filtros detalhados |
| DIRB | Descoberta de conteúdo com comandos simples |
| DirBuster | Interface gráfica e busca de diretórios |

## 12. Cuidados

- Utilize apenas alvos próprios ou autorizados.
- Não aumente threads sem considerar o impacto no servidor.
- Respeite os limites de escopo.
- Confirme manualmente os resultados relevantes.

## 13. Documentação

- GitHub: https://github.com/OJ/gobuster
- Releases: https://github.com/OJ/gobuster/releases
- Ajuda local: `gobuster help`
