# Download the packages file
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B05498B7
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


# Monero
wget https://downloads.getmonero.org/gui/monero-gui-linux-x64-v0.18.3.3.tar.bz2
wget -O binaryfate.asc https://raw.githubusercontent.com/monero-project/monero/master/utils/gpg_keys/binaryfate.asc
wget -O hashes.txt https://www.getmonero.org/downloads/hashes.txt

gpg --keyid-format long --with-fingerprint binaryfate.asc
gpg --import binaryfate.asc
gpg --verify hashes.txt

shasum -a 256 monero-gui-linux-x64-v0.18.3.3.tar.bz2

tar xf monero-gui-linux-x64-v0.18.3.3.tar.bz2
cd monero-gui-v0.18.3.3

./monero-wallet-gui
./monero-wallet-cli
nano ~/.local/share/applications/monero-gui.desktop


sudo apt-get install -y pandoc make
sudo apt-get install -y texlive texlive-xetex
sudo apt-get install -y monero monero-tests
flatpak install flathub org.getmonero.Monero

elbow rustled orphans veered sailor seasons asked upstairs voted tweezers paper elope cinema utopia angled nail beware films bicycle lava piloted fetches slug smidgen smidgen
