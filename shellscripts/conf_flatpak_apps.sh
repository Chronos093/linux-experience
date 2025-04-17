#!/bin/bash

clear
echo "= INICIANDO SCRIPT ="
sleep 2
clear
# VERIFICA SE O FLATPAK ESTÁ INSTALADO
if ! command -v flatpak &> /dev/null; then
    echo "[ALERT] - Flatpak não está instalado."
    sleep 2
    echo "[INFO] - Atualizando o sistema"
    sudo apt update && sudo apt upgrade -y
    clear

    echo "[INFO] - Instalando o Flatpak"
    sleep 2
    sudo apt install -y flatpak
    clear
else
    echo "[INFO] - Flatpak já instalado"
fi

clear
echo "[INFO] - Instalando os pacotes Flatpak"
sleep 3
clear

# INSTALANDO OS SOFTWARES
# Lista de pacotes Flatpak
pacotes=(
    "com.discordapp.Discord"
    "org.telegram.desktop"
    "com.spotify.Client"
    "org.gimp.GIMP"
    "com.valvesoftware.Steam"
    "org.videolan.VLC"
    "com.visualstudio.code"
    "net.lutris.Lutris"
    "com.bitwarden.desktop"
    "org.mozilla.Thunderbird"
    "org.gnome.Boxes"
    "com.anydesk.Anydesk"
    "org.remmina.Remmina"
    "com.getpostman.Postman"
    "com.jeffser.Alpaca"
    "io.dbeaver.DBeaverCommunity"
    "com.system76.Popsicle"
    "com.transmissionbt.Transmission"
    "io.github.shiftey.Desktop"
    "org.raspberrypi.rpi-imager"
    "org.upscayl.Upscayl"
    "dev.deedles.Trayscale"
    "org.localsend.localsend_app"
    "com.warlordsoftwares.youtube-downloader-4ktube"
    "com.github.iwalton3.jellyfin-media-player"
    "org.freedesktop.Piper"
    "com.belmoussaoui.Authenticator"
    "net.codelogistics.webapps"
    "io.github.realmazharhussain.GdmSettings"
    "io.github.flattool.Warehouse"
)

for pacote in "${pacotes[@]}"; do
    if ! flatpak list | grep -q "$pacote"; then
        read -p "   Deseja instalar $pacote? (s/n): " resposta
        if [[ "$resposta" == "s" ]]; then
            flatpak install -y flathub "$pacote"
            if flatpak list | grep -q "$pacote"; then
                echo "[INFO] - $pacote instalado com sucesso!"
                sleep 3
                clear
            else
                echo "[ALERT] - Houve um erro ao instalar $pacote."
                sleep 3
                clear
            fi
        else
            echo "[INFO] - Pular instalação de $pacote."
            sleep 3
            clear
        fi
    else
        echo "[INFO] - $pacote já está instalado!"
        sleep 3
        clear
    fi
done

echo "[INFO] - Processo concluído!"
