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
rm -rf get-docker.sh
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin \
  docker-ce-rootless-extras docker-buildx-plugin
  # docker.io containerd runc docker-compose

PATH_TO_DOCKER=/home/"$USER"/.docker
sudo gpasswd -a $USER docker
sudo systemctl restart docker
sudo usermod -aG docker $USER
mkdir $PATH_TO_DOCKER
sudo chown "$USER":"$USER" $PATH_TO_DOCKER -R
sudo chmod g+rwx "$PATH_TO_DOCKER" -R

sudo systemctl restart docker
sudo systemctl enable --now \
  docker docker.service docker.socket containerd containerd.service
sudo systemctl daemon-reload
 systemctl status docker.service
echo '#### Docker installed'
echo '#################################################################'
fi

# $(lsb_release -cs)

# for pkg in docker docker.io docker-ce docker-ce-cli docker-doc docker-desktop docker-compose docker-compose-v2 docker-compose-plugin docker-ce-rootless-extras podman-docker containerd runc docker-buildx-plugin; do sudo apt remove --purge -y $pkg; done
# rm -rf ~/.docker
# sudo rm -rf /etc/apt/sources.list.d/docker.list
# sudo rm -rf /usr/local/bin/com.docker.cli
# sudo rm -rf /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-lunar.list
# sudo rm -rf /etc/apt/sources.list.d/docker.list
# sudo rm -rf /etc/apt/trusted.gpg.d/docker-archive-keyring.gpg
# sudo rm -rf /etc/apt/keyrings/docker.gpg
# sudo rm -rf /var/lib/docker
# sudo rm -rf /var/lib/containerd
# sudo rm -rf ~/.docker
# sudo rm -rf /usr/local/bin/com.docker.cli
# cd /bin
# sudo rm -rf containerd containerd-shim containerd-shim-runc-v2 ctr docker \
#   docker-init docker-proxy dockerd dockerd-rootless-setuptool.sh \
#   dockerd-rootless.sh rootlesskit rootlesskit-docker-proxy runc vpnkit
# cd -
