echo '#### Installing Docker'
echo '#################################################################'
if [[ $(which docker) && $(docker --version) && $(docker compose) ]]; then
   echo 'Docker installed, continue...'
else
echo 'Docker NOT installed, continue...'
sudo apt-get install gnome-terminal
modprobe kvm
modprobe kvm_intel  # Intel processors
modprobe kvm_amd    # AMD processors
kvm-ok
lsmod | grep kvm
ls -al /dev/kvm
sudo usermod -aG kvm $USER && sudo groupadd docker

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh

sudo groupadd docker
sudo gpasswd -a $USER docker
sudo systemctl restart docker
sudo usermod -aG docker $USER
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R

sudo systemctl restart docker
sudo systemctl enable --now docker.service docker.socket containerd.service
sudo systemctl daemon-reload

# wget https://desktop.docker.com/linux/main/amd64/145265/docker-desktop-4.29.0-amd64.deb
# sudo apt-get -y update
# sudo apt-get -y install ./docker-desktop-4.29.0-amd64.deb
# systemctl --user start docker-desktop
# systemctl --user enable docker-desktop
# sudo rm -rf ./docker-desktop-4.29.0-amd64.deb

gpg --generate-key
pass init E20DF443A91F888DEA37E4C05673AC218BE9491C
echo '#### Docker installed'
echo '#################################################################'
fi
