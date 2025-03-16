#!/bin/bash

# Atualiza o sistema
echo "Atualizando o sistema..."
sudo apt-get update
sudo apt-get upgrade -y

# Instala dependências necessárias
echo "Instalando dependências..."
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Adiciona a chave GPG do Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Adiciona o repositório do Docker
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Atualiza o repositório novamente
echo "Atualizando repositórios do Docker..."
sudo apt-get update

# Instala o Docker
echo "Instalando o Docker..."
sudo apt-get install -y docker-ce

# Inicia o serviço do Docker
echo "Iniciando o serviço do Docker..."
sudo systemctl start docker
sudo systemctl enable docker

# Verifica se o Docker foi instalado corretamente
if ! command -v docker &> /dev/null
then
    echo "Docker não foi instalado corretamente. Saindo..."
    exit 1
fi

echo "Docker instalado com sucesso!"

# Cria um container Apache
echo "Criando um container Apache..."
sudo docker run -d --name Apache -p 80:80 httpd

# Cria um container MySQL
echo "Criando um container MySQL..."
sudo docker run -d --name MySql -e MYSQL_ROOT_PASSWORD=123456 -p 3306:3306 mysql:latest

echo "Containers criados com sucesso!"
echo "Apache está disponível em http://localhost"
echo "MySQL está rodando na porta 3306 com a senha '123456'"
