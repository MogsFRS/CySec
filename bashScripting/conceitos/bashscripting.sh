```bash
#!/bin/bash

# ============================================================
# BASH - ANOTAÇÕES E EXEMPLOS
# ============================================================
# Bash permite combinar comandos do Linux com estruturas de
# programação, possibilitando automatizar tarefas e ferramentas.
#
# Para dar permissão de execução ao arquivo:
# chmod +x nomeArquivo.sh
#
# Para executar:
# ./nomeArquivo.sh
#
# Também é possível executar sem alterar as permissões:
# bash nomeArquivo.sh
# ============================================================


# ============================================================
# 1. ESTRUTURA E COMANDOS BÁSICOS
# ============================================================

#!/bin/bash

# Exibe uma mensagem no terminal:
echo "hey"

# Exibe uma mensagem sem pular para a próxima linha:
echo -n "Digite algo: "

# Exibe um texto utilizando printf.
# %s representa um espaço reservado para uma string.
# \n quebra a linha ao final da mensagem:
printf "Olá, %s\n" "mundo"

# Comentários começam com # e não são executados pelo Bash.


# ============================================================
# 2. VARIÁVEIS
# ============================================================

# Cria uma variável chamada nome e armazena o texto "amarelo".
# Não utilize espaços antes ou depois do sinal de igual:
nome="amarelo"

# O símbolo $ permite acessar o conteúdo armazenado na variável:
echo "$nome"

# As chaves delimitam o nome da variável.
# São úteis quando existem outros caracteres logo após o nome:
echo "${nome}"

# Permite inserir o conteúdo de uma variável dentro de um texto:
echo "Sua cor é $nome"

# $(comando) executa outro comando e armazena sua saída na variável.
# Neste exemplo, whoami retorna o nome do usuário atual:
usuario=$(whoami)

echo "$usuario"

# Armazena a data e o horário retornados pelo comando date:
data=$(date)

echo "$data"

# Extrai a extensão de um nome de arquivo recebido como primeiro argumento.
# grep -o mostra somente o trecho encontrado.
# -E permite utilizar expressões regulares estendidas.
# A expressão identifica algumas extensões comuns de arquivos:
extension=$(printf '%s\n' "$1" | grep -o -E '\.tar\.gz|\.tar\.xz|\.tar\.bz2|\.deb|\.zip|\.tar|\.tgz')

echo "$extension"

# Uma variável também pode ser utilizada como argumento de outro programa.
# Neste exemplo, o conteúdo de nome é passado ao Nmap:
nmap "$nome"

# readonly impede que o valor da variável seja alterado posteriormente:
readonly sistema="Linux"

# export disponibiliza a variável também para programas iniciados
# pelo processo atual:
export TARGET="192.168.1.100"


# ============================================================
# 3. ENTRADA DE DADOS
# ============================================================

# read pausa a execução do script até o usuário digitar um valor.
# O conteúdo digitado é armazenado na variável nome:
read nome

echo "Sua cor é $nome"

# -p exibe uma mensagem antes de aguardar a entrada do usuário:
read -p "Digite seu nome: " nome

# -s oculta os caracteres digitados.
# Útil para receber informações que não devem aparecer no terminal:
read -s -p "Digite sua senha: " senha
echo

# -t define quantos segundos o Bash deve esperar pela entrada.
# Se o tempo acabar, read retorna sem receber uma resposta:
read -t 10 -p "Digite algo em até 10 segundos: " resposta

# -r impede que barras invertidas sejam interpretadas como caracteres
# especiais durante a leitura. É recomendado para entradas comuns:
read -r -p "Digite seu nome: " nome


# ============================================================
# 4. ARGUMENTOS
# ============================================================

# Argumentos permitem enviar informações ao script durante sua execução.
# Exemplo:
# ./script.sh arquivo.txt 80

# $0 representa o nome utilizado para executar o próprio script:
echo "$0"

# $1 representa o primeiro argumento recebido:
echo "$1"

# $2 representa o segundo argumento recebido:
echo "$2"

# $3 representa o terceiro argumento recebido:
echo "$3"

# $@ representa todos os argumentos recebidos, mantendo cada um separado:
echo "$@"

# $# retorna a quantidade de argumentos recebidos:
echo "$#"

# $? retorna o código de saída do último comando executado:
echo "$?"

# $$ retorna o PID do processo atual:
echo "$$"

# $! retorna o PID do último processo iniciado em segundo plano.

# Verifica se o script recebeu pelo menos um argumento:
if [ "$#" -eq 0 ]; then
    echo "Nenhum argumento informado"
fi

# Percorre todos os argumentos individualmente.
# As aspas em "$@" preservam argumentos que contenham espaços:
for argumento in "$@"; do
    echo "$argumento"
done


# ============================================================
# 5. CONDICIONAIS
# ============================================================

# if inicia uma verificação.
# then define os comandos executados quando a condição é verdadeira.
# fi encerra a estrutura condicional.

if [ "$nome" = "amarelo" ]; then
    echo "A cor é amarelo"
fi

# else define o que será executado quando a condição do if for falsa:
if [ "$nome" = "amarelo" ]; then
    echo "Cor encontrada"
else
    echo "Outra cor"
fi

# elif permite verificar outra condição caso as anteriores sejam falsas.
# É possível utilizar vários elif dentro da mesma estrutura:
if [ "$nome" = "amarelo" ]; then
    echo "Amarelo"
elif [ "$nome" = "azul" ]; then
    echo "Azul"
else
    echo "Cor desconhecida"
fi

# -z verifica se uma variável está vazia:
if [ -z "$VARIAVEL" ]; then
    echo "A variável está vazia"
fi

# -n verifica se uma variável possui algum conteúdo:
if [ -n "$VARIAVEL" ]; then
    echo "A variável possui conteúdo"
fi

# = compara se duas strings possuem o mesmo conteúdo:
if [ "$nome" = "amarelo" ]; then
    echo "Iguais"
fi

# != verifica se duas strings possuem conteúdos diferentes:
if [ "$nome" != "amarelo" ]; then
    echo "Diferentes"
fi

# Comparações numéricas utilizando [ ]:
# -eq = igual
# -ne = diferente
# -gt = maior que
# -ge = maior ou igual
# -lt = menor que
# -le = menor ou igual

if [ "$numero" -gt 5 ]; then
    echo "Maior que cinco"
fi

# Também é possível comparar números utilizando (( )).
# Nesse formato, as variáveis podem ser utilizadas sem o símbolo $:
# <  = menor
# >  = maior
# <= = menor ou igual
# >= = maior ou igual
# == = igual
# != = diferente

numero=10

if (( numero < 5 )); then
    echo "Menor que cinco"
elif (( numero >= 10 )); then
    echo "Maior ou igual a dez"
elif (( numero > 0 )); then
    echo "Maior que zero"
fi

# -f verifica se o caminho informado existe e é um arquivo regular:
if [ -f "arquivo.txt" ]; then
    echo "O arquivo existe"
fi

# -d verifica se o caminho informado existe e é um diretório:
if [ -d "pasta" ]; then
    echo "O diretório existe"
fi

# -x verifica se o arquivo possui permissão de execução:
if [ -x "script.sh" ]; then
    echo "Arquivo executável"
fi

# -s verifica se o arquivo existe e possui tamanho maior que zero:
if [ -s "arquivo.txt" ]; then
    echo "Arquivo possui conteúdo"
fi

# Operadores lógicos permitem combinar ou inverter condições:
# && = E: as duas condições precisam ser verdadeiras.
# || = OU: pelo menos uma das condições precisa ser verdadeira.
# !  = NÃO: inverte o resultado de uma condição.

if [ "$numero" -gt 0 ] && [ "$numero" -lt 20 ]; then
    echo "Número entre 1 e 19"
fi

if [ "$nome" = "azul" ] || [ "$nome" = "amarelo" ]; then
    echo "Cor reconhecida"
fi


# ============================================================
# 6. CASE
# ============================================================

# case compara uma variável com várias possibilidades.
# É uma alternativa ao uso de vários if e elif quando existem
# diferentes valores possíveis para uma mesma variável.

case "$nome" in
    amarelo)
        echo "Cor amarela"
        ;;
    azul)
        echo "Cor azul"
        ;;
    vermelho)
        echo "Cor vermelha"
        ;;
    *)
        echo "Cor não reconhecida"
        ;;
esac

# Cada valor seguido de ) representa uma possibilidade.
# ;; encerra os comandos daquela possibilidade.
# * representa qualquer valor que não tenha correspondido às anteriores.
# esac encerra a estrutura case.


# ============================================================
# 7. REPETIÇÕES - WHILE
# ============================================================

# while repete os comandos enquanto a condição informada for verdadeira.

var=1

while [ "$var" -eq 1 ]; do
    echo "Executando"
    var=0
done

# Executa os comandos repetidamente, aguardando cinco segundos
# entre cada execução:
while sleep 5; do
    echo "Executando a cada cinco segundos"
done

# Também é possível utilizar um contador para controlar as repetições:
contador=0

while (( contador < 5 )); do
    echo "$contador"
    ((contador++))
done

# break interrompe imediatamente o loop atual:
while true; do
    echo "Executando"
    break
done

# continue ignora o restante da repetição atual e inicia a próxima.
# Neste exemplo, o número 3 não será exibido:
for i in {1..5}; do
    if (( i == 3 )); then
        continue
    fi
    echo "$i"
done


# ============================================================
# 8. REPETIÇÕES - FOR
# ============================================================

# O for tradicional permite definir:
# 1. O valor inicial da variável.
# 2. A condição para continuar repetindo.
# 3. A alteração da variável após cada repetição.

# Neste exemplo, i começa em 0, repete enquanto for menor ou igual a 10
# e aumenta em 1 ao final de cada repetição:

for ((i=0; i<=10; i++)); do
    echo "$i"
done

# {1..10} gera uma sequência numérica de 1 até 10.
# O for percorre cada número dessa sequência:
for i in {1..10}; do
    echo "$i"
done

# seq gera uma sequência numérica que pode ser utilizada pelo for:
for i in $(seq 1 10); do
    echo "$i"
done

# Para gerar uma sequência decrescente, informe o passo -1:
for i in $(seq 10 -1 1); do
    echo "$i"
done

# Atenção:
# seq 50 30 não gera uma sequência decrescente.
# Utilize seq 50 -1 30 para contar de 50 até 30.

# Percorre todos os argumentos recebidos pelo script:
for i in "$@"; do
    echo "$i"
done

# Percorre os arquivos .txt encontrados no diretório atual.
# A variável arquivo recebe o nome de cada arquivo encontrado:
for arquivo in *.txt; do
    [ -e "$arquivo" ] || continue
    echo "$arquivo"
done

# Lê um arquivo linha por linha.
# IFS= impede que espaços no início ou no final sejam removidos.
# read -r preserva barras invertidas.
# Cada linha é armazenada na variável linha:
while IFS= read -r linha; do
    echo "$linha"
done < exemplo.txt

# Evite utilizar:
# for i in $(cat exemplo.txt)
#
# Esse formato divide o conteúdo por espaços e quebras de linha.
# Isso pode separar incorretamente nomes de arquivos ou textos
# que contenham espaços.


# ============================================================
# 9. FUNÇÕES
# ============================================================

# Funções agrupam comandos que podem ser executados várias vezes.
# Primeiro é necessário declarar a função e depois chamá-la.

function minha_funcao {
    echo "Executando função"
}

# Chama a função e executa os comandos que estão dentro dela:
minha_funcao

# Outra forma de declarar uma função:
outra_funcao() {
    echo "Outra função"
}

outra_funcao

# Uma função também pode receber argumentos.
# Dentro da função, $1 representa o primeiro argumento recebido:
saudacao() {
    echo "Olá, $1"
}

# Envia o texto "Kusanagi" como primeiro argumento da função:
saudacao "Kusanagi"

# return define o código de saída da função.
# Neste exemplo, retorna 0 se o arquivo existir e 1 caso contrário:
verificar() {
    if [ -f "$1" ]; then
        return 0
    else
        return 1
    fi
}

# Utiliza o código de saída da função para decidir o que executar:
if verificar "arquivo.txt"; then
    echo "Arquivo encontrado"
else
    echo "Arquivo não encontrado"
fi

# return não retorna textos.
# Para obter um texto de uma função, utilize echo ou printf
# e capture a saída com $(...):
obter_usuario() {
    whoami
}

usuario=$(obter_usuario)
echo "$usuario"


# ============================================================
# 10. ARRAYS
# ============================================================

# Arrays permitem armazenar vários valores em uma única variável.
# Cada elemento possui uma posição numérica, começando pelo índice 0.

ferramentas=("nmap" "curl" "grep" "sqlmap")

# Acessa o primeiro elemento do array:
echo "${ferramentas[0]}"

# Acessa o segundo elemento:
echo "${ferramentas[1]}"

# Exibe todos os elementos armazenados:
echo "${ferramentas[@]}"

# Retorna a quantidade de elementos do array:
echo "${#ferramentas[@]}"

# Percorre cada elemento individualmente:
for ferramenta in "${ferramentas[@]}"; do
    echo "$ferramenta"
done

# Adiciona um novo elemento ao final do array:
ferramentas+=("msfconsole")


# ============================================================
# 11. COMANDOS E FERRAMENTAS EXTERNAS
# ============================================================

# Scripts Bash podem executar praticamente qualquer comando
# disponível no sistema e utilizar seus resultados.

# Exibe o usuário que está executando o script:
whoami

# Exibe informações do kernel e do sistema:
uname -a

# Lista arquivos e diretórios, incluindo arquivos ocultos:
ls -la

# Mostra o caminho do diretório atual:
pwd

# Procura uma palavra dentro de um arquivo:
grep "texto" arquivo.txt

# Procura arquivos com a extensão .txt no diretório atual
# e em seus subdiretórios:
find . -name "*.txt"

# Exibe informações das interfaces de rede:
ip addr

# Armazena um endereço IP em uma variável e o utiliza como argumento
# para executar o Nmap:
TARGET="192.168.1.100"
nmap "$TARGET"

# Executa uma requisição HTTP e armazena o conteúdo retornado.
# -s ativa o modo silencioso, reduzindo mensagens de progresso:
resultado=$(curl -s https://example.com)

echo "$resultado"

# command -v verifica se um programa pode ser encontrado no PATH.
# >/dev/null 2>&1 descarta tanto a saída quanto as mensagens de erro:
if command -v nmap >/dev/null 2>&1; then
    echo "Nmap instalado"
else
    echo "Nmap não encontrado"
fi

# && executa o segundo comando somente se o primeiro tiver sucesso:
mkdir pasta && cd pasta

# || executa o segundo comando caso o primeiro falhe:
cd pasta || echo "Não foi possível acessar a pasta"


# ============================================================
# 12. REDIRECIONAMENTO
# ============================================================

# Redirecionamentos permitem controlar para onde vão as saídas
# dos comandos e de onde eles recebem suas entradas.

# > grava a saída em um arquivo.
# Se o arquivo já existir, seu conteúdo será substituído:
echo "Olá" > arquivo.txt

# >> acrescenta a saída ao final do arquivo, sem apagar o conteúdo:
echo "Outra linha" >> arquivo.txt

# < utiliza o conteúdo de um arquivo como entrada do comando:
grep "Linux" < arquivo.txt

# 2> envia somente as mensagens de erro para um arquivo:
comando_inexistente 2> erro.log

# > redireciona a saída padrão.
# 2>&1 envia também as mensagens de erro para o mesmo destino:
comando > resultado.log 2>&1

# /dev/null é um destino que descarta tudo que recebe.
# Neste exemplo, tanto a saída quanto os erros são descartados:
comando >/dev/null 2>&1

# | (pipe) envia a saída de um comando como entrada de outro.
# Aqui, grep filtra a listagem do ls para mostrar apenas linhas
# que contenham ".txt":
ls -la | grep ".txt"

# É possível encadear vários comandos utilizando pipes:
ps aux | grep "firefox" | grep -v grep


# ============================================================
# 13. HERE DOCUMENT - EOF
# ============================================================

# Here Document permite enviar várias linhas de texto para um comando.
# É útil para criar arquivos de configuração automaticamente.
#
# O delimitador EOF indica onde o bloco de texto começa e termina.
# Quando o delimitador não está entre aspas, o Bash substitui
# as variáveis encontradas dentro do bloco.

TARGET="192.168.1.100"

# Cria ou substitui config.rc com os comandos do Metasploit.
# $TARGET será substituído pelo conteúdo da variável do Bash:
cat > config.rc <<EOF
version
use auxiliary/scanner/ssh/ssh_version
set RHOSTS $TARGET
show options
EOF

# Inicia o Metasploit em modo silencioso e executa os comandos
# encontrados no arquivo config.rc:
msfconsole -q -r config.rc

# -q inicia sem exibir o banner inicial.
# -r informa o arquivo de recursos que será executado.
# Os comandos dentro do RC são interpretados pelo Metasploit,
# não pelo Bash.

# Para gravar o conteúdo literalmente, sem substituir variáveis,
# coloque o delimitador EOF entre aspas:
cat > exemplo.txt <<'EOF'
$TARGET
EOF


# ============================================================
# 14. CÓDIGOS DE SAÍDA
# ============================================================

# Os comandos retornam um código de saída após a execução.
# Normalmente:
# 0     = execução bem-sucedida.
# != 0  = ocorreu alguma falha.

# Executa um comando:
ls

# Consulta o código de saída do comando anterior:
echo "$?"

# if também pode verificar diretamente se um comando funcionou:
# Se ls retornar 0, executa o primeiro bloco.
# Caso contrário, executa o bloco else:
if ls; then
    echo "Comando executado"
else
    echo "Ocorreu um erro"
fi

# exit encerra a execução do script.
# O número informado é o código de saída que será retornado:
exit 0

# exit 1 encerra o script indicando falha:
# exit 1


# ============================================================
# 15. TRATAMENTO DE ERROS
# ============================================================

# set -e encerra o script quando determinados comandos retornam erro.
# Existem exceções, especialmente em condicionais e listas de comandos.

# set -u faz o Bash gerar erro quando uma variável não definida
# é utilizada, ajudando a identificar erros de digitação.

# set -o pipefail faz um pipeline retornar erro se algum comando
# dentro dele falhar, mesmo que o último comando tenha sucesso.

# Ativa as três opções:
set -euo pipefail

# Desativa a opção -e:
set +e

# Exemplo: verifica se o Nmap está disponível antes de utilizá-lo.
# Se não estiver instalado ou não for encontrado no PATH,
# o script exibe uma mensagem e encerra com código de erro:
if ! command -v nmap >/dev/null 2>&1; then
    echo "Nmap não está instalado"
    exit 1
fi


# ============================================================
# 16. OPERADORES ARITMÉTICOS
# ============================================================

# $(( )) permite realizar operações matemáticas com números inteiros.

# Soma:
resultado=$((5 + 3))

# Subtração:
resultado=$((5 - 3))

# Multiplicação:
resultado=$((5 * 3))

# Divisão inteira:
resultado=$((10 / 2))

# Resto da divisão:
resultado=$((10 % 3))

# Incrementa uma variável em 1:
((numero++))

# Decrementa uma variável em 1:
((numero--))

# As operações seguem a ordem de prioridade matemática.
# O resultado de uma divisão entre inteiros também será inteiro.


# ============================================================
# 17. DATA E TEMPO
# ============================================================

# Exibe a data e o horário atuais:
date

# Exibe a data no formato dia/mês/ano:
date +"%d/%m/%Y"

# Exibe somente o horário no formato hora:minuto:segundo:
date +"%H:%M:%S"

# Armazena a data atual no formato ano-mês-dia:
DATA=$(date +"%Y-%m-%d")

echo "$DATA"


# ============================================================
# 18. PROCESSOS
# ============================================================

# Exibe o PID do próprio script:
echo "$$"

# $! permite consultar o PID do último processo iniciado
# em segundo plano.

# & inicia o comando em segundo plano, permitindo que o script
# continue executando sem aguardar sua conclusão:
sleep 10 &

# wait aguarda a conclusão de processos iniciados em segundo plano:
# wait

# Também é possível aguardar um processo específico pelo PID:
# wait "$PID"


# ============================================================
# 19. EXEMPLO DE INTEGRAÇÃO DE FERRAMENTAS
# ============================================================

# Solicita ao usuário o endereço IP de um laboratório autorizado:
read -r -p "Informe o IP do laboratório: " TARGET

# -z verifica se a entrada está vazia.
# Caso esteja, o script exibe uma mensagem e encerra:
if [ -z "$TARGET" ]; then
    echo "Nenhum endereço informado"
    exit 1
fi

# Verifica se o Nmap está instalado antes de tentar executá-lo:
if ! command -v nmap >/dev/null 2>&1; then
    echo "Nmap não encontrado"
    exit 1
fi

# Exibe uma mensagem antes de iniciar a verificação:
echo "Iniciando verificação..."

# Executa o Nmap utilizando o endereço informado pelo usuário:
nmap "$TARGET"

# Armazena o código de saída retornado pelo Nmap:
STATUS=$?

# Verifica se o comando terminou com sucesso:
if [ "$STATUS" -eq 0 ]; then
    echo "Comando finalizado"
else
    echo "Ocorreu um erro"
fi


# ============================================================
# 20. ESPAÇO PARA NOVOS CONCEITOS
# ============================================================

# Utilize este espaço para adicionar novos comandos, operadores,
# estruturas ou exemplos que sejam úteis para consulta futura.
#
# [NOME DO CONCEITO]
#
# Descrição:
# Explique o que o comando faz e em quais situações pode ser usado.
#
# Exemplo:
# comando
#
# Observações:
# Explique parâmetros importantes ou cuidados necessários.
#
# ------------------------------------------------------------
```
