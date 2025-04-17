#!/bin/bash

# Verifica se foram passados os três parâmetros
if [ "$#" -ne 3 ]; then
    echo "[ALERT]   Uso correto do script: sudo $0 usuário senha domínio"
    sleep 2
    exit 1
fi

# Alterar as variáveis abaixo
# dir_map = Diretório onde vai ser mapeado
# server_dir = Server + diretório remoto
dir_map=/mnt/Compartilhamento
server_dir=<ip_server_remoto>/<diretório_remoto>

# Valida se foi alterado as variáveis
if [[ "$server_dir" == "<ip_server_remoto>/<diretório_remoto>" ]]; then
    echo "[ERRO]   Você precisa editar a variável server_dir no script."
    exit 1
fi

clear    
echo "- INICIANDO O SCRIPT -"
sleep 2
clear

echo "[INFO]   Atualizando o sistema ..."
sleep 2
clear
# Atualizando o sistema    
sudo apt update
sudo apt upgrade -y

clear
echo "[INFO]   Instalando o cifs ..."
sleep 2
# Instalando cifs
sudo apt install cifs-utils -y

clear
echo "[INFO]   Criando arquivo de credenciais"
sleep 2
# Criando arquivo de credenciais do SMB
touch ~/.smbcredentials
sudo bash -c "echo 'username=$1' > ~/.smbcredentials"
sudo bash -c "echo 'password=$2' >> ~/.smbcredentials"
sudo bash -c "echo 'domain=$3' >> ~/.smbcredentials"
sudo mv ~/.smbcredentials /etc/samba/.smbcredentials_$USER
sudo chmod 600 /etc/samba/.smbcredentials_$USER


clear
echo "[INFO]   Criando o mapeamento em ($dir_map)"
sleep 2

# Cria o diretório para o mapeamento, se não existir
if [ ! -d "/$dir_map" ]; then
    sudo mkdir /$dir_map
    echo "[INFO]   Diretório /$dir_map criado."
    sleep 2
else
    echo "[INFO]   Diretório /$dir_map já existe. Pulando criação."
    sleep 2
fi

clear

# Registra na tabela do fstab o mapeamento
if ! grep -q "/$dir_map" /etc/fstab; then
    echo "[INFO]   Adicionando entrada ao fstab..."
    echo "//$server_dir /$dir_map cifs credentials=/etc/samba/.smbcredentials_$USER,iocharset=utf8 0 0" | sudo tee -a /etc/fstab
else
    echo "[INFO]   Entrada no fstab já existe. Pulando."
fi

# Monta o mapeamento
if sudo mount -a; then
    echo "[INFO]   Montagem concluída com sucesso."
else
    echo "[ERRO]   Erro ao montar. Verifique as credenciais ou o caminho no /etc/fstab."
fi

clear
echo "- Script Concluído -"
sleep 2

exit 0
