echo 'Install NVM & nodejs & npm'
echo '#################################################################'
sudo apt -y install --reinstall nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
source ~/.bashrc
nvm --version
nvm install node
nvm ls-remote
nvm install v18.12.0
nvm install v14.15.1
nvm ls
nvm use v18.12.0
nvm alias default v18.12.0
sudo chown "$USER":"$USER" ~/.npm -R
sudo chown "$USER":"$USER" ~/.nvm -R
npm i -g \
  yarn prettier eslint solhint solidity-code-metrics \
  nodemon serve dotenv create-react-app solc
