curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -sSL https://get.livekit.io/cli | bash

echo 'Installing PostgresQL'
echo '#################################################################'
sudo apt-get install -y postgresql
sudo apt-get install -y postgresql-common
sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh



echo 'Installing pgAdmin4'
echo '#################################################################'
sudo apt-get install -y postgresql-common
sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
#Install the public key for the repository (if not done previously):
curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | \
  sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/packages-pgadmin-org.gpg
#Create the repository configuration file:
sudo echo "deb [signed-by=/etc/apt/trusted.gpg.d/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" |\
  sudo tee /etc/apt/sources.list.d/pgadmin4.list > /dev/null
#Install for both desktop and web modes:
sudo apt-get install -y pgadmin4 pgadmin4-desktop pgadmin4-web
#Configure the webserver, if you installed pgadmin4-web:
sudo /usr/pgadmin4/bin/setup-web.sh



echo 'Installing foreman'
echo '#################################################################'
sudo apt-get -y install ca-certificates
cd /tmp && wget https://apt.puppet.com/puppet8-release-noble.deb
sudo apt-get install /tmp/puppet8-release-noble.deb
# Enable the Foreman repositories:
sudo wget https://deb.theforeman.org/foreman.asc -O /etc/apt/trusted.gpg.d/foreman.asc
sudo echo "deb http://deb.theforeman.org/ jammy 3.11
deb http://deb.theforeman.org/ plugins 3.11" |\
  sudo tee /etc/apt/sources.list.d/foreman.list > /dev/null
#Downloading the installer
sudo apt-get update
wget http://archive.ubuntu.com/ubuntu/pool/universe/r/ruby-highline/ruby-highline_2.0.3-2_all.deb
sudo apt-get install -y ./ruby-highline_2.0.3-2_all.deb --allow-downgrades
rm -rf ruby-highline_2.0.3-2_all.deb
sudo apt-get -y install foreman-installer
sudo hostnamectl set-hostname localhost
sudo foreman-installer
