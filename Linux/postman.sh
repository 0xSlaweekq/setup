https://dl-agent.pstmn.io/download/latest/linux
https://dl.pstmn.io/download/latest/linux_64


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


sudo apt-get install -y postgresql-common
sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh

# Install the public key for the repository (if not done previously):
curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/packages-pgadmin-org.gpg

# Create the repository configuration file:
sudo echo "deb [signed-by=/etc/apt/trusted.gpg.d/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" |\
  sudo tee /etc/apt/sources.list.d/pgadmin4.list > /dev/null

# Install for both desktop and web modes:
sudo apt-get install -y pgadmin4 pgadmin4-desktop pgadmin4-web

# Configure the webserver, if you installed pgadmin4-web:
sudo /usr/pgadmin4/bin/setup-web.sh
