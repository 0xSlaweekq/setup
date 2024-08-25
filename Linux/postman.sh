# https://dl-agent.pstmn.io/download/latest/linux
# https://dl.pstmn.io/download/latest/linux_64

cd ~
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -sSL https://get.livekit.io/cli | bash
curl -sf https://binaries.nats.dev/nats-io/natscli/nats@latest | sh


echo 'Installing Insomnia'
echo '#################################################################'
#Add to sources
curl -1sLf \
  'https://packages.konghq.com/public/insomnia/setup.deb.sh' |\
  sudo -E distro=ubuntu codename=focal bash
#Refresh repository sources and install Insomnia
#Update library'
sudo apt update
sudo apt install -y insomnia
#Install font configuration library & support
sudo apt install -y libfontconfig-dev



echo 'Installing Dbeaver'
echo '#################################################################'
wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
sudo apt install -y ./dbeaver-ce_latest_amd64.deb
rm dbeaver-ce_latest_amd64.deb



# echo 'Installing PostgresQL'
# echo '#################################################################'
# sudo apt install -y postgresql
# sudo apt install -y postgresql-common
# sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
# # for dump
# pg_dump -U postgres -h localhost -p 5432 test | gzip > db_dump.sql.gz



# echo 'Installing pgAdmin4'
# echo '#################################################################'
# #Install the public key for the repository (if not done previously):
# curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | \
#   sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/packages-pgadmin-org.gpg
# #Create the repository configuration file:
# sudo echo "deb [signed-by=/etc/apt/trusted.gpg.d/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" |\
#   sudo tee /etc/apt/sources.list.d/pgadmin4.list > /dev/null
# #Install for both desktop and web modes:
# sudo apt install -y pgadmin4 pgadmin4-desktop pgadmin4-web
# #Configure the webserver, if you installed pgadmin4-web:
# sudo /usr/pgadmin4/bin/setup-web.sh



# echo 'Installing Postman'
# echo '#################################################################'
# npm i -g nestjs nx postman
# curl -o- "https://dl-cli.pstmn.io/install/linux64.sh" | sh
# sudo snap install postman
# sudo snap remove postman

# wget https://dl.pstmn.io/download/latest/linux
# tar -xzf linux
# cd Postman
# ./Postman

# sudo nano ~/.bashrc
# export PATH="/home/user/Postman:$PATH"
# source ~/.bashrc
