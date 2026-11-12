
import sys
import re

import requests
from bs4 import BeautifulSoup


# Lista que armazena as URLs que ainda precisam ser visitadas.
TO_CRAWL = []

# Conjunto que armazena as URLs que já foram visitadas.
CRAWLED = set()

# Lista que armazena os endereços de e-mail encontrados.
EMAILS = []


# Realiza uma requisição HTTP para obter o conteúdo de uma página.
def request(url):

    # Define um User-Agent para identificar a requisição como um navegador.
    header = {
        "User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101 Firefox/78.0"
    }

    try:
        # Envia uma requisição GET para acessar a página.
        response = requests.get(url, headers=header)

        # Retorna o conteúdo HTML recebido.
        return response.text

    except KeyboardInterrupt:
        # Encerra o programa caso o usuário pressione CTRL+C.
        sys.exit(0)

    except:
        # Ignora outros erros durante a requisição.
        pass


# Extrai os links encontrados dentro do HTML.
def get_links(html):

    # Lista que armazenará os links encontrados.
    links = []

    try:
        # Interpreta o HTML utilizando o BeautifulSoup.
        soup = BeautifulSoup(html, "html.parser")

        # Localiza todas as tags <a> que possuem o atributo href.
        tags_a = soup.find_all("a", href=True)

        # Percorre as tags encontradas.
        for tag in tags_a:

            # Extrai o endereço presente no atributo href.
            link = tag["href"]

            # Mantém apenas links absolutos que começam com http.
            if link.startswith("http"):
                links.append(link)

        # Retorna a lista de links encontrados.
        return links

    except:
        # Ignora erros durante a extração dos links.
        pass


# Procura endereços de e-mail dentro do conteúdo HTML.
def get_emails(html):

    # Utiliza Regex para identificar possíveis endereços de e-mail.
    # re.findall() retorna todas as correspondências encontradas.
    emails = re.findall(r"\w[\w\.]+\w@\w[\w\.]+\w", html)

    # Retorna a lista de e-mails encontrados.
    return emails


# Controla o processo de navegação e coleta de informações.
def crawl():

    # Continua executando enquanto houver URLs para visitar.
    while 1:

        # Verifica se existem URLs aguardando na lista.
        if TO_CRAWL:

            # Retira a última URL da lista para realizar o crawling.
            url = TO_CRAWL.pop()

            # Faz a requisição e recebe o HTML da página.
            html = request(url)

            # Verifica se a página retornou algum conteúdo.
            if html:

                # Extrai os links encontrados na página.
                links = get_links(html)

                # Verifica se foram encontrados links.
                if links:

                    # Percorre os links extraídos.
                    for link in links:

                        # Evita adicionar URLs que já foram visitadas
                        # ou que já estão aguardando na lista.
                        if link not in CRAWLED and link not in TO_CRAWL:

                            # Adiciona o novo link à lista de URLs pendentes.
                            TO_CRAWL.append(link)

                # Procura possíveis endereços de e-mail no HTML.
                emails = get_emails(html)

                # Percorre todos os e-mails encontrados.
                for email in emails:

                    # Verifica se o e-mail ainda não foi coletado.
                    if email not in EMAILS:

                        # Exibe o endereço encontrado.
                        print(email)

                        # Armazena o e-mail na lista de resultados.
                        EMAILS.append(email)

                # Marca a URL atual como visitada.
                CRAWLED.add(url)

            else:
                # Marca a URL como visitada mesmo se a requisição falhar.
                CRAWLED.add(url)

        else:
            # Informa que não existem mais páginas para visitar.
            print("Done")

            # Encerra o loop.
            break


# Verifica se o arquivo está sendo executado diretamente.
if __name__ == "__main__":

    # Obtém a URL inicial informada pelo usuário no terminal.
    url = sys.argv[1]

    # Adiciona a URL inicial à lista de páginas pendentes.
    TO_CRAWL.append(url)

    # Inicia o processo de crawling.
    crawl()
