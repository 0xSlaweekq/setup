#!/bin/bash

# echo 'Install nodejs & npm'
# echo '#################################################################'
# curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -
# sudo apt update
# sudo apt install -y nodejs
# export PATH="$PATH:$HOME/.npm/bin"
# source ~/.bashrc
# npm i -g npm@10.5.2 \
#   yarn prettier eslint solhint solidity-code-metrics nodemon serve \
#   dotenv nx nestjs nest-cli nats solc create-react-app npm-check-updates \
#   @nestjs/cli

echo "Install NVM & npm"
echo '#################################################################'
cd ~
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm ls-remote
VERSION=20.13.1
nvm install $VERSION
nvm use $VERSION
nvm alias default $VERSION
sudo chown -R "$USER":"$USER" ~/.npm
sudo chown -R "$USER":"$USER" ~/.nvm
npm i -g npm@10.5.2 \
  yarn prettier eslint solhint solidity-code-metrics nodemon serve \
  dotenv nx nestjs nest-cli nats solc create-react-app npm-check-updates \
  @nestjs/cli pm2@latest
clear && nvm ls

echo '#################################################################'
echo "NVM & npm installed"
echo '#################################################################'
