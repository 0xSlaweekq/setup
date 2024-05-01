#!/bin/bash
# curl -s 'https://liquorix.net/install-liquorix.sh' | sudo bash

sudo dpkg --configure -a
sudo apt -y install -f
sudo apt --fix-broken install
cat /proc/version

sudo sed -i s/quiet\ splash/quiet\ splash\ intel_pstate=enable/g /etc/default/grub
sudo update-grub
supd

touch ~/.config/plasma-workspace/env/kwin.sh
chmod +x ~/.config/plasma-workspace/env/kwin.sh

echo "export __GL_THREADED_OPTIMIZATIONS=1" >> ~/.profile
echo "export _GL_SHADER_DISK_CACHE=1" >> ~/.profile
echo "export ENABLE_VKBASALT=1" >> ~/.profile
echo "export KWIN_TRIPLE_BUFFER=1" >> ~/.config/plasma-workspace/env/kwin.sh
echo "export __GL_YIELD=USLEEP" >> ~/.config/plasma-workspace/env/kwin.sh
echo "export __GL_MaxFramesAllowed=1" >> ~/.config/plasma-workspace/env/kwin.sh

sudo reboot

# dpkg --list | grep `uname -r`
# srp linux-headers-*.*.*-*-liquorix-* linux-image-*.*.*-*-liquorix-* \
#  linux-image-liquorix-* linux-headers-liquorix-* && supd



# # optional
# git clone --recurse-submodules https://github.com/flightlessmango/MangoHud.git && \
#   cd MangoHud && \
#   ./build.sh build && \
#   ./build.sh package && \
#   ./build.sh install

# kate ~/.config/MangoHud/MangoHud.conf
# "
# background_alpha=0.3
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
# ram
# ram_color=B3000A
# vram
# vram_color=00801B
# io_read
# io_write
# io_color=B84700
# arch
# engine_color=B200B0
# frame_timing=1
# frametime_color=00ff00
# #output_file=/home/houtworm/mangohud_log_
# #fps_limit 120
# #media_player
# #toggle_logging=F10
# "
