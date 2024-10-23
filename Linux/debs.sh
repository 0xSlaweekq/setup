#!/bin/bash

# Download the packages file
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B05498B7
wget https://github.com/jgraph/drawio-desktop/releases/download/v24.5.3/drawio-amd64-24.5.3.deb
wget https://github.com/hiddify/hiddify-next/releases/download/v2.5.7/Hiddify-Debian-x64.deb
wget https://github.com/MatsuriDayo/nekoray/releases/download/4.0-beta4/nekoray-4.0-beta4-2024-10-09-debian-x64.deb

# wget https://download.anydesk.com/linux/anydesk_6.1.1-1_amd64.deb

# Install packages
sudo apt install -y ./drawio-amd64-24.5.3.deb
sudo apt install --fix-broken -y
sudo apt install -y -f
sudo systemctl daemon-reload
# Remove packages
sudo rm -rf drawio-amd64-24.5.3.deb


wget https://github.com/hiddify/hiddify-next/releases/download/v2.5.7/Hiddify-Debian-x64.deb
sudo apt install -y ./Hiddify-Debian-x64.deb
sudo apt install --fix-broken -y
sudo apt install -y -f
sudo systemctl daemon-reload
sudo rm -rf Hiddify-Debian-x64.deb
