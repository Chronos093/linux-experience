#!/bin/bash

clear
echo "- INICIANDO SCRIPT -"
sleep 2
clear

# CONFIGURA O PROXY NO ENVIRONMENT
sudo echo "http_proxy=\"http://<usuário>:<senha>@<ip_server>:<porta>\"" >> /etc/environment
sudo echo "https_proxy=\"http://<usuário>:<senha>@<ip_server>:<porta>\"" >> /etc/environment
sudo echo "no_proxy='localhost,127.0.0.1,::1'" >> /etc/environment

echo "[INFO]  Alterado o arquivo /etc/environment"
sleep 2
clear

# CONFIGURA O PROXY NO APT
sudo touch /etc/apt/apt.conf
sudo echo "Acquire::http::proxy \"http://<usuário>:<senha>@<ip_server>:<porta>\";" >> /etc/apt/apt.conf
sudo echo "Acquire::https::proxy \"http://<usuário>:<senha>@<ip_server>:<porta>\";" >> /etc/apt/apt.conf

echo "[INFO]  Criado o arquivo de configuração do apt ..."
sleep 2
echo "[INFO]  Alterado o arquivo /etc/apt/apt.conf"
sleep 2
clear

exit