
import sys

import requests
from bs4 import BeautifulSoup


# Lista que armazena as URLs que ainda precisam ser visitadas.
TO_CRAWL = []

# Set que armazena as URLs que já foram visitadas.
# O set evita URLs duplicadas e permite buscas mais rápidas.
CRAWLED = set()


# Função responsável por realizar uma requisição HTTP para uma URL.
def request(url):

    # Define um User-Agent para identificar a requisição como um navegador.
    header = {
        "User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101 Firefox/78.0"
    }

    try:
        # Envia uma requisição GET para acessar o conteúdo da página.
        # O parâmetro headers envia o User-Agent definido anteriormente.
        response = requests.get(url, headers=header)

        # Retorna o conteúdo HTML recebido pelo servidor.
        return response.text

    except KeyboardInterrupt:
        # Encerra o programa caso o usuário pressione CTRL+C.
        sys.exit(0)

    except:
        # Ignora outros erros de requisição.
        pass


# Função responsável por extrair os links encontrados no HTML.
def get_links(html):

    # Lista que armazenará os links encontrados na página.
    links = []

    try:
        # Cria um objeto BeautifulSoup para interpretar o HTML.
        soup = BeautifulSoup(html, "html.parser")

        # Procura todas as tags <a> que possuem o atributo href.
        tags_a = soup.find_all("a", href=True)

        # Percorre todas as tags encontradas.
        for tag in tags_a:

            # Extrai o endereço presente no atributo href.
            link = tag["href"]

            # Verifica se o link começa com http.
            # Isso mantém apenas URLs absolutas HTTP/HTTPS.
            if link.startswith("http"):
                links.append(link)

        # Retorna a lista de links encontrados.
        return links

    except:
        # Ignora erros durante a interpretação do HTML.
        pass


# Função principal responsável por executar o processo de crawling.
def crawl():

    # Continua executando até que não existam mais URLs na fila.
    while 1:

        # Verifica se ainda existem páginas aguardando para serem visitadas.
        if TO_CRAWL:

            # Remove e retorna a última URL da lista.
            # Essa URL será a próxima página visitada.
            url = TO_CRAWL.pop()

            # Realiza a requisição e recebe o HTML da página.
            html = request(url)

            # Verifica se a requisição retornou algum conteúdo.
            if html:

                # Extrai os links presentes no HTML recebido.
                links = get_links(html)

                # Verifica se foram encontrados links.
                if links:

                    # Percorre todos os links extraídos.
                    for link in links:

                        # Verifica se o link ainda não foi visitado
                        # e se também não está aguardando na fila.
                        if link not in CRAWLED and link not in TO_CRAWL:

                            # Adiciona o novo link à fila de URLs.
                            TO_CRAWL.append(link)

                # Informa qual página está sendo visitada.
                print("Crawling {}".format(url))

                # Adiciona a URL ao conjunto de páginas já visitadas.
                CRAWLED.add(url)

            else:
                # Mesmo que a requisição falhe, marca a URL como visitada
                # para evitar que o programa tente acessá-la novamente.
                CRAWLED.add(url)

        else:
            # Executado quando não existem mais URLs na fila.
            print("Done")

            # Encerra o loop.
            break


# Verifica se o arquivo está sendo executado diretamente.
if __name__ == "__main__":

    # Obtém a URL informada como primeiro argumento no terminal.
    url = sys.argv[1]

    # Adiciona a URL inicial à fila de páginas que serão visitadas.
    TO_CRAWL.append(url)

    # Inicia o processo de crawling.
    crawl()
