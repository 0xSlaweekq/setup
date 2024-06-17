# Download the packages file
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B05498B7
wget https://github.com/jgraph/drawio-desktop/releases/download/v24.5.3/drawio-amd64-24.5.3.deb

# wget https://download.anydesk.com/linux/anydesk_6.1.1-1_amd64.deb
# wget https://github.com/lutris/lutris/releases/download/v0.5.14/lutris_0.5.14_all.deb

# Install packages
sudo apt-get install -y ./drawio-amd64-24.5.3.deb
sudo apt-get install --fix-broken -y
sudo apt-get install -y -f
sudo systemctl daemon-reload
# Remove packages
sudo rm -rf drawio-amd64-24.5.3.deb
