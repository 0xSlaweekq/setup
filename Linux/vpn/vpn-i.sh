# cd ~ && \
#   curl -O https://raw.githubusercontent.com/NarcoNik/setup/main/Linux/vpn/install-vpn.sh && \
#   chmod +x install-vpn.sh && \
#   sudo ./install-vpn.sh
# echo "First add new user"
# echo "echo '#################################################################'"
# echo "adduser msi
# sudo usermod -aG sudo msi
# su - msi"
# echo "echo '#################################################################'"
echo "Updating system"
echo '#################################################################'
echo cdfecdfe | sudo -S sudo apt update && \
  sudo apt -y upgrade && \
  sudo apt -y --fix-broken install && \
  sudo apt -y autoclean && \
  sudo apt -y autoremove --purge && \
  sudo apt -y install git nano resolvconf curl
echo "Installing wireguard"
echo '#################################################################'
cd ~
curl -O https://raw.githubusercontent.com/NarcoNik/wireguard-install/master/wireguard-install.sh
# curl -O https://raw.githubusercontent.com/NarcoNik/setup/main/Linux/vpn/wireguard-install.sh
chmod +x wireguard-install.sh
sudo ./wireguard-install.sh
echo "Installing 3proxy"
echo '#################################################################'
cd ~
curl -O https://raw.githubusercontent.com/NarcoNik/setup/master/Linux/vpn/proxy3-install.sh
curl -O https://raw.githubusercontent.com/NarcoNik/setup/master/Linux/vpn/proxy3-uninstall.sh
chmod +x proxy3-install.sh
chmod +x proxy3-uninstall.sh
sudo ./proxy3-install.sh
