echo 'Install NVM & nodejs & npm'
echo '#################################################################'
sudo apt install -y nodejs
# installs nvm (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
source ~/.bashrc
nvm --version
nvm ls-remote
# download and install Node.js (you may need to restart the terminal)
nvm install 20
nvm use 20
nvm alias default 20
# verifies the right Node.js version is in the environment
node -v # should print `v20.17.0`
# verifies the right npm version is in the environment
npm -v # should print `10.8.2`

sudo chown "$USER":"$USER" ~/.npm -R
sudo chown "$USER":"$USER" ~/.nvm -R
sudo chown "$USER":"$USER" /usr/local -R
npm i -g \
  yarn prettier eslint solhint solidity-code-metrics nodemon serve \
  dotenv nx nestjs nest-cli nats solc create-react-app npm-check-updates
clear && nvm ls
