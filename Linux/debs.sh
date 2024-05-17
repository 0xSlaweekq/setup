# Download the packages file
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B05498B7
wget -q https://packages.microsoft.com/config/ubuntu/23.04/packages-microsoft-prod.deb
wget https://github.com/lutris/lutris/releases/download/v0.5.17/lutris_0.5.17_all.deb

# wget https://download.anydesk.com/linux/anydesk_6.1.1-1_amd64.deb
# wget https://github.com/lutris/lutris/releases/download/v0.5.14/lutris_0.5.14_all.deb
# wget https://repo.steampowered.com/steam/archive/precise/steam_latest-stable.deb
# wget https://download.virtualbox.org/virtualbox/7.0.12/virtualbox-7.0_7.0.12-159484~Ubuntu~jammy_amd64.deb
# wget https://download.virtualbox.org/virtualbox/7.0.12/Oracle_VM_VirtualBox_Extension_Pack-7.0.12.vbox-extpack
# wget https://download.virtualbox.org/virtualbox/7.0.12/VirtualBoxSDK-7.0.12-159484.zip

# Install packages
sudo apt-get install -y ./lutris_0.5.17_all.deb ./packages-microsoft-prod.deb
sudo apt-get install --fix-broken -y
sudo apt-get install -y -f
sudo systemctl daemon-reload
# Remove packages
sudo rm -rf packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y powershell
