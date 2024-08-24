echo 'Install NVM & nodejs & npm'
echo '#################################################################'
sudo apt install -y nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
source ~/.bashrc
nvm --version
nvm ls-remote
nvm install v20.13.1
nvm use v20.13.1
nvm alias default v20.13.1
sudo chown "$USER":"$USER" ~/.npm -R
sudo chown "$USER":"$USER" ~/.nvm -R
npm i -g \
  yarn prettier eslint solhint solidity-code-metrics nodemon serve \
  dotenv nx nestjs nest-cli nats solc create-react-app npm-check-updates

clear && nvm ls
