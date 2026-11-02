#!/bin/bash
# zoneTranfer.sh <dominio>

if [ -z "$1" ]; then
echo "__________________________"

echo "digite o domínio: "
read dom
echo "__________________________"

host -t ns "$dom"
else 
echo "__________________________"
host -t ns $1
fi

echo "__________________________"
echo "escolha o server: "
read server
echo "__________________________"
dig axfr $1 @"$server"
