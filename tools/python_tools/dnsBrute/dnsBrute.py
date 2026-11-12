
import dns.resolver
import sys


# Abre a wordlist e carrega os subdomínios em uma lista Python.
try:
    with open('wordlist.txt', 'r') as arq:
        # read() lê todo o arquivo e splitlines() separa cada linha em um item.
        subdomains = arq.read().splitlines()

except:
    # Exibe uma mensagem caso não consiga abrir ou ler o arquivo.
    print('invalid wordlist!')


# Percorre cada subdomínio presente na wordlist.
for subdomain in subdomains:

    try:
        # Verifica se o domínio informado possui até 3 caracteres.
        if len(sys.argv[1]) <= 3:

            # Exibe o subdomínio que será testado.
            print("{}.{}".format(subdomain, sys.argv[1]))

            # Junta o subdomínio da wordlist com o domínio principal.
            # Exemplo: www + example.com = www.example.com
            sub_target = "{}.{}".format(subdomain, sys.argv[1])

            # Cria um objeto Resolver para realizar consultas DNS.
            resolver = dns.resolver.Resolver()

            # Consulta o registro DNS do tipo A (endereço IPv4).
            results = resolver.resolve(sub_target, 'A')

        else:
            # Exibe a sintaxe de uso caso o domínio não passe na condição.
            print('usage: python3 dnsBrute.py <domain>')

        # Percorre os resultados retornados pela consulta DNS.
        for result in results:

            # Exibe o domínio e o endereço IPv4 encontrado.
            print('{} -> {}'.format(sub_target, result))

    except:
        # Executado quando ocorre algum erro na consulta DNS.
        # Pode ser domínio inexistente, timeout ou falha na resolução.
        print('non existent domain/subdomain')
