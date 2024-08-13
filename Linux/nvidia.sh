echo 'Installing Nvidia & other graphics drivers'
echo '#################################################################'
curl -fSsL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/3bf863cc.pub | \
  sudo gpg --dearmor | sudo tee /usr/share/keyrings/nvidia-drivers.gpg > /dev/null 2>&1
echo "deb [arch=i386,amd64 signed-by=/usr/share/keyrings/nvidia-drivers.gpg] https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/ /" | \
  sudo tee /etc/apt/sources.list.d/nvidia-drivers.list

sudo add-apt-repository -y ppa:graphics-drivers/ppa
sudo dpkg --add-architecture i386
sudo apt update
sudo apt dist-upgrade
sudo apt install software-properties-qt # for gnome software-properties-gtk
sudo apt install -y xserver-xorg-video-all \
  xserver-xorg-video-intel xserver-xorg-video-nvidia-560
sudo apt install -y \
  linux-headers-$(uname -r) clang gcc make acpid \
  ca-certificates dirmngr software-properties-common apt-transport-https \
  curl dkms libglvnd-core-dev libglvnd0 libglvnd-dev libc-dev freeglut3-dev \
  libx11-dev libxmu-dev libxi-dev libglu1-mesa-dev libfreeimage-dev \
  libglfw3-dev
sudo apt-key del 7fa2af80
sudo apt install -y nvidia-driver-560 nvidia-headless-560 nvidia-dkms-560 \
  nvidia-settings nvidia-prime

sudo apt install -y \
  libvulkan1:{i386,amd64} mesa-vulkan-drivers:{i386,amd64} \
  vkbasalt libglu1-mesa-dev:{i386,amd64} freeglut3-dev mesa-common-dev \
  libopenal1 libopenal-dev libalut0 libalut-dev

sudo ubuntu-drivers install nvidia-headless-560:{i386,amd64} \
  nvidia-dkms-560:{i386,amd64} nvidia-driver-560:{i386,amd64}

apt list cuda-toolkit-* | grep -v config
sudo apt install -y cuda-drivers cuda-toolkit nvidia-gds
/usr/local/cuda/bin/nvcc --version

sudo systemctl enable nvidia-persistenced
sudo systemctl start nvidia-persistenced
sudo systemctl status nvidia-persistenced
cat /proc/driver/nvidia/version

sudo bash -c "echo blacklist nouveau > /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
sudo bash -c "echo options nouveau modeset=0 >> /etc/modprobe.d/blacklist-nvidia-nouveau.conf"

sudo prime-select on-demand # nvidia|intel|on-demand|query
sudo nvidia-xconfig --prime
sh -c "xrandr --setprovideroutputsource modesetting NVIDIA-0; xrandr --auto"
sudo mv /etc/X11/xorg.conf /etc/X11/xorg.conf-external-display
# Update grub2 conf
sudo update-grub2

# Update initramfs
sudo update-initramfs -u

sudo reboot
echo '#################################################################'



# cd ~
# wget https://download.nvidia.com/XFree86/Linux-x86_64/555.52.04/NVIDIA-Linux-x86_64-555.52.04.run
# chmod 700 NVIDIA-*.run
# sudo telinit 3
# dpkg --purge nvidia-*
# sudo apt remove --purge nvidia-*
# sudo ./NVIDIA-Linux-x86_64-555.52.04.run
# nvidia-xconfig # optionaly
# sudo telinit 5
# systemctl restart graphical.target

# WINEDLLOVERRIDES="dinput8=n,b" env OBS_VKCAPTURE=1 %command%

# sudo add-apt-repository ppa:bumblebee/stable
# sudo apt update
# sudo apt install -y --no-install-recommends bumblebee

# Error running 32-bit applications on a 64-bit system
# apt-cache policy libgl1-mesa-glx:i386
# sudo apt install -y --reinstall bumblebee-nvidia
# sudo update-alternatives --config i386-linux-gnu_gl_conf
# sudo ldconfig

# For remove all nvidia drivers
# sudo apt remove --purge -y nvidia-*
# sudo apt remove --purge -y libnvidia-*
# sudo rm /etc/X11/xorg.conf
# sudo rm /etc/X11/xorg.conf-external-display
# sudo rm /etc/modprobe.d/nvidia.conf
# sudo rm /etc/modprobe.d/blacklist-nvidia-nouveau.conf
# sudo rm /etc/systemd/system/nvidia-persistenced.service
# echo 'nouveau' | sudo tee -a /etc/modules
