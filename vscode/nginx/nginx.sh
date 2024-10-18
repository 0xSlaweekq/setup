#!/bin/bash

sudo apt install -y \
  curl gnupg2 ca-certificates lsb-release ubuntu-keyring

curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor |\
  sudo tee /etc/apt/trusted.gpg.d/nginx.gpg >/dev/null

gpg --dry-run --quiet --no-keyring \
  --import --import-options import-show /etc/apt/trusted.gpg.d/nginx.gpg

echo "deb [signed-by=/etc/apt/trusted.gpg.d/nginx.gpg] \
http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" |\
  sudo tee /etc/apt/sources.list.d/nginx.list

sudo apt update
sudo apt install -y nginx


# for watch all process
# ps -ax | grep nginx
