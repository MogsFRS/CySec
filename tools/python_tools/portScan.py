
import socket
import sys


# Função responsável por verificar se as portas estão abertas no host.
# Recebe o endereço do alvo (host) e uma lista de portas para testar.
def scan(host, ports):
    try:
        # Percorre todas as portas informadas, testando uma por vez.
        for port in ports:

            # Cria um socket TCP/IP para tentar estabelecer uma conexão.
            client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

            # Define o tempo máximo de espera pela resposta (0.5 segundos).
            # Se não houver resposta nesse período, a tentativa é encerrada.
            client.settimeout(0.5)

            # Tenta estabelecer uma conexão TCP com o host e a porta.
            # O int() garante que o número da porta seja um inteiro.
            # Retorna 0 quando a conexão é estabelecida com sucesso.
            code = client.connect_ex((host, int(port)))

            # Se o retorno for 0, significa que a porta está aberta.
            if code == 0:
                print("[+] {} open".format(port))

            # Fecha o socket antes de testar a próxima porta.
            client.close()

    # Captura erros que possam acontecer durante a execução do scan.
    except Exception as error:
        print("Error, something is wrong: {}".format(error))


# Este bloco só é executado quando o arquivo é iniciado diretamente.
if __name__ == "__main__":

    # Verifica se o usuário informou pelo menos o endereço do alvo.
    if len(sys.argv) >= 2:

        # sys.argv[1] contém o primeiro argumento passado no terminal (host).
        host = sys.argv[1]

        # Verifica se o usuário também informou uma lista de portas.
        if len(sys.argv) >= 3:

            # Separa as portas usando a vírgula como delimitador.
            # Exemplo: "22,80,443" vira ["22", "80", "443"].
            ports = sys.argv[2].split(",")

        else:
            # Caso nenhuma porta seja informada, utiliza esta lista padrão.
            ports = [21, 22, 23, 25, 80, 443, 445, 8080, 8443, 3306, 139, 135]

        # Inicia o scanner passando o host e as portas selecionadas.
        scan(host, ports)

    else:
        # Exibe a sintaxe correta caso o usuário não informe um host.
        print("Usage: python portscan.py <domain> <ports>")
