#!/bin/bash

echo 'Installing everything you need...'
echo 'First update all packages'
echo '#################################################################'
sudo add-apt-repository -y ppa:flatpak/stable
sudo add-apt-repository -y ppa:kisak/kisak-mesa
sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
sudo add-apt-repository -y ppa:atareao/telegram
sudo add-apt-repository -y ppa:obsproject/obs-studio
sudo add-apt-repository -y multiverse
sudo add-apt-repository -y universe
sudo apt update
sudo apt upgrade -y
sudo apt install --fix-broken -y
sudo apt autoclean -y
sudo apt autoremove --purge
# sudo apt dist-upgrade -y
sudo timedatectl set-local-rtc 1

echo 'All packages updated'
echo '#################################################################'
echo 'Install new usless packages'
echo '#################################################################'
sudo apt install -y \
  nodejs npm nano openssh-client inxi curl linux-firmware cpu-x dpkg \
  gpg software-properties-common apt-transport-https wget make neofetch \
  build-essential libssl-dev libcurl4-gnutls-dev libexpat1-dev dirmngr \
  unzip p7zip-rar p7zip-full rar unrar zip cmake g++ gnupg clang dkms flatpak \
  ca-certificates lsb-release zlib1g-dev hardinfo hwinfo bash-completion \
  ubuntu-restricted-extras ppa-purge xz-utils gcc-multilib preload meson \
  libsystemd-dev pkg-config gdebi gdebi-core ninja-build libdbus-1-dev \
  libinih-dev pass elisa vlc gimp krita sweeper libreoffice qbittorrent \
  dconf-cli obs-studio \
  plasma-discover-backend-flatpak

# nmon nload conmon
# network-manager network-manager-gnome network-manager-openvpn-gnome \
# sudo apt install -y net-tools gnome-tweaks gnome-extensions-app gnome-shell-extension-manager \
#   gnome-software-plugin-flatpak gnome-disk-utility chrome-gnome-shell gnome-browser-connector

# sudo rm -f /var/lib/apt/lists/lock /var/cache/apt/archives/lock /var/lib/dpkg/lock

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo systemctl daemon-reload
sudo dpkg --configure -a
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"
sudo apt update
sudo apt full-upgrade
# sudo apt install backport-iwlwifi-dkms

# gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
# gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
# gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode FIXED
# gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 64
# gsettings set org.gnome.shell.extensions.dash-to-dock unity-backlit-items true
# gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size
echo 'All new useless packages installed successfully'
echo '#################################################################'

curl -L https://foundry.paradigm.xyz | bash
source /home/msi/.bashrc
foundryup

bash -c \
'cat << EOF > ~/.config/user-dirs.dirs
# This file is written by xdg-user-dirs-update
# If you want to change or add directories, just edit the line youre
# interested in. All local changes will be retained on the next run.
# Format is XDG_xxx_DIR="$HOME/yyy", where yyy is a shell-escaped
# homedir-relative path, or XDG_xxx_DIR="/yyy", where /yyy is an
# absolute path. No other format is supported.
#
XDG_DESKTOP_DIR="$HOME/Desktop"
XDG_DOWNLOAD_DIR="/mnt/D/Downloads"
XDG_DOCUMENTS_DIR="/mnt/D/Documents"
XDG_TEMPLATES_DIR="/mnt/D/Templates"
XDG_PUBLICSHARE_DIR="/mnt/D/Transfer"
XDG_MUSIC_DIR="/mnt/D/Music"
XDG_PICTURES_DIR="/mnt/D/Pictures"
XDG_VIDEOS_DIR="/mnt/D/Videos"
EOF'

chmod +x /mnt/D/CRYPTO/setup/Linux/*.sh
sudo /mnt/D/CRYPTO/setup/Linux/airpods.sh
sudo /mnt/D/CRYPTO/setup/Linux/nvm.sh
sudo /mnt/D/CRYPTO/setup/Linux/python3.sh
sudo /mnt/D/CRYPTO/setup/Linux/programm.sh
sudo /mnt/D/CRYPTO/setup/Linux/optimisation.sh
sudo /mnt/D/CRYPTO/setup/Linux/portproton.sh
sudo /mnt/D/CRYPTO/setup/Linux/postman.sh
sudo /mnt/D/CRYPTO/setup/Linux/winehqSteam.sh
sudo /mnt/D/CRYPTO/setup/Linux/docker.sh

echo 'Set autocomlete bash'
echo '#################################################################'
sudo tee -a /etc/inputrc <<< \
'
# paste after all text
set show-all-if-ambiguous On
"\e[A": history-search-backward
"\e[B": history-search-forward
'
sudo /mnt/D/CRYPTO/setup/Linux/nvidia.sh
sudo /mnt/D/CRYPTO/setup/Linux/nvidia-docker.sh

neofetch --config /mnt/D/Programs/linux/'New Folder'/neofetch/config.conf

echo 'Ended'
echo '#################################################################'









# sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/testingme.ru.conf
#
# # sudo nano /etc/apache2/sites-available/testingme.ru.conf
# sudo bash -c \
# "cat << EOF > /etc/apache2/sites-available/testingme.ru.conf
# <VirtualHost *:80>
#         ServerAdmin webmaster@testingme.ru
#         ServerName testingme.ru
#         ServerAlias www.testingme.ru
#     DocumentRoot /mnt/d/CRYPTO/testingme.ru/build/
#     <Directory /mnt/d/CRYPTO/testingme.ru/build/>
#         Options Indexes FollowSymLinks
#         AllowOverride All
#         Require all granted
#     </Directory>
#     ErrorLog ${APACHE_LOG_DIR}/error.log
#     CustomLog ${APACHE_LOG_DIR}/access.log combined
# </VirtualHost>
# EOF"
#
# sudo service apache2 start
# sudo service mysql start
#
# sudo a2ensite testingme.ru.conf
# sudo systemctl reload apache2

# ganache
# sudo sudo apt update
# sudo apt upgrade -y
# sudo apt install -y \
#   wget libgtk-3-dev libfuse-dev libgtkextra-dev libgconf2-dev libnss3 \
#   libasound2 libxtst-dev libxss1 libx11-6 libx11-xcb-dev
# wget https://github.com/trufflesuite/ganache-ui/releases/download/v2.7.1/ganache-2.7.1-linux-x86_64.AppImage
# chmod a+x ganache-2.7.1-linux-x86_64.AppImage
# ./ganache-2.7.1-linux-x86_64.AppImage
