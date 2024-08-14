# sudo wget -O /etc/apt/trusted.gpg.d/winehq.key https://dl.winehq.org/wine-builds/winehq.key
# sudo echo "Types: deb
# URIs: https://dl.winehq.org/wine-builds/ubuntu
# Suites: $(lsb_release -cs)
# Components: main
# Architectures: amd64 i386
# Signed-By: /etc/apt/trusted.gpg.d/winehq.key" | \
#   sudo tee /etc/apt/sources.list.d/winehq.sources > /dev/null

sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/noble/winehq-noble.sources
sudo apt update
sudo apt upgrade

# sudo echo "deb [arch=amd64,i386 signed-by=/etc/apt/trusted.gpg.d/winehq.key] https://dl.winehq.org/wine-builds/ubuntu jammy main" |\
#   sudo tee /etc/apt/sources.list.d/winehq.list > /dev/null

sudo apt install -y libpoppler-glib8:{i386,amd64}=22.02.0-2ubuntu0.4
# wine winecfg
sudo apt install --install-recommends winehq-devel -y

sudo apt install -y \
  librust-proton-call-dev proton-caller \
  libgl1-mesa-glx:{i386,amd64}
sudo apt install --fix-broken -y

git clone --recursive https://github.com/HansKristian-Work/vkd3d-proton
cd vkd3d-proton
chmod +x ./package-release.sh
mkdir -p ~/vkd3d
sudo ./package-release.sh master ~/vkd3d --no-package
cd ~
sudo rm -rf vkd3d-proton

# change to build.86 for 32-bit
sudo chmod +x ~/vkd3d/vkd3d-proton-master/setup_vkd3d_proton.sh
~/vkd3d/vkd3d-proton-master/setup_vkd3d_proton.sh install

# wget -O ~/steam.deb http://media.steampowered.com/client/installer/steam.deb
wget https://repo.steampowered.com/steam/archive/precise/steam_latest.deb
sudo apt install -y ~/steam_latest.deb
sudo rm -rf ~/steam_latest.deb

# primerun %command% +linux
# mangohud gamemoderun __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only %command% +linux

# sudo apt remove --purge -y ^wine
# for .msi files wine msiexec /i
# for .exe files wine *.exe

# mkdir -v ~/.wine-MyApp
# export WINEPREFIX=~/.wine-MyApp
# wine winecfg


# export WINEPREFIX=~/.wine-MyApp
# uninstall wine
# rm -r ~/.wine-MyApp
