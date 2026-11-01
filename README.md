# CySec
coisas de cybersegurança

# Metasploit framework
 msfconsole: chama o metasploit framework, com vários exploits disponíveis
 
 msfvenom: payload generator, para fazer seus próprios virus
 -a: arquitetura do alvo pode ser x32 x64 x84 
 --platform: passa o sistema operacional
 -p: set do payload, voce seleciona o payload 
 -f: voce define o tipo de executável que ele vai ser 
 

 # técnicas de evasão de firewall via nmap
 
-f	Fragmenta os pacotes IP.

--mtu <valor>	Define o tamanho dos fragmentos IP.

-D<decoy1,decoy2>	Utiliza IPs falsos como fontes aparentes do scan.

-S<IP>	Define manualmente o IP de origem.

-g <porta>	Define a porta de origem dos pacotes.

--source-port <porta>	Define a porta de origem (alternativa a -g).

--data-length <n>	Adiciona dados aleatórios aos pacotes.

--badsum	Envia pacotes com checksum TCP/UDP inválido.

-T0	Scan extremamente lento e sequencial.

-T1	Scan lento, reduzindo a frequência das requisições.

--top-ports <n>: analisa um numero pré-definido de portas


2. Técnicas de descoberta e análise de filtragem
Parâmetro	Função

-Pn	Não realiza descoberta de hosts; considera o alvo ativo.

-sA	TCP ACK Scan; ajuda a identificar como os filtros tratam pacotes.

-sS	TCP SYN Scan.

-sN	TCP Null Scan.

-sF	TCP FIN Scan.

-sX	TCP Xmas Scan.

-sW	TCP Window Scan.

-sU	UDP Scan.

-p-	Examina todas as portas TCP.

--reason	Mostra o motivo pelo qual uma porta foi classificada.

# comandos do smbclient:

smb costuma rodar na 445 ou 139

smbclient -L <ip> faz login no smb dessa ip

smbclient //<ip>/<nome do arquivo> entra no arquivo listado

smbclient //<ip>/<nome arquivo> -U <nome do user> entra no arquivo como <nome do user>

