#!/bin/bash

# SERVIDOR APACHE

# Atualiza o servidor
sudo apt update
sudo apt upgrade -y

# Instala o Apache e outros pacotes
sudo apt install apache2 -y
sudo apt install unzip -y
sudo apt install wget -y

# Baixa o zip do Git
cd /tmp
wget -r http://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip
cd github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/

# Extrai o zip
unzip main.zip

# Copia os arquivos do main.zip para o padrão Apache
cp -r linux-site-dio-main/ /var/www/html

exit 0
