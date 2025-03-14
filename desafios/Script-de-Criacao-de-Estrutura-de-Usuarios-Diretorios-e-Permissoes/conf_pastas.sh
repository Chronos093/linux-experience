#!/bin/bash

echo '- INICIANDO O SCRIPT -'
sleep 3
clear

# CRIAÇÃO DOS DIRETÓRIOS
echo ' Criando os diretorios ...'
sleep 3
clear

mkdir /publico -v
mkdir /adm -v
mkdir /ven -v
mkdir /sec -v

echo ''
echo ' Diretorios criados com sucesso.'
sleep 3
clear

# CRIAÇÃO DOS GRUPOS DE USUÁRIOS
echo ' Criando os grupos (GRP_ADM, GRP_VEN, GRP_SEC) ...'
sleep 3
clear

groupadd GRP_ADM
groupadd GRP_VEN
groupadd GRP_SEC

echo ' Grupos criados com sucesso.'
sleep 3
clear

# CRIAÇÃO DOS USUÁRIOS
echo ' Criando os usuários ...'
sleep 3
clear

useradd carlos -m -s /bin/bash -p $(openssl passwd -6 Senha123) -G GRP_ADM
useradd maria -m -s /bin/bash -p $(openssl passwd -6 Senha123) -G GRP_ADM
useradd joao -m -s /bin/bash -p $(openssl passwd -6 Senha123) -G GRP_ADM

useradd debora -m -s /bin/bash -p $(openssl passwd -6 Senha123) -G GRP_VEN
useradd sebastiana -m -s /bin/bash -p $(openssl passwd -6 Senha123) -G GRP_VEN
useradd roberto -m -s /bin/bash -p $(openssl passwd -6 Senha123) -G GRP_VEN

useradd josefina -m -s /bin/bash -p $(openssl passwd -6 Senha123) -G GRP_SEC
useradd amanda -m -s /bin/bash -p $(openssl passwd -6 Senha123) -G GRP_SEC
useradd rogerio -m -s /bin/bash -p $(openssl passwd -6 Senha123) -G GRP_SEC

echo ' Usuários criados com sucesso.'
sleep 3
clear

# ATRIBUINDO PERMISSÕES NOS DIRETÓRIOS
echo ' Atribuindo permissões nos diretórios ...'
sleep 3
clear

chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec

chmod 770 /adm
chmod 770 /ven
chmod 770 /sec
chmod 777 /publico

echo ' Sucesso.'
sleep 2
clear

echo '- SCRIPT CONCLUÍDO -'
sleep 3
clear

exit
