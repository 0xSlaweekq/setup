#!/bin/bash

# https://ohmyposh.dev/docs/installation/fonts
sudo mkdir /usr/local/bin/oh-my-posh
curl -s https://ohmyposh.dev/install.sh | sudo bash -s -- -d /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
tee -a ~/.bashrc <<< 'export PATH=$PATH:/usr/local/bin/oh-my-posh'

# "terminal.integrated.fontFamily": "FiraCode Nerd Font Mono"
cp /mnt/D/CRYPTO/setup/Linux/jandedobbeleer.omp.json ~/jandedobbeleer.omp.json
eval "$(oh-my-posh init bash --config ~/jandedobbeleer.omp.json)"
oh-my-posh print primary --config ~/jandedobbeleer.omp.json --shell uni
source ~/.bashrc

oh-my-posh config export --output ~/.mytheme.omp.json


--config 'C:/Users/Posh/jandedobbeleer.omp.json'
--config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/jandedobbeleer.omp.json'
