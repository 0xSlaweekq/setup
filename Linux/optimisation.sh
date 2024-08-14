#!/bin/bash
# curl -s 'https://liquorix.net/install-liquorix.sh' | sudo bash

sudo dpkg --configure -a
sudo apt install -y -f
sudo apt install --fix-broken -y
cat /proc/version

tee -a ~/bin/prime-run <<< \
'
#!/bin/bash
export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __VK_LAYER_NV_optimus=NVIDIA_only
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json
exec "$@"'
chmod +x ~/bin/prime-run
tee -a ~/.bashrc <<< 'alias primerun="~/bin/prime-run"'
source ~/.bashrc

# Install packages for gnome
# sudo apt install -y power-profiles-daemon
# powerprofilesctl set performance && powerprofilesctl list
# Install packages
sudo apt install -y gamemode cpufrequtils indicator-cpufreq tlp tlp-rdw

# Install auto-cpufreq
git clone https://github.com/AdnanHodzic/auto-cpufreq.git
cd auto-cpufreq && sudo ./auto-cpufreq-installer
sudo auto-cpufreq --install
# sudo systemctl mask power-profiles-daemon.service
sudo systemctl enable --now auto-cpufreq
sudo systemctl start auto-cpufreq
sudo systemctl status auto-cpufreq
sudo auto-cpufreq --update
cd ~ && rm -rf auto-cpufreq

# Install tlp
sudo systemctl enable --now tlp.service
sudo systemctl start tlp.service
sudo tlp start
echo 'GOVERNOR="performance"' | sudo tee /etc/default/cpufrequtils
sudo systemctl restart cpufrequtils

# Install Gamemode
git clone https://github.com/FeralInteractive/gamemode.git
cd gamemode
git checkout 1.8.1 # omit to build the master branch
./bootstrap.sh
cd ~ && rm -rf ./gamemode
systemctl --user enable gamemoded && systemctl --user start gamemoded
sudo chmod +x /usr/bin/gamemoderun
gamemoded -t
