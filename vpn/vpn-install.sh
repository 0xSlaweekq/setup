# cd ~ && \
# curl -O https://raw.githubusercontent.com/NarcoNik/setup/main/vpn/vpn-install.sh
# chmod +x vpn-install.sh
# sudo ./vpn-install.sh
# echo "First add new user"
# adduser msi
# sudo usermod -aG sudo msi
# su - msi
# sudo nano ~/.ssh/authorized_keys
# edit config
# sudo nano /etc/ssh/sshd_config
# PermitRootLogin no
# PubkeyAuthentication yes
# AuthorizedKeysFile      .ssh/authorized_keys .ssh/authorized_keys2
# PasswordAuthentication no
# PermitEmptyPasswords no ???
# sudo systemctl restart sshd

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
curl -O https://raw.githubusercontent.com/angristan/wireguard-install/master/wireguard-install.sh
chmod +x wireguard-install.sh
sudo ./wireguard-install.sh
# curl -O https://raw.githubusercontent.com/NarcoNik/setup/main/vpn/wig-install.sh
# chmod +x wig-install.sh
# sudo ./wig-install.sh
echo "Installing 3proxy"
echo '#################################################################'
cd ~
curl -O https://raw.githubusercontent.com/NarcoNik/setup/main/vpn/3proxy-install.sh
curl -O https://raw.githubusercontent.com/NarcoNik/setup/main/vpn/3proxy-uninstall.sh
chmod +x 3proxy-install.sh
chmod +x 3proxy-uninstall.sh
sudo ./3proxy-install.sh

# ssh-keygen -f "/home/msi/.ssh/known_hosts" -R "178.128.17.181"

# curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.noarmor.gpg | \
#   sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
# curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.tailscale-keyring.list | \
#   sudo tee /etc/apt/sources.list.d/tailscale.list

# sudo apt-get update
# sudo apt-get install tailscale
# sudo tailscale up
# tailscale ip -4

# 2C-4D-54-E9-02-BD
