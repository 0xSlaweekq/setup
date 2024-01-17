# cd ~ && \
# curl -O https://raw.githubusercontent.com/NarcoNik/setup/master/Linux/vpn/vpn-i.sh
# chmod +x vpn-i.sh
# sudo ./vpn-i.sh
# echo "First add new user"
# echo "echo '#################################################################'"
# echo "adduser msi
# sudo usermod -aG sudo msi
# su - msi"
# echo "echo '#################################################################'"
echo "Updating system"
echo '#################################################################'
sudo apt update
sudo apt -y upgrade
sudo apt -y --fix-broken install
sudo apt -y autoclean
sudo apt -y autoremove --purge
sudo apt -y install git nano resolvconf curl
echo "Installing wireguard"
echo '#################################################################'
cd ~
curl -O https://raw.githubusercontent.com/NarcoNik/wireguard-install/master/wireguard-install.sh
chmod +x wireguard-install.sh
sudo ./wireguard-install.sh
echo "Installing 3proxy"
echo '#################################################################'
cd ~
curl -O https://raw.githubusercontent.com/NarcoNik/setup/master/Linux/vpn/3proxy-i.sh
curl -O https://raw.githubusercontent.com/NarcoNik/setup/master/Linux/vpn/3proxy-uni.sh
chmod +x 3proxy-i.sh
chmod +x 3proxy-uni.sh
sudo ./3proxy-i.sh
