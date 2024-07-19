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
sudo apt-get install -y xserver-xorg-video-all \
  xserver-xorg-video-intel xserver-xorg-video-nvidia-555
sudo apt-get install -y \
  linux-headers-$(uname -r) clang gcc make acpid \
  ca-certificates dirmngr software-properties-common apt-transport-https \
  curl dkms libglvnd-core-dev libglvnd0 libglvnd-dev libc-dev freeglut3-dev \
  libx11-dev libxmu-dev libxi-dev libglu1-mesa-dev libfreeimage-dev \
  libglfw3-dev
sudo apt-key del 7fa2af80
sudo apt-get install -y \
  nvidia-headless-555 nvidia-dkms-555 nvidia-driver-555 nvidia-settings \
  libvulkan1:{i386,amd64} mesa-vulkan-drivers:{i386,amd64} \
  vkbasalt libglu1-mesa-dev:{i386,amd64} freeglut3-dev mesa-common-dev libopenal1 \
  libopenal-dev libalut0 libalut-dev
sudo ubuntu-drivers install nvidia-headless-555 nvidia-dkms-555 nvidia-driver-555

apt list cuda-toolkit-* | grep -v config
sudo apt-get install -y cuda-drivers cuda-toolkit nvidia-gds
/usr/local/cuda/bin/nvcc --version

sudo systemctl enable nvidia-persistenced
sudo systemctl start nvidia-persistenced
sudo systemctl status nvidia-persistenced
cat /proc/driver/nvidia/version
sudo reboot
echo '#################################################################'


si uncom-nvidia-driver

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


# Very huge font in LightDM after installed nVidia driver
# 1. Check the default config of xserver-command
# cat /usr/share/lightdm/lightdm.conf.d/50-xserver-command.conf | grep "xserver-command"
# xserver-command=X -core
# 2. Copy above line to the custom config file. Append "-dpi 96" to the end of the line
# nano /etc/lightdm/lightdm.conf.d/20-lubuntu.conf
# [SeatDefaults]
# user-session=Kubuntu
# xserver-command=X -core -dpi 96

# Unable to start Steam
# 1. ia32-libs is NOT required for x86_64.
# 2. Locale was not exported. Try to run steam by: LC_ALL=C steam

# Unable to run XBMC after using nVidia Propietary driver
# Link libGL.so to nVidia's version:
#     cd /usr/lib/x86_64-linux-gnu/mesa
#     rm libGL.so.1
#     ln -s /usr/lib/libGL.so libGL.so.1




# WINEDLLOVERRIDES="dinput8=n,b" env OBS_VKCAPTURE=1 %command%

# sudo add-apt-repository ppa:bumblebee/stable
# sudo apt-get update
# sudo apt-get install -y --no-install-recommends bumblebee

# Error running 32-bit applications on a 64-bit system
# apt-cache policy libgl1-mesa-glx:i386
# sudo apt-get install -y --reinstall bumblebee-nvidia
# sudo update-alternatives --config i386-linux-gnu_gl_conf
# sudo ldconfig

# nvidia-smi

# For remove all nvidia drivers
# sudo apt-get remove --purge -y nvidia-*
# sudo apt-get remove --purge -y libnvidia-*
# sudo rm /etc/X11/xorg.conf
# sudo rm /etc/modprobe.d/nvidia.conf
# sudo rm /etc/modprobe.d/blacklist-nvidia-nouveau.conf
# sudo rm /etc/systemd/system/nvidia-persistenced.service
# echo 'nouveau' | sudo tee -a /etc/modules
