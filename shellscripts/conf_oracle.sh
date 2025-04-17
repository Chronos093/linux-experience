#!/bin/bash

# INSTALA O ORACLE CLIENT E CONFIGURA
# Atualiza o sistema
clear
echo "Atualizando o sistema"
echo ""
sleep 1
sudo apt update
sudo apt upgrade -y
sleep 2
clear

# Instala pacotes
echo "Instalando Pacotes"
echo ""
sleep 1
sudo apt install zip -y
sudo apt install wget -y
sleep 2
clear

# Verifica se a pasta do oracle já existe
pasta="/oracle/product/11.2.0"
if [ -d "$pasta" ]; then
    echo "Pasta Oracle já existe, pulando passo."
else
# Baixando o cliente Oracle
    echo "Baixando Oracle Client"
    echo ""
    sleep 1
    cd /tmp
    wget https://github.com/dockette/oracle-instantclient/raw/refs/heads/master/instantclient-basic-linux.x64-11.2.0.4.0.zip
    wget https://github.com/dockette/oracle-instantclient/raw/refs/heads/master/instantclient-sqlplus-linux.x64-11.2.0.4.0.zip
    sleep 2
    clear
    
# Cria a pasta para o cliente oracle em '/' e extrai os arquivos zip
    echo "Criando Pasta do oracle em '/'"
    echo ""
    sleep 2
    sudo mkdir -p $pasta
    cd /tmp
    unzip instantclient-basic-linux.x64-11.2.0.4.0.zip -d $pasta
    unzip instantclient-sqlplus-linux.x64-11.2.0.4.0.zip -d $pasta
    echo ""
    echo "Pasta oracle criada com sucesso."
    sleep 2
fi

clear

clientPath="$pasta/instantclient_11_2"
tnsPath="$clientPath/network/admin"

# Configuração das variáveis de ambiente
echo "Configurando as variáveis de ambiente..."
echo ""
sleep 2

# Adiciona o LD_LIBRARY_PATH
if ! grep -q "LD_LIBRARY_PATH=$clientPath" /etc/profile; then
    echo "export LD_LIBRARY_PATH=$clientPath:\$LD_LIBRARY_PATH" >> /etc/profile
    echo "Variável LD_LIBRARY_PATH configurada."
fi

# Adiciona o PATH
if ! grep -q "PATH=$clientPath" /etc/profile; then
    echo "export PATH=$clientPath:\$PATH" >> /etc/profile
    echo "Variável PATH configurada."
fi

clear

# Configura o arquivo tnsnames.ora
echo "Configurando o tnsnames.ora..."
echo ""
sleep 2
if [ ! -d "$tnsPath" ]; then
    sudo mkdir -p "$tnsPath"
    echo "Diretório de configuração de rede criado: $tnsPath"
    echo ""
    sleep 2
fi

# Cria um arquivo tnsnames.ora de exemplo, se ainda não existir
if [ ! -f "$tnsPath/tnsnames.ora" ]; then
    echo "CONEXAO =" > $tnsPath/tnsnames.ora
    echo "  (DESCRIPTION =" >> $tnsPath/tnsnames.ora
    echo "    (ADDRESS = (PROTOCOL = <>)(HOST = <>)(PORT = <>))" >> $tnsPath/tnsnames.ora
    echo "    (CONNECT_DATA =" >> $tnsPath/tnsnames.ora
    echo "      (SERVER = <>)" >> $tnsPath/tnsnames.ora
    echo "      (SERVICE_NAME = <>)" >> $tnsPath/tnsnames.ora
    echo "    )" >> $tnsPath/tnsnames.ora
    echo "  )" >> $tnsPath/tnsnames.ora

    echo "Arquivo tnsnames.ora criado em $tnsPath"
else
    echo "O arquivo tnsnames.ora já existe em $tnsPath"
fi

# Aplica as mudanças ao ambiente
echo "Aplicando alterações ao ambiente..."
source ~/.bashrc

exit 0
