# cd ~ && \
# curl -O https://raw.githubusercontent.com/NarcoNik/setup/main/vpn/vpn-install.sh
# chmod +x vpn-i.sh
# sudo ./vpn-i.sh
# echo "First add new user"
# adduser msi
# sudo usermod -aG sudo msi
# su - msi
echo "Updating system"
echo '#################################################################'
tee -a ~/.bashrc <<< \
'
alias si="sudo apt -y install"
alias srf="sudo rm -rf"
alias srn="sudo reboot now"
alias srp="sudo apt -y remove --purge"
alias sdr="sudo systemctl daemon-reload"
alias supd="sudo apt update && sudo apt -y upgrade && sudo apt -y --fix-broken install && sudo apt -y autoclean && sudo apt -y autoremove --purge"
'
sudo apt update
sudo apt -y upgrade
sudo apt -y --fix-broken install
sudo apt -y autoclean
sudo apt -y autoremove --purge
sudo apt -y install git nano resolvconf curl wireguard wireguard-tools
echo "Installing wireguard"
echo '#################################################################'
cd ~
# wget https://git.io/wireguard -O wireguard-install.sh && sudo bash wireguard-install.sh
curl -O https://raw.githubusercontent.com/NarcoNik/wireguard-install/master/wireguard-install.sh
chmod +x wireguard-install.sh
sudo ./wireguard-install.sh
# curl -O https://raw.githubusercontent.com/NarcoNik/setup/main/vpn/wg-install.sh
# chmod +x wg-install.sh
# sudo ./wg-install.sh
echo "Installing 3proxy"
echo '#################################################################'
cd ~
curl -O https://raw.githubusercontent.com/NarcoNik/setup/main/vpn/3proxy-install.sh
curl -O https://raw.githubusercontent.com/NarcoNik/setup/main/vpn/3proxy-uninstall.sh
chmod +x 3proxy-install.sh
chmod +x 3proxy-uninstall.sh
sudo ./3proxy-install.sh

# curl -fsSL https://pkgs.netbird.io/install.sh | sh

# ssh-keygen -f "/home/msi/.ssh/known_hosts" -R "178.128.17.181"
