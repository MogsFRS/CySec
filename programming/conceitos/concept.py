#define uma lista global
restaurants =[]

#dicionario
restaurants = [{'name': 'Sushi', 'category': 'japanese-food', 'activation': False},
               {'name': 'hashimi-hashimi', 'category': 'italian', 'activation': True},
               {'name': 'hashimo-hashimo', 'category': 'italian', 'activation': False}]
#define uma variavel com o name da dicionario
restaurant_name = restaurants['name']


#para importar coisas
import os

#print de mensagens
print('tá funcionando')

#definição de funções
def funcao():
  print ('amarelo')

#estrutura else/if
if i == 1:
  print ('coisa1')
elif i== 2:
  print ('coisa2')
else:
 print ('elsinho')

#funciona
print("""sefseawdf
 aljrdaljn
 awraw
 """)

# Criando uma lista de compras
lista_de_compras = ["Maçã", "Banana", "Leite", "Pão", "Queijo"]

# Adicionando um item à lista
lista_de_compras.append("Ovos")

# Removendo um item da lista
lista_de_compras.remove("Banana")

# Exibindo a lista
print("Lista de Compras:")
for item in lista_de_compras:
    print("- " + item)

#print com variável
print (f'coisa {nmome_variável} é legal')

#vai tentar executar mesmo com erro
try:

except:


#definindo user_option como un valor int do teclado com uma mensagem
user_option = int(input('Escolha uma opção: '))

#manda o comando clear no terminal
os.system('clear')

#coloca a variavel restaurant name, como parte da lista restaurants
restaurant_name.append(restaurant_name)
  
#estrutura main, definindo sua função e o que ela vai executar
def main():
    title()
    show_options()
    choose_option()

if __name__ == '__main__':
    main()

#classes
#definição de uma classe restaurants
class Restaurants:
    def __init__(self, name, category): #usando o método init inicializa o construtor da classe
      #self é o jeito de referenciar os parametros passados pelo construtor
        self.name = name
        self.category = category
        self.activation = False

sushi = Restaurants() #defini sushi a partir da classe restaurants 
print (vars(sushi)) #mostra os valores em formato de dicionário
print (dir(sushi)) #mostra os métodos da classe
