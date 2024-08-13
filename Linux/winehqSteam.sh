sudo wget -O /etc/apt/trusted.gpg.d/winehq.key https://dl.winehq.org/wine-builds/winehq.key
sudo echo "Types: deb
URIs: https://dl.winehq.org/wine-builds/ubuntu
Suites: $(lsb_release -cs)
Components: main
Architectures: amd64 i386
Signed-By: /etc/apt/trusted.gpg.d/winehq.key" | \
  sudo tee /etc/apt/sources.list.d/winehq.sources > /dev/null
sudo apt update
sudo apt upgrade

# sudo echo "deb [arch=amd64,i386 signed-by=/etc/apt/trusted.gpg.d/winehq.key] https://dl.winehq.org/wine-builds/ubuntu jammy main" |\
#   sudo tee /etc/apt/sources.list.d/winehq.list > /dev/null

sudo apt install -y libpoppler-glib8:{i386,amd64}=22.02.0-2ubuntu0.4
# wine winecfg
sudo apt install --install-recommends winehq-devel -y

sudo apt install -y \
  libgl1-mesa-dri:{i386,amd64} \
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


sudo apt install -y power-profiles-daemon gamemode cpufrequtils indicator-cpufreq tlp tlp-rdw
powerprofilesctl set performance && powerprofilesctl list

# Install auto-cpufreq
git clone https://github.com/AdnanHodzic/auto-cpufreq.git
cd auto-cpufreq && sudo ./auto-cpufreq-installer
sudo auto-cpufreq --install
# sudo systemctl mask power-profiles-daemon.service
sudo systemctl enable --now auto-cpufreq
sudo systemctl start auto-cpufreq
sudo systemctl status auto-cpufreq
sudo auto-cpufreq --update
cd ~

# Install tlp
sudo systemctl enable tlp.service
sudo tlp start
echo 'GOVERNOR="performance"' | sudo tee /etc/default/cpufrequtils
sudo systemctl restart cpufrequtils

# Install Gamemode
git clone https://github.com/FeralInteractive/gamemode.git
cd gamemode
git checkout 1.8.1 # omit to build the master branch
./bootstrap.sh
cd ~
rm -rf ./gamemode
systemctl --user enable gamemoded && systemctl --user start gamemoded
sudo chmod +x /usr/bin/gamemoderun
gamemoded -t


# wget -O ~/steam.deb http://media.steampowered.com/client/installer/steam.deb
wget https://repo.steampowered.com/steam/archive/precise/steam_latest.deb
sudo apt install -y ~/steam_latest.deb

# tee -a ~/bin/prime-run <<< \
# '
# #!/bin/bash
# export __NV_PRIME_RENDER_OFFLOAD=1
# export __GLX_VENDOR_LIBRARY_NAME=nvidia
# export __VK_LAYER_NV_optimus=NVIDIA_only
# export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json
# exec "$@"'
# chmod +x ~/bin/prime-run


sudo apt install -y software-properties-gtk
__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia # programName

gamemoderun %command% __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia



# sudo apt remove --purge -y ^wine
# for .msi files wine msiexec /i
# for .exe files wine *.exe

# mkdir -v ~/.wine-MyApp
# export WINEPREFIX=~/.wine-MyApp
# wine winecfg


# export WINEPREFIX=~/.wine-MyApp
# uninstall wine
# rm -r ~/.wine-MyApp


# config MangoHud
# background_alpha=0,3
# font_size=20
# background_color=020202
# text_color=ffffff
# position=top-right
# no_display
# toggle_hud=F11
# cpu_stats
# cpu_temp
# cpu_color=007AFA
# gpu_stats
# gpu_temp
# gpu_color=00BD00
# баран
# ram_color=B3000A
# Видеопамять
# vram_color=00801B
# io_read
# io_write
# io_color=B84700
# арка
# engine_color=B200B0
# frame_timing=1
# frametime_color=00ff00
# #output_file=~/houtworm/mangohud_log_
# #fps_limit 120
# #media_player
# #toggle_logging=F10
