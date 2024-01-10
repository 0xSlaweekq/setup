#### Mount disks
echo '#################################################################'
sudo fdisk -l
sudo findmnt --verify --verbose
lsblk -f

sudo chown -R $USER PATH/*

kate /etc/fstab
sudo bash -c \
"cat << EOF > /etc/fstab
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# UUID=<uuid>                             <mount point> <FSType> <FSOptions>                           <dump> <pass>
UUID=438d8a6e-4d8a-4a00-a1b7-b86dda61d45c /               ext4   defaults                                0      1
UUID=C5F3-F560                            /boot/efi       vfat   defaults                                0      1
UUID=DC081FAE081F86A4                     /mnt/Disk_D     ntfs   defaults,rw,uid=1000,gid=1000,realtime  0      0
/swap.img                                 none            swap   sw                                      0      0
/swapfile                                 none            swap   sw                                      0      0
EOF"
echo '#################################################################'

echo '#### Swap install'
echo '#################################################################'
sudo swapon --show
free -h
df -h
sudo fallocate -l 32G /swapfile
sudo chmod 600 /swapfile
ls -lh /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile                                 none            swap   sw                   0      0' | sudo tee -a /etc/fstab
cat /proc/sys/vm/swappiness
sudo sysctl vm.swappiness=10
cat /proc/sys/vm/vfs_cache_pressure
sudo sysctl vm.vfs_cache_pressure=50
sudo tee -a /etc/sysctl.conf <<< \
"vm.swappiness=10
vm.vfs_cache_pressure=50"
echo '#################################################################'

echo '#### Grub2 install'
echo '#################################################################'
sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer && \
  sudo apt update && \
  sudo apt -y install grub-customizer && \
  sudo grub-customizer

for pkg in grub-common grub-customizer grub-efi grub-efi-amd64-bin grub-efi-amd64-signed grub-gfxpayload-lists grub-pc grub-pc-bin grub2-common; do sudo apt -y remove --purge $pkg; done

sudo apt -y install grub-customizer grub-efi efibootmgr

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
sudo grub-install /dev/nvme1n1p1
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo update-grub --output=/boot/grub/grub.cfg
sudo grub-install /dev/nvme1n1
kate /boot/grub/grub.cfg

sudo apt-add-repository -y ppa:yannubuntu/boot-repair && \
  sudo apt update && sudo apt -y install boot-repair && sudo boot-repair

sudo dpkg --configure -a
sudo apt install -fy
sudo apt -y purge --allow-remove-essential grub-com*
sudo apt -y purge --allow-remove-essential grub2-com*
sudo apt -y purge --allow-remove-essential shim-signed
sudo apt -y purge --allow-remove-essential grub-common:*
sudo apt -y purge --allow-remove-essential grub2-common:*

sudo apt update && sudo apt -y install ubuntu-desktop xorg dbus-x11 \
  xfce4 xfce4-goodies x11-xserver-utils

sudo apt update && sudo apt -y upgrade && \
  sudo add-apt-repository ppa:kubuntu-ppa/backports -y && \
  sudo apt update && sudo apt -y install kde-plasma-desktop

cat /etc/sddm.conf
echo -e "[General]\nInputMethod=" | sudo tee -a /etc/sddm.conf
echo '#################################################################'

echo '#### Mac'
echo '#################################################################'
sudo mount -t fat32 -o rw,realtime /dev/sda2 /mnt/MacOS
sudo mount -o rw UUID=2023-05-31-19-32-03-00 /mnt/MacOS

sudo add-apt-repository universe && \
  sudo apt update && \
  sudo apt -y install dmg2img && \
  dmg2img -v -i /path/to/image_file.dmg -o /path/to/image_file.iso

sudo dd if=/path/to/image_file.iso of=/dev/sdd

dd if=image.dmg of=/dev/sdb bs=16M status=progress

sudo dd if=/mnt/Documents/Ventura.iso of=/dev/nvme0n1p2
for windows dd if=\\.\d:\Ventura.iso of=\\.\p:
echo '#################################################################'
