#!/bin/bash

echo 'Install programm'
echo '#################################################################'
# Adding keys
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/packages.microsoft.gpg
# wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

# Adding repos
sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |\
  sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/microsoft.gpg] https://packages.microsoft.com/repos/edge stable main" |\
  sudo tee /etc/apt/sources.list.d/microsoft-edge.list > /dev/null
# $(lsb_release -cs)
# sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo rm -rf packages.microsoft.gpg microsoft.gpg

# cd /etc/apt/sources.list.d
# sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com `sudo apt update 2>&1 | grep -o '[0-9A-Z]\{16\}$' | xargs`

# installing
sudo apt update
sudo dpkg --add-architecture amd64
sudo dpkg --add-architecture i386
sudo apt update
sudo apt upgrade -y
# sudo apt install -y google-chrome-stable
sudo apt install -y \
  microsoft-edge-stable code telegram grub-customizer
sudo apt install --fix-broken -y

# Options for shell in vscode
xdg-mime default code.desktop text/plain
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
mkdir -p $HOME/.local/share/trusted.gpg.d
code --locate-shell-integration-path bash
[[ "$TERM_PROGRAM" == "vscode" ]] && . "/path/to/shell/integration/script.sh"

flatpak install -y flathub \
  com.discordapp.Discord org.gnome.Maps com.github.tchx84.Flatseal \
  io.github.mimbrero.WhatsAppDesktop org.kde.isoimagewriter \
  com.github.sdv43.whaler org.onlyoffice.desktopeditors com.usebottles.bottles \
  org.getoutline.OutlineClient org.getoutline.OutlineManager \
  com.github.Matoking.protontricks net.davidotek.pupgui2 \
  org.audacityteam.Audacity

#  net.lutris.Lutris com.playonlinux.PlayOnLinux4

sudo curl https://raw.githubusercontent.com/Tenderly/tenderly-cli/master/scripts/install-linux.sh | sudo sh
tenderly login --authentication-method access-key --access-key FWrGeuFEOTmwzUdD4Glm1BRl1ov5hNLJ --force

# install virtualbox
sudo apt install -y virtualbox
# sudo newgrp vboxusers
sudo usermod -aG vboxusers $USER
sudo adduser $USER vboxusers
sudo apt install -y virtualbox-dkms xserver-xorg-core cpu-checker


# # install qemu
# sudo apt update
# sudo apt install -y \
#   cpu-checker bridge-utils libvirt-daemon-system libvirt-clients \
#   virt-manager virtinst qemu-kvm
# sudo adduser $USER libvirt
# sudo adduser $USER kvm
# sudo systemctl enable --now libvirtd
# sudo systemctl start libvirtd
# sudo systemctl status libvirtd
# sudo usermod -aG kvm $USER
# sudo usermod -aG libvirt $USER
# virt-manager

# # dotNet
# sudo apt update && \
#   sudo apt install -y \
#   dotnet-sdk-8.0 aspnetcore-runtime-8.0 dotnet-runtime-8.0 zlib1g ca-certificates \
#   libc6 libgcc-s1 libicu74 liblttng-ust1 libssl3 libstdc++6 libunwind8

# cd ~
# wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
# chmod +x ./dotnet-install.sh
# ./dotnet-install.sh --channel 6.0
# ./dotnet-install.sh --channel 7.0
# ./dotnet-install.sh --version latest
# rm ./dotnet-install.sh
echo 'All programm installed'
echo '#################################################################'


# wget -qO- https://releases.warp.dev/linux/keys/warp.asc | gpg --dearmor > warpdotdev.gpg
# sudo install -D -o root -g root -m 644 warpdotdev.gpg /etc/apt/trusted.gpg.d/warpdotdev.gpg
# sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/warpdotdev.gpg] https://releases.warp.dev/linux/deb stable main" > /etc/apt/sources.list.d/warpdotdev.list'
# rm warpdotdev.gpg
# sudo apt update && sudo apt install -y warp-terminal

# wget https://wireless.wiki.kernel.org/_media/en/users/drivers/iwlwifi-ty-59.601f3a66.0.tgz
