#!/bin/bash
#scan usando ferramentas de scan passivas

if [ -z "$1" ]; then
echo " "
echo "usage exemple: passiveScan.sh <domain> -d or passiveScan.sh <ip> -ip"
echo "exiting......"
exit
else
sudo nmap -f $1  -sS -T2
fi
 
echo "____________________________________"

if [[ $2 = "-ip" ]]; then
spiderfoot -s $1 -u passive
echo "____________________________________"
elif [[ $2 = "-d" ]]; then
 theHarvester -d $1 -b all -l 10
echo "____________________________________"
fi
