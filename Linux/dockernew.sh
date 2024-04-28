echo '#### Installing Docker'
echo '#################################################################'
if [[ $(which docker) && $(docker --version) && $(docker compose) ]]; then
   echo 'Docker installed, continue...'
else
echo 'Docker NOT installed, continue...'
for pkg in docker docker.io docker-ce docker-ce-cli docker-doc docker-desktop docker-compose docker-compose-v2 docker-compose-plugin docker-ce-rootless-extras podman-docker containerd runc docker-buildx-plugin; do sudo apt -y remove --purge $pkg; done
sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
rm -rf ~/.docker
sudo rm -rf /usr/local/bin/com.docker.cli
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd


sudo apt install gnome-terminal
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
sudo usermod -aG docker $USER
sudo gpasswd -a $USER docker
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R

sudo systemctl restart docker
sudo systemctl enable --now docker.service docker.socket containerd.service
sudo systemctl daemon-reload

# Verify that the Docker Engine installation is successful by running the hello-world image.
sudo docker run hello-world

wget https://desktop.docker.com/linux/main/amd64/145265/docker-desktop-4.29.0-amd64.deb
sudo apt-get -y update
sudo apt-get -y install ./docker-desktop-4.29.0-amd64.deb
systemctl --user start docker-desktop
systemctl --user enable docker-desktop
sudo rm -rf ./docker-desktop-4.29.0-amd64.deb

gpg --generate-key
pass init E20DF443A91F888DEA37E4C05673AC218BE9491C
# echo 'alias docker-compose="docker compose"' >> ~/.bashrc
# docker network create traefik-public
echo '#### Docker installed'
echo '#################################################################'
fi
