echo 'Install NVM & nodejs & npm'
echo '#################################################################'
sudo apt install -y nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
source ~/.bashrc
nvm --version
nvm ls-remote
nvm install 20
nvm use 20
nvm alias default 20
node -v # should print `v20.17.0`
npm -v # should print `10.8.2`

sudo chown "$USER":"$USER" ~/.npm -R
sudo chown "$USER":"$USER" ~/.nvm -R
sudo chown "$USER":"$USER" /usr/local -R
npm i -g \
  yarn prettier eslint solhint solidity-code-metrics nodemon serve \
  dotenv nx nestjs nest-cli nats solc create-react-app npm-check-updates
clear && nvm ls
