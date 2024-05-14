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
# UUID=<uuid>                             <mount point> <FSType> <FSOptions> <dump> <pass>
UUID=cd76ed22-18dd-4363-b60c-79cc236d304c /               ext4   defaults       0      1
UUID=ebc2563f-71b3-4c61-969c-41b619686d9f /home           ext4   defaults       0      1
UUID=F304-F91F                            /boot/efi       vfat   defaults       0      1
UUID=74db52a4-772f-4b99-8716-807fe4ac2072 none            swap   sw             0      0
UUID=858188bb-d3a3-4840-b60d-d71e647aa66b /mnt/Documents  ext4   defaults       0      1
EOF"

echo '#################################################################'

echo '#### Swap install'
echo '#################################################################'
sudo swapon --show
free -h
df -h
sudo swapoff -a
sudo mkswap /dev/nvme0n1p4
sudo swapon /dev/nvme0n1p4
sudo cp /etc/fstab /etc/fstab.bak
echo '/dev/nvme0n1p4                              swap            swap   defaults             0      2' | \
  sudo tee -a /etc/fstab
cat /proc/sys/vm/swappiness
sudo sysctl vm.swappiness=10
cat /proc/sys/vm/vfs_cache_pressure
sudo sysctl vm.vfs_cache_pressure=50
sudo tee -a /etc/sysctl.conf <<< \
"
vm.swappiness=10
vm.vfs_cache_pressure=50"
echo '#################################################################'

echo '#### Grub2 install'
echo '#################################################################'
sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer && \
  sudo apt-get update && \
  sudo apt-get -y install grub-customizer && \
  sudo grub-customizer

for pkg in grub-common grub-customizer grub-efi grub-efi-amd64-bin grub-efi-amd64-signed grub-gfxpayload-lists grub-pc grub-pc-bin grub2-common; do sudo apt-get -y remove --purge $pkg; done

sudo apt-get -y install grub-customizer grub-efi efibootmgr

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
sudo grub-install /dev/nvme1n1p1
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo update-grub --output=/boot/grub/grub.cfg
sudo grub-install /dev/nvme1n1
kate /boot/grub/grub.cfg

sudo apt-add-repository -y ppa:yannubuntu/boot-repair && \
  sudo apt-get update && sudo apt-get -y install boot-repair && sudo boot-repair

sudo dpkg --configure -a
sudo apt-get install -fy
sudo apt-get -y purge --allow-remove-essential grub-com*
sudo apt-get -y purge --allow-remove-essential grub2-com*
sudo apt-get -y purge --allow-remove-essential shim-signed
sudo apt-get -y purge --allow-remove-essential grub-common:*
sudo apt-get -y purge --allow-remove-essential grub2-common:*

sudo apt-get update && sudo apt-get -y install ubuntu-desktop xorg dbus-x11 \
  xfce4 xfce4-goodies x11-xserver-utils

sudo apt-get update && sudo apt-get -y upgrade && \
  sudo add-apt-repository ppa:kubuntu-ppa/backports -y && \
  sudo apt-get update && sudo apt-get -y install kde-plasma-desktop

cat /etc/sddm.conf
echo -e "[General]\nInputMethod=" | sudo tee -a /etc/sddm.conf
echo '#################################################################'

echo '#### Mac'
echo '#################################################################'
sudo mount -t fat32 -o rw,realtime /dev/sda2 /mnt/MacOS
sudo mount -o rw UUID=2023-05-31-19-32-03-00 /mnt/MacOS

sudo add-apt-repository universe && \
  sudo apt-get update && \
  sudo apt-get -y install dmg2img && \
  dmg2img -v -i /path/to/image_file.dmg -o /path/to/image_file.iso

sudo dd if=/path/to/image_file.iso of=/dev/sdd

dd if=image.dmg of=/dev/sdb bs=16M status=progress

sudo dd if=/mnt/Disk_D/Ventura.iso of=/dev/nvme0n1p2
for windows dd if=\\.\d:\Ventura.iso of=\\.\p:
echo '#################################################################'
