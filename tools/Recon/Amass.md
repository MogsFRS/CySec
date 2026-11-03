# OWASP Amass — Reconhecimento e Mapeamento de Ativos

## 1. O que é?

O **OWASP Amass** é uma ferramenta de reconhecimento e mapeamento de superfície de ataque.

Ela reúne informações de diferentes fontes para ajudar a identificar:
- Domínios.
- Subdomínios.
- Endereços IP.
- Infraestrutura relacionada.
- Informações DNS.
- Ativos expostos na internet.

O Amass combina coleta de informações públicas com técnicas de reconhecimento ativo, dependendo da configuração.

Projeto: https://github.com/owasp-amass/amass

## 2. Como funciona?

O Amass utiliza diferentes fontes e técnicas para encontrar relações entre domínios e infraestrutura.

O resultado pode ser usado para montar um inventário dos ativos associados a uma organização.

É importante distinguir:

| Tipo | Característica |
|---|---|
| Reconhecimento passivo | Consulta fontes de informação sem realizar diretamente testes contra os ativos descobertos |
| Reconhecimento ativo | Realiza consultas ou interações diretamente com a infraestrutura |
| Enumeração DNS | Identifica nomes e registros associados a domínios |

O modo utilizado depende dos parâmetros e da configuração.

## 3. Instalação

No Kali:

```bash
sudo apt update
sudo apt install amass
```

Verifique:

```bash
amass -help
```

A disponibilidade da versão e de seus subcomandos pode variar conforme o pacote instalado.

## 4. Principais subcomandos

| Subcomando | Finalidade |
|---|---|
| `intel` | Coleta inteligência relacionada à organização |
| `enum` | Enumeração de domínios e mapeamento de infraestrutura |
| `viz` | Visualização de dados |
| `track` | Comparação de resultados de enumerações |
| `db` | Gerenciamento dos dados armazenados |

Consulte a ajuda da versão instalada:

```bash
amass -help
amass enum -help
```

## 5. Enumeração básica

Em um domínio que você controla ou tem autorização para avaliar:

```bash
amass enum -d exemplo.com
```

O parâmetro `-d` informa o domínio principal.

## 6. Salvando os resultados

```bash
amass enum -d exemplo.com -o subdominios.txt
```

O arquivo pode ser utilizado posteriormente por ferramentas de DNS e HTTP.

## 7. Reconhecimento ativo

O Amass possui opções para habilitar técnicas ativas. Elas devem ser utilizadas somente dentro do escopo autorizado.

Exemplo de estrutura de comando documentada pelo projeto:

```bash
amass enum -active -d exemplo.com
```

O reconhecimento ativo pode gerar tráfego diretamente contra a infraestrutura.

## 8. Integração com outras ferramentas

Uma sequência de trabalho pode ser:

```text
Amass
  |
  v
Lista de subdomínios
  |
  v
dnsx
  |
  v
Resolução DNS
  |
  v
httpx
  |
  v
Identificação de serviços HTTP
```

O Amass encontra possíveis ativos; outras ferramentas ajudam a verificar quais nomes resolvem e quais serviços web respondem.

## 9. Interpretando resultados

Ao analisar a saída, procure:
- Nome do subdomínio.
- Endereço IP associado.
- Fonte da informação, quando disponível.
- Relações entre nomes e infraestrutura.
- Resultados que precisam de confirmação.

Um subdomínio encontrado não significa necessariamente que esteja ativo ou pertença atualmente à organização.

## 10. Cuidados

- Defina o domínio e o escopo autorizado.
- Diferencie coleta passiva de técnicas ativas.
- Não considere resultados como confirmação automática de propriedade.
- Evite varreduras ativas em infraestrutura de terceiros.
- Mantenha os resultados organizados e datados.

## 11. Documentação

- OWASP Amass: https://owasp.org/www-project-amass/
- GitHub: https://github.com/owasp-amass/amass
- Guia do usuário: https://github.com/owasp-amass/amass/wiki/User-Guide
