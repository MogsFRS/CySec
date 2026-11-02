#!/bin/bash
#bash que pega todas o máximo de links associados a um domínio e filtra de acordo com alguns filtros disponiveis 

echo "___________________________"
echo "digite o domínio: "
read dom
echo "filtros disponiveis: "
gf -list
echo "___________________________"
echo "digite um filtro: "
read filter
echo "nome do arquivo de destino: "
read -e path
touch /home/user/"$path"
echo "___________________________"
if [ -z "$filter" ]; then
gau "$dom" >> /home/user/"$path" 
else
gau "$dom" | gf "$filter" >> /home/user/"$path" 
fi
echo "___________________________"
echo "links copiados para /home/user/$path"
