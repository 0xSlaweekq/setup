echo 'Installing everything you need...'
echo 'First update all packages'
echo '#################################################################'

sudo add-apt-repository -y ppa:flatpak/stable
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y --fix-broken install
sudo apt-get -y autoclean
sudo apt-get -y autoremove --purge
# sudo apt-get -y dist-upgrade
sudo timedatectl set-local-rtc 1

echo 'All packages updated'
echo '#################################################################'
echo 'Install new usless packages'
echo '#################################################################'
sudo apt-get -y install \
  nodejs npm nano openssh-client inxi curl linux-firmware cpu-x dpkg \
  gpg software-properties-common apt-transport-https wget make gettext \
  build-essential libssl-dev libcurl4-gnutls-dev libexpat1-dev dirmngr \
  unzip p7zip-rar p7zip-full rar unrar zip nmon nload conmon cmake g++ \
  ca-certificates gnupg lsb-release zlib1g-dev hardinfo hwinfo clang \
  bash-completion ubuntu-restricted-extras ppa-purge xz-utils vlc dkms \
  gcc-multilib sweeper flatpak snap snapd qbittorrent davfs2 dconf-cli \
  libreoffice gamemode preload meson libsystemd-dev pkg-config \
  ninja-build libdbus-1-dev libinih-dev power-profiles-daemon
  
  powerprofilesctl list
  # cpufrequtils indicator-cpufreq tlp tlp-rdw
  # plasma-discover-backend-flatpak
  # network-manager network-manager-gnome network-manager-openvpn-gnome \
  # net-tools 

# sudo systemctl enable tlp.service
# sudo tlp start
# echo 'GOVERNOR="performance"' | sudo tee /etc/default/cpufrequtils
# sudo systemctl restart cpufrequtils

#   gnome-tweaks gnome-extensions-app gnome-shell-extension-manager \
#   gnome-software-plugin-flatpak gnome-disk-utility

# sudo rm -f /var/lib/apt/lists/lock /var/cache/apt/archives/lock /var/lib/dpkg/lock

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo systemctl daemon-reload
sudo dpkg --configure -a
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"

sudo add-apt-repository -y ppa:kubuntu-ppa/ppa
sudo add-apt-repository -y ppa:kubuntu-ppa/backports
sudo add-apt-repository -y multiverse
sudo apt-get update
sudo pkcon update
sudo apt-get full-upgrade

sudo add-apt-repository ppa:canonical-hwe-team/backport-iwlwifi
sudo apt-get update
sudo apt install backport-iwlwifi-dkms

# gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
# gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
# gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode FIXED
# gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 64
# gsettings set org.gnome.shell.extensions.dash-to-dock unity-backlit-items true
# gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size

echo 'All new useless packages installed successfully'
echo '#################################################################'
chmod +x ./git.sh
sudo ./git.sh
chmod +x ./debs.sh
sudo ./debs.sh
chmod +x ./nvidia.sh
sudo ./nvidia.sh
chmod +x ./python3.sh
sudo ./python3.sh
chmod +x ./nvm.sh
sudo ./nvm.sh
chmod +x ./airpods.sh
sudo ./airpods.sh
chmod +x ./programm.sh
sudo ./programm.sh
chmod +x ./docker.sh
sudo ./docker.sh
chmod +x ./yandex.sh
sudo ./yandex.sh


echo 'Set autocomlete bash'
echo '#################################################################'
sudo tee -a /etc/inputrc <<< \
'
# paste after all text
set show-all-if-ambiguous On
"\e[A": history-search-backward
"\e[B": history-search-forward'

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y --fix-broken install
sudo apt-get -y autoclean
sudo apt-get -y autoremove --purge
gpg --generate-key
echo 'pass init B381A9F621F86E30EB14EBAD9066D29FF5813FE3
systemctl --user start docker-desktop'
curl -L https://foundry.paradigm.xyz | bash
source /home/msi/.bashrc
foundryup
echo 'See All ppa repos: grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/*'
echo 'Ended'
echo '#################################################################'
echo 'after all installs prog and themes'
echo 'dconf load / < dconf-settings.ini'

# dconf dump / > dconf-settings.ini

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
XDG_DOWNLOAD_DIR="/mnt/Documents/Downloads"
XDG_DOCUMENTS_DIR="/mnt/Documents/Documents"
XDG_TEMPLATES_DIR="/mnt/Documents/home/Templates"
XDG_PUBLICSHARE_DIR="/mnt/Documents/home/Transfer"
XDG_MUSIC_DIR="/mnt/Documents/home/Music"
XDG_PICTURES_DIR="/mnt/Documents/home/Pictures"
XDG_VIDEOS_DIR="/mnt/Documents/home/Videos"
EOF'









# sudo reboot
# 127.0.0.1 testingme.ru
# sudo service apache2 stop
# sudo service mysql stop

#   apache2
#   mysql-server
#   nginx

# sudo a2enmod rewrite
# sudo service mysql start
# sudo mysql -uroot -p

# SELECT user, authentication_string, plugin, host FROM mysql.user WHERE user="root";
# ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';
# FLUSH PRIVILEGES;
# exit

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
# sudo sudo apt-get update
# sudo apt-get -y upgrade
# sudo apt-get -y install wget \
#   libgtk-3-dev \
#   libfuse-dev \
#   libgtkextra-dev \
#   libgconf2-dev \
#   libnss3 libasound2 \
#   libxtst-dev \
#   libxss1 \
#   libx11-6 \
#   libx11-xcb-dev
# wget https://github.com/trufflesuite/ganache-ui/releases/download/v2.7.1/ganache-2.7.1-linux-x86_64.AppImage
# chmod a+x ganache-2.7.1-linux-x86_64.AppImage
# ./ganache-2.7.1-linux-x86_64.AppImage
