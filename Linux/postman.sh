https://dl-agent.pstmn.io/download/latest/linux
https://dl.pstmn.io/download/latest/linux_64

echo 'Installing Insomnia'
echo '#################################################################'
#Add to sources
curl -1sLf \
  'https://packages.konghq.com/public/insomnia/setup.deb.sh' |\
  sudo -E distro=ubuntu codename=noble bash
#Refresh repository sources and install Insomnia
#Update library'
sudo apt-get update
sudo apt-get install insomnia
#Install font configuration library & support
sudo apt-get install libfontconfig-dev



echo 'Installing Dbeaver'
echo '#################################################################'
wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
sudo apt-get install -y ./dbeaver-ce_latest_amd64.deb
rm -rf dbeaver-ce_latest_amd64.deb



echo 'Installing Postman'
echo '#################################################################'
npm i -g nestjs nx postman
curl -o- "https://dl-cli.pstmn.io/install/linux64.sh" | sh
sudo snap install postman

# wget https://dl.pstmn.io/download/latest/linux
# tar -xzf linux
# cd Postman
# ./Postman

# sudo nano ~/.bashrc
# export PATH="/home/user/Postman:$PATH"
# source ~/.bashrc
