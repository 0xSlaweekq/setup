# Download the packages file
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B05498B7
# https://ubuntu.pkgs.org/23.04/ubuntu-main-amd64/network-manager_1.42.4-1ubuntu2_amd64.deb.html
# wget http://archive.ubuntu.com/ubuntu/pool/main/n/network-manager/network-manager_1.42.4-1ubuntu2_amd64.deb
wget https://github.com/PowerShell/PowerShell/releases/download/v7.4.0/powershell_7.4.0-1.deb_amd64.deb
wget https://dl.discordapp.net/apps/linux/0.0.40/discord-0.0.40.deb
wget https://github.com/shiftkey/desktop/releases/download/release-3.1.1-linux1/GitHubDesktop-linux-3.1.1-linux1.deb
wget https://download.anydesk.com/linux/anydesk_6.1.1-1_amd64.deb
# wget https://github.com/lutris/lutris/releases/download/v0.5.14/lutris_0.5.14_all.deb
# wget https://repo.steampowered.com/steam/archive/precise/steam_latest-stable.deb
# wget https://download.virtualbox.org/virtualbox/7.0.12/virtualbox-7.0_7.0.12-159484~Ubuntu~jammy_amd64.deb
# wget https://download.virtualbox.org/virtualbox/7.0.12/Oracle_VM_VirtualBox_Extension_Pack-7.0.12.vbox-extpack
# wget https://download.virtualbox.org/virtualbox/7.0.12/VirtualBoxSDK-7.0.12-159484.zip

# Install packages
sudo apt -y install \
  ./powershell_7.4.0-1.deb_amd64.deb ./discord-0.0.40.deb \
  ./GitHubDesktop-linux-3.1.1-linux1.deb ./anydesk_6.1.1-1_amd64.deb
sudo apt -y --fix-broken install
sudo apt install -f
sudo systemctl daemon-reload
# Remove packages
sudo rm -rf \
  powershell_7.4.0-1.deb_amd64.deb discord-0.0.40.deb \
  GitHubDesktop-linux-3.1.1-linux1.deb anydesk_6.1.1-1_amd64.deb
