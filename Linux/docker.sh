echo '#### Installing Docker'
echo '#################################################################'
if [[ $(which docker) && $(docker --version) && $(docker compose) ]]; then
   echo 'Docker installed, continue...'
else
echo 'Docker NOT installed, continue...'
sudo apt install -y gnome-terminal
modprobe kvm
modprobe kvm_intel  # Intel processors
modprobe kvm_amd    # AMD processors
kvm-ok
lsmod | grep kvm
ls -al /dev/kvm
sudo usermod -aG kvm $USER && sudo groupadd docker
sudo apt clean

curl -fsSL https://get.docker.com -o get-docker.sh | sudo sh get-docker.sh
sudo apt install -y docker-buildx-plugin docker-compose-plugin
  # docker.io containerd runc docker-compose

sudo gpasswd -a $USER docker
sudo systemctl restart docker
sudo usermod -aG docker $USER
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R

sudo systemctl restart docker
sudo systemctl enable --now \
  docker docker.service docker.socket containerd containerd.service
sudo systemctl daemon-reload
 systemctl status docker.service
echo '#### Docker installed'
echo '#################################################################'
fi
