echo 'Installing Nvidia & other graphics drivers'
echo '#################################################################'
curl -fSsL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/3bf863cc.pub | \
  sudo gpg --dearmor | sudo tee /usr/share/keyrings/nvidia-drivers.gpg > /dev/null 2>&1
echo 'deb [signed-by=/usr/share/keyrings/nvidia-drivers.gpg] https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/ /' | \
  sudo tee /etc/apt/sources.list.d/nvidia-drivers.list

sudo add-apt-repository -y ppa:graphics-drivers/ppa
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get dist-upgrade
# sudo ubuntu-drivers devices
# sudo ubuntu-drivers autoinstall
sudo apt-get -y install \
  xserver-xorg-video-nouveau linux-headers-$(uname -r) gcc make acpid \
  ca-certificates  dirmngr software-properties-common apt-transport-https \
  curl dkms libglvnd-core-dev libglvnd0 libglvnd-dev libc-dev freeglut3-dev \
  libx11-dev libxmu-dev libxi-dev libglu1-mesa-dev libfreeimage-dev \
  libglfw3-dev
sudo apt-key del 7fa2af80
sudo apt-get -y install \
  nvidia-driver-550 nvidia-dkms-550 nvidia-headless-550 nvidia-settings \
  libvulkan1 libvulkan1:i386 mesa-vulkan-drivers vkbasalt \
  libglu1-mesa-dev freeglut3-dev mesa-common-dev libopenal1 \
  libopenal-dev libalut0 libalut-dev cuda-drivers

sudo apt-get -y install cuda-toolkit nvidia-gds

sudo systemctl enable nvidia-persistenced
sudo systemctl start nvidia-persistenced
sudo systemctl status nvidia-persistenced
cat /proc/driver/nvidia/version
sudo reboot
echo '#################################################################'




# wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-drivers_535.161.08-1_amd64.deb


# WINEDLLOVERRIDES="dinput8=n,b" env OBS_VKCAPTURE=1 %command%

# sudo add-apt-repository ppa:bumblebee/stable
# sudo apt-get update
# sudo apt-get -y install --no-install-recommends bumblebee

# Error running 32-bit applications on a 64-bit system
# apt-cache policy libgl1-mesa-glx:i386
# sudo apt-get install --reinstall bumblebee-nvidia
# sudo update-alternatives --config i386-linux-gnu_gl_conf
# sudo ldconfig

# nvidia-smi

# For remove all nvidia drivers
# sudo apt-get -y remove --purge nvidia-*
# sudo apt-get -y remove --purge libnvidia-*
# sudo rm /etc/X11/xorg.conf
# sudo rm /etc/modprobe.d/nvidia.conf
# sudo rm /etc/modprobe.d/blacklist-nvidia-nouveau.conf
# sudo rm /etc/systemd/system/nvidia-persistenced.service
# echo 'nouveau' | sudo tee -a /etc/modules
