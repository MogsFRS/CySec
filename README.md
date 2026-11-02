
 # 🛡️ CySec — Cybersecurity Notes

Anotações, comandos e referências sobre ferramentas e técnicas de cibersegurança.

---

# 1. Metasploit Framework

O **Metasploit Framework** é uma plataforma utilizada para testes de invasão (Pentest), exploração de vulnerabilidades e validação de segurança.

## 1.1. MSFConsole

O `msfconsole` é a interface principal do Metasploit, permitindo acessar módulos, exploits, payloads e sessões.

| Comando | Função |
|---|---|
| `msfconsole` | Inicia o Metasploit Framework. |
| `-q` | Inicia sem exibir o banner. |
| `-r arquivo.rc` | Executa os comandos de um arquivo RC. |
| `use <módulo>` | Seleciona um módulo. |
| `exploit -j` | Executa um exploit em segundo plano. |
| `sessions` | Lista as sessões ativas. |
| `sessions -k 1` | Encerra a sessão de ID 1. |

### Módulos importantes

| Módulo | Descrição |
|---|---|
| `exploit/multi/handler` | Handler para receber conexões de payloads compatíveis. |
| `exploit/windows/local/bypassuac` | Módulo para contornar o UAC do Windows em determinadas condições. |
| `auxiliary/scanner/http/tomcat_mgr_login` | Verifica credenciais de acesso ao Tomcat Manager. |

### Configurações

| Opção | Função |
|---|---|
| `ExitOnSession false` | Mantém o handler ativo após receber uma sessão, permitindo receber outras conexões. |

---

## 1.2. Meterpreter

O Meterpreter é um payload avançado do Metasploit que oferece interação com o sistema comprometido durante um teste autorizado.

### Gerenciamento de sessões

| Comando | Função |
|---|---|
| `background` | Coloca a sessão atual em segundo plano e retorna ao MSFConsole. |
| `sessions` | Mostra as sessões ativas. |
| `sessions -i <ID>` | Interage com uma sessão específica. |
| `sessions -k <ID>` | Encerra uma sessão específica. |

### Gerenciamento de processos

| Comando | Função |
|---|---|
| `ps` | Lista os processos em execução. |
| `migrate <PID>` | Migra a sessão para outro processo, quando permitido. |

---

## 1.3. MSFVenom

O `msfvenom` é uma ferramenta para geração de payloads do Metasploit, permitindo definir arquitetura, sistema operacional, tipo de payload e formato de saída.

### Parâmetros principais

| Parâmetro | Função |
|---|---|
| `-a` | Define a arquitetura do alvo, como `x86` ou `x64`. |
| `--platform` | Define a plataforma do sistema operacional. |
| `-p` | Seleciona o payload. |
| `-f` | Define o formato do arquivo gerado. |
| `-o` | Define o nome e o caminho do arquivo de saída. |

### Consulta de payloads e opções

| Comando | Função |
|---|---|
| `msfvenom -l payloads` | Lista todos os payloads disponíveis. |
| `msfvenom -l formats` | Lista todos os formatos de saída disponíveis. |
| `msfvenom -l platforms` | Lista as plataformas disponíveis. |
| `msfvenom -l archs` | Lista as arquiteturas disponíveis. |
| `msfvenom --list-options -p <PAYLOAD>` | Mostra as opções de configuração de um payload específico. |
| `msfvenom -p <PAYLOAD> --list-options` | Alternativa para listar as opções do payload. |

### Formatos de saída (`-f`)

| Formato | Extensão | Sistema / finalidade |
|---|---|---|
| `elf` | `.elf` | Executável Linux. |
| `elf-so` | `.so` | Biblioteca compartilhada Linux. |
| `exe` | `.exe` | Executável Windows. |
| `exe-only` | `.exe` | Executável Windows sem payload adicional. |
| `exe-service` | `.exe` | Executável Windows em formato de serviço. |
| `dll` | `.dll` | Biblioteca dinâmica Windows. |
| `war` | `.war` | Pacote de aplicação Java Web. |
| `asp` | `.asp` | Script ASP. |
| `aspx` | `.aspx` | Script ASP.NET. |
| `aspx-exe` | `.aspx` | Executável ASP.NET. |
| `axis2` | `.jar` | Pacote para Apache Axis2. |

