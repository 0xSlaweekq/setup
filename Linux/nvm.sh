echo 'Install NVM & nodejs & npm'
echo '#################################################################'
sudo apt install -y nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
source ~/.bashrc
nvm --version
nvm ls-remote
VERSION=20.13.1
nvm install $VERSION
nvm use $VERSION
nvm alias default $VERSION
sudo chown "$USER":"$USER" ~/.npm -R
sudo chown "$USER":"$USER" ~/.nvm -R
npm i -g \
  yarn prettier eslint solhint solidity-code-metrics nodemon serve \
  dotenv nx nestjs nest-cli nats solc create-react-app npm-check-updates
clear && nvm ls
