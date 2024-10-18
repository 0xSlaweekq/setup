#!/bin/bash

echo Installing everything you need...
if [[ $(which docker) && $(docker --version) && $(docker compose) ]]; then
   echo Docker installed, continue...
else
echo Docker NOT installed, continue...
sudo apt autoremove $(dpkg -l *docker* |grep ii |awk '{print $2}') -y
sudo apt install -y ca-certificates curl gnupg lsb-release

curl -sSL https://get.docker.com | sh &&\
  sudo usermod -aG docker $(whoami) &&\
  sudo gpasswd -a $USER docker

sudo systemctl restart docker
sudo systemctl enable --now \
  docker docker.service docker.socket containerd containerd.service
sudo systemctl daemon-reload
systemctl status docker.service

echo '#### Docker installed'
echo '#################################################################'
fi

docker network create traefik-public
wget https://raw.githubusercontent.com/0xSlaweekq/setup/main/vscode/docker-compose.yml

echo Enter the desired domain in the format of \"test.com\":
read -a domain

# for elem in ${domains[@]}; do
#    TRAEFIK_DOMAIN+=" \`$elem\`,"
#    NGINX_DOMAIN+=" $elem"
# done

echo $TRAEFIK_DOMAIN
sudo sed -i "s/Host([^)]*)/Host(\`${domain[@]}\`)/g" docker-compose.yml
sudo sed -i "s/NGINX_HOST=[^)]*/NGINX_HOST=${domain[@]}/g" docker-compose.yml

IP=$(curl api.ipify.org)
echo Done! Create an A-type entry in your domain control panel, targeting $IP

# start bash -i ./start.sh
# alias defpass="echo 'YOUR_DOCKER_PASS"
# alias doccon="docker login -u YOUR_DOCKER_USER_NAME --password-stdin"
# defpass | doccon
docker compose -p slaweekq stop || true
docker compose -p slaweekq down -v && docker compose -f ./docker-compose.* rm -sfv
# docker rmi $(docker images -q --no-trunc) || true
docker compose -f ./docker-compose.* -p slaweekq up -d

echo "Server started"