### Integração com MSFConsole

Para um teste de conexão reversa autorizado:

1. Gere um payload com as configurações desejadas.
2. Configure o `exploit/multi/handler` no MSFConsole.
3. Utilize no handler as mesmas configurações de payload e conexão usadas na geração.
4. Inicie o handler para aguardar a conexão.

**Importante:** o payload e o handler precisam ter configurações compatíveis, incluindo tipo de payload, endereço e porta de conexão.

---

# 2. Nmap — Análise de Firewall e Filtragem

O Nmap é uma ferramenta de descoberta de hosts, identificação de portas abertas e análise de serviços de rede.

## 2.1. Técnicas de análise de tráfego e filtragem

| Parâmetro | Função |
|---|---|
| `-f` | Fragmenta os pacotes IP. |
| `--mtu` | Define o tamanho dos fragmentos IP. |
| `-D` | Utiliza endereços decoy para identificar como os sistemas registram a origem do scan. |
| `-S` | Define manualmente o endereço IP de origem. |
| `-g` | Define a porta de origem dos pacotes. |
| `--source-port` | Alternativa para definir a porta de origem. |
| `--data-length` | Adiciona dados aleatórios aos pacotes. |
| `--badsum` | Envia pacotes com checksum inválido. |
| `-T0` | Define uma temporização extremamente lenta e sequencial. |
| `-T1` | Define uma temporização lenta. |
| `--top-ports` | Analisa um número predefinido de portas mais comuns. |

## 2.2. Descoberta de hosts e análise de portas

| Parâmetro | Função |
|---|---|
| `-Pn` | Ignora a descoberta de hosts e considera o alvo ativo. |
| `-sA` | TCP ACK Scan: ajuda a identificar o comportamento de filtros de pacotes. |
| `-sS` | TCP SYN Scan. |
| `-sN` | TCP Null Scan. |
| `-sF` | TCP FIN Scan. |
| `-sX` | TCP Xmas Scan. |
| `-sW` | TCP Window Scan. |
| `-sU` | UDP Scan. |
| `-p-` | Analisa todas as portas TCP. |
| `--reason` | Mostra o motivo pelo qual uma porta recebeu determinado estado. |

---

# 3. SMB — smbclient

O SMB (Server Message Block) é um protocolo utilizado para compartilhamento de arquivos, diretórios e recursos em redes.

### Portas comuns

| Porta | Serviço |
|---|---|
| `445/TCP` | SMB diretamente sobre TCP. |
| `139/TCP` | SMB sobre NetBIOS. |

## 3.1. Comandos do smbclient

| Comando | Função |
|---|---|
| `smbclient -L //<IP>` | Lista os compartilhamentos disponíveis no servidor. |
| `smbclient //<IP>/<COMPARTILHAMENTO>` | Conecta a um compartilhamento SMB. |
| `smbclient //<IP>/<COMPARTILHAMENTO> -U <USUARIO>` | Conecta utilizando um usuário específico. |

### Exemplos de utilização

**Listar compartilhamentos:**

```bash
smbclient -L //192.168.1.100
```

**Acessar um compartilhamento:**

```bash
smbclient //192.168.1.100/shared
```

**Acessar utilizando um usuário:**

```bash
smbclient //192.168.1.100/shared -U usuario
```

---

# 4. Referência rápida

| Ferramenta | Finalidade |
|---|---|
| Metasploit | Exploração de vulnerabilidades e testes de segurança. |
| MSFConsole | Interface de gerenciamento do Metasploit. |
| Meterpreter | Ambiente de interação com sessões de payload. |
| MSFVenom | Geração de payloads. |
| Nmap | Descoberta e análise de redes e serviços. |
| smbclient | Acesso e gerenciamento de compartilhamentos SMB. |

---

*README de estudos — Cybersecurity / Pentest.*
