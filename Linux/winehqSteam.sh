sudo wget -O /etc/apt/trusted.gpg.d/winehq.key https://dl.winehq.org/wine-builds/winehq.key
sudo echo "Types: deb
URIs: https://dl.winehq.org/wine-builds/ubuntu
Suites: $(lsb_release -cs)
Components: main
Architectures: amd64 i386
Signed-By: /etc/apt/trusted.gpg.d/winehq.key" | \
  sudo tee /etc/apt/sources.list.d/winehq.sources > /dev/null

sudo apt-get update
sudo dpkg --add-architecture amd64
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get upgrade -y
# wine winecfg
sudo apt-get install -y \
  wine wine64 wine32 \
  libgl1-mesa-dri:amd64 libgl1-mesa-dri:i386 \
  librust-proton-call-dev proton-caller \
  libgl1-mesa-glx:amd64 libgl1-mesa-glx:i386
sudo apt-get install --install-recommends winehq-devel -y
sudo apt-get install --fix-broken -y
sudo apt-get install -y libgtk-3-dev
sudo apt-get install -y glslang-tools
sudo apt-get install -y \
  mingw-w64 mingw-w64-common mingw-w64-i686-dev mingw-w64-tools mingw-w64-x86-64-dev

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

sudo apt-get install -y dkms linux-headers-$(uname -r) \
  meson libsystemd-dev pkg-config ninja-build git \
  libdbus-1-dev libinih-dev build-essential

git clone https://github.com/FeralInteractive/gamemode.git
cd gamemode
git checkout 1.8.1 # omit to build the master branch
./bootstrap.sh
cd ~
gamemoded -t

git clone --recurse-submodules https://github.com/flightlessmango/MangoHud.git &&\
  cd MangoHud && \
  ./build.sh build && \
  ./build.sh package && \
  ./build.sh install

# wget -O ~/steam.deb http://media.steampowered.com/client/installer/steam.deb
wget https://repo.steampowered.com/steam/archive/precise/steam_latest.deb
sudo apt-get install -y ~/steam_latest.deb
gamemoderun mangohud steam
# echo $DISPLAY
# DISPLAY=:0 steam

# sudo nvidia-xconfig
# sudo nano /etc/X11/xorg.conf
# Добавьте эти строки в разделе «Устройство» между другими параметрами
# option "TripleBuffer" "true"
# option "Coolbits" "28"

# Добавьте эти строки в раздел «Экран» между другими опциями.
# option "metamodes" "nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
# option "AllowIndirectGLXProtocol" "false"
# sudo rm /etc/X11/xorg.conf

# Если gamemoderun не работает для вас, попробуйте использовать эту команду в качестве команды запуска:
# LD_PRELOAD=$LD_PRELOAD:/usr/lib/x86_64-linux-gnu/libgamemodeauto.so.0 %command%


# sudo apt-get remove --purge -y ^wine
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
# position=сверху-справа
# no_display
# toggle_hud=F11
# cpu_stats
# cpu_temp
# cpu_color=007AFA
# gpu_stats
# gpu_temp
# gpu_color=00БД00
# баран
# ram_color=B3000A
# Видеопамять
# vram_color=00801Б
# io_read
# io_write
# io_color=B84700
# арка
# engine_color=B200B0
# frame_timing=1
# frametime_color=00ff00
# #output_file=/главная/houtworm/mangohud_log_
# #fps_limit 120
# #media_player
# #toggle_logging=F10
