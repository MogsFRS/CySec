# CySec
coisas de cybersegurança

# Metasploit framework
 msfconsole: chama o metasploit framework, com vários exploits disponíveis
 
 use  exploit/multi/handler: cria um listener para qualquer sistema operacional a a partir do meterpreter

use exploit/windows/local/bypassuac: exploit para escalação de privilégios no windows

scanner/http/tomcat_mgr_login: brute force de senhas apache tomcat

exploit -j: roda de fundo

-q: remove o banner inicial.

-r: informa qual arquivo RC será executado.

exitonsession = false: permite receber várias conexões

 meterpreter:

 background: deixa a sessão atual em back ground para poder usar o msfconsole
 
 sessions: mostra as sessões ativas

 sessions -i <id>: se conecta a sessão selecionada

 ps: mostra processos rodando
 
 migrate <id> migra o processo para um outra a escolha 


 
 msfvenom: payload generator, para fazer seus próprios virus
 
 -a: arquitetura do alvo pode ser x32 x64 x84 
 
 --platform: passa o sistema operacional
 
 -p: set do payload, voce seleciona o payload 
 
 -f: voce define o tipo de executável que ele vai ser 

 -o: define o nome com a extenção adequada

 após setar o payload por exemplo de um trojar o /multi/handler do msfconsole pode criar um programa que vai ouvir as conexões lá 
 será necessário setar o payload para o mesmo que foi usado anteriormente
 

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

