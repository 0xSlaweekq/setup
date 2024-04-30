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
# UUID=<uuid>                             <mount point> <FSType> <FSOptions>        <dump> <pass>
UUID=0738b3b8-69e2-4115-ad75-3399eea21c57 /               ext4   errors=remount-ro    0      1
UUID=5839-82E3                            /boot/efi       vfat   umask=0077           0      1
UUID=7f8f1cbd-414c-4669-88c0-144ba99c413e /home           ext4   defaults             0      2
UUID=8e674e9f-72ce-4a1e-810e-ca5972b7fa11 none            swap   sw                   0      0
UUID=858188bb-d3a3-4840-b60d-d71e647aa66b /mnt/Documents  ext4   defaults,rw,realtime 0      2
EOF"

echo '#################################################################'

echo '#### Swap install'
echo '#################################################################'
sudo swapon --show
free -h
df -h
sudo swapoff -a
sudo fallocate -l 32G /swap.img
sudo chmod 600 /swap.img
ls -lh /swap.img
sudo mkswap /swap.img
sudo swapon /swap.img
sudo cp /etc/fstab /etc/fstab.bak
echo '/swap.img                                 swap            swap   defaults             0      0' | \
  sudo tee -a /etc/fstab
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

sudo dd if=/mnt/Disk_D/Ventura.iso of=/dev/nvme0n1p2
for windows dd if=\\.\d:\Ventura.iso of=\\.\p:
echo '#################################################################'
