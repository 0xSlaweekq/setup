sudo add-apt-repository -y ppa:apt-fast/stable
sudo apt-get update
sudo apt-get -y install apt-fast
/bin/bash -c "$(curl -sL https://git.io/vokNn)"

sudo apt-get -y install \
  cpufrequtils gamemode tlp tlp-rdw preload indicator-cpufreq \
  meson libsystemd-dev pkg-config ninja-build git libdbus-1-dev libinih-dev
sudo systemctl enable tlp.service
sudo tlp start

systemctl --user enable gamemoded
systemctl --user start gamemoded

sudo nvidia-xconfig
kate /etc/X11/xorg.conf
# Add in these lines under the "Device" section between the other options
Option         "TripleBuffer" "on"
Option         "Coolbits" "28"
# Add in these lines under the "Screen" section between the other options.
Option         "metamodes" "nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
Option         "AllowIndirectGLXProtocol" "off"

echo 'GOVERNOR="performance"' | sudo tee /etc/default/cpufrequtils
sudo systemctl restart cpufrequtils

cat /sys/block/sda/queue/scheduler
echo 'deadline' | sudo tee /sys/block/sda/queue/scheduler

cat /proc/sys/vm/swappiness
sudo sysctl vm.swappiness=10
cat /proc/sys/vm/vfs_cache_pressure
sudo sysctl vm.vfs_cache_pressure=50

sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1

sudo rmmod iwlwifi
sudo modprobe iwlwifi 11n_disable=1

sudo tee -a /etc/sysctl.conf <<< \
"
#disable ipv6
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
vm.swappiness=10
vm.vfs_cache_pressure=50"

sudo tee -a /etc/modprobe.d/ath9k.conf <<< "options ath9k nohwcrypt=1"

sudo tee -a /etc/modprobe.d/iwlwifi.conf <<< "options iwlwifi 11n_disable=1"

sudo iwconfig
sudo iwconfig wlo1 power off



# optional
git clone --recurse-submodules https://github.com/flightlessmango/MangoHud.git && \
  cd MangoHud && \
  ./build.sh build && \
  ./build.sh package && \
  ./build.sh install

kate ~/.config/MangoHud/MangoHud.conf
"
background_alpha=0.3
font_size=20
background_color=020202
text_color=ffffff
position=top-right
no_display
toggle_hud=F11
cpu_stats
cpu_temp
cpu_color=007AFA
gpu_stats
gpu_temp
gpu_color=00BD00
ram
ram_color=B3000A
vram
vram_color=00801B
io_read
io_write
io_color=B84700
arch
engine_color=B200B0
frame_timing=1
frametime_color=00ff00
#output_file=/home/houtworm/mangohud_log_
#fps_limit 120
#media_player
#toggle_logging=F10
"
