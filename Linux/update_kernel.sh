sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install --fix-broken -y
sudo apt-get autoclean -y
sudo apt-get autoremove --purge

#### update kernel
echo '#################################################################'
sudo uname -mrs
sudo add-apt-repository-y ppa:cappelikan/ppa
sudo apt-get install -y mainline
echo 'press ALT+F2 and paste Ubuntu Mainline Kernel Installer'
sudo update-grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo reboot

sudo uname -a
sudo apt-get list --installed | egrep "linux-image|linux-headers"
# sudo dpkg --list | egrep "linux-image|linux-headers"
# sudo apt-get purge linux-image-4.15.0-66-generic linux-headers-4.15.0-91-generic

sudo apt-get update && \
  sudo apt-get search linux-image-*| more && \
  sudo apt-get search linux-image-5.19.0-28*

sudo apt-get install -y linux-headers-5.19.0-28-generic
sudo apt-get install -y linux-modules-5.19.0-28-generic
sudo apt-get install -y linux-image-5.19.0-28-generic
sudo apt-get install -y linux-modules-extra-5.19.0-28-generic

dpkg --list | grep linux-image

sudo reboot
uname -r

sudo apt-get remove --purge -y linux-image-5.15.0-43-generic
echo '#################################################################'
