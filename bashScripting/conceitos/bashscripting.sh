#!/bin/bash
#todo o arquivo precisa começar desse jeito com o !/bin/bash
#a linguagem vai ser uma mistura de comandos do próprio linux com programação
# chmod +x nomeArquivo.sh para dar permissão para o arquivo executar

#exibe uma mensagem:
echo "hey"

#atribuição de variável:
nome="amarelo"

#atribui a extension o valor que o grep encontrar
extension=$(printf '%s\n' "$1" | grep -o -E '\.tar\.gz|\.tar\.xz|\.tar\.bz2|\.deb|\.zip|\.tar|\.tgz')


#atribuição de valor, espera o user digitar antes de continuar
read nome

#concatenação:
echo "sua cor é $nome"

#funciona com comandos como parâmetros também:
nmap $nome

#condicional espaço entre as condiões sempre
if [ "$nome" == "amarelo" ]
then
#o aqui é a a parte de dentro do if
fi

#!/bin/bash

TARGET="192.168.1.100"

#coloca esse conteudo no config.rc para que seja possível executar essa série de comandos no msfconsole
cat > config.rc <<EOF
version
use auxiliary/scanner/ssh/ssh_version
set RHOSTS $TARGET
show options
EOF

msfconsole -q -r config.rc

#verifica se a variavel está vazia 
if [ -z "$VARIAVEL" ]; then
    echo "A variável está vazia"
fi

#condicional if else
elif [ "$nome" == "amarelo" ]
#código aqui
else
#mais código
fi

#para comparação aritmética é com parenteses
# if (( number < 5 ))

#para elseif
if (( numer != null )); then
#código
elif (( number >= 0 )); then
#código
elif (( number < 0 )); then
#código
fi

# $1 $2 $3 etc... pega os argumentos automaticamente

#repetições
#while
while [ $var = 1 ]
do
#código
done

#executa o código a cada cinco segundos
# while sleep 5

#for
for ((i=0; i<=10;i++))
#define a variável i, e executa enquanto ela for menor ou igual a 10
# e dá um i++ ao final do for
do
#código
done

#for para listas
#executa em uma sequencia de um a dez, para sequencias 
#tem o echo {1..10} faz uma sequencia até dez e o 
#seq 1 10 que faz o mesmo
for i in {1...10}
do
 echo $i
done

#quando for rodar comandos do no for
for i in $(seq 50 30)
do
#código
done

#para arquivos 
for i in $(cat exemplo.txt)
do
echo $i
done
#vai retornar os valores no arquivo exemplo

function minha_funcao {
    echo "Executando função"
}

