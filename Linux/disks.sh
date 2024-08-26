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
# Use 'blkid' to print the universally unique identifier for a device; this may
# be used with UUID= as a more robust way to name devices that works even if
# disks are added and removed. See fstab(5).
#
# UUID=<uuid>                             <mount point> <FSType> <FSOptions>              <dump> <pass>
UUID=50D8DE4A70913ADC                     /mnt/D          ntfs   defaults                   0      2
UUID=9C1DA856CE5BF3A4                     /mnt/backup     ntfs   defaults                   0      2
UUID=BEB0-7BCA                            /boot/efi       vfat   defaults                   0      2
UUID=e516ffbf-b908-40dc-b742-c70d9aa4a08b /               ext4   defaults                   0      1
UUID=8320fc3a-f336-4114-9496-7067e51d702c /home           ext4   defaults                   0      2
UUID=4d7be934-770c-4183-9b60-4db257f4a110 swap            swap   defaults                   0      0
/swapfile                                 swap            swap   defaults                   0      0
tmpfs                                     /tmp            tmpfs  defaults,noatime,mode=1777 0      0
EOF"

echo '#################################################################'

echo '#### Swap install'
echo '#################################################################'
sudo swapon --show
free -h
df -h
sudo swapoff -a
sudo umount /dev/nvme0n1p4
sudo mkswap /dev/nvme0n1p4
sudo swapon /dev/nvme0n1p4
sudo cp /etc/fstab /etc/fstab.bak
echo '/dev/nvme0n1p4                            swap            swap   sw                0      0' | \
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
  sudo apt update && \
  sudo apt install -y grub-customizer && \
  sudo grub-customizer

for pkg in grub-common grub-customizer grub-efi grub-efi-amd64-bin grub-efi-amd64-signed grub-gfxpayload-lists grub-pc grub-pc-bin grub2-common; do sudo apt remove --purge -y $pkg; done

sudo apt install -y grub-customizer grub-efi efibootmgr

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
sudo grub-install /dev/nvme1n1p1
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo update-grub --output=/boot/grub/grub.cfg
sudo grub-install /dev/nvme1n1
kate /boot/grub/grub.cfg

sudo apt-add-repository -y ppa:yannubuntu/boot-repair && \
  sudo apt update && sudo apt install -y boot-repair && sudo boot-repair

sudo dpkg --configure -a
sudo apt install -y -fy
sudo apt purge --allow-remove-essential grub-com*
sudo apt purge --allow-remove-essential grub2-com*
sudo apt purge --allow-remove-essential shim-signed
sudo apt purge --allow-remove-essential grub-common:*
sudo apt purge --allow-remove-essential grub2-common:*

sudo apt update && sudo apt install -y ubuntu-desktop xorg dbus-x11 \
  xfce4 xfce4-goodies x11-xserver-utils

sudo apt update && sudo apt upgrade -y && \
  sudo add-apt-repository ppa:kubuntu-ppa/backports -y && \
  sudo apt update && sudo apt install -y kde-plasma-desktop

cat /etc/sddm.conf
echo -e "[General]\nInputMethod=" | sudo tee -a /etc/sddm.conf
echo '#################################################################'

echo '#### Mac'
echo '#################################################################'
sudo mount -t fat32 -o rw,realtime /dev/sda2 /mnt/MacOS
sudo mount -o rw UUID=2023-05-31-19-32-03-00 /mnt/MacOS

sudo add-apt-repository universe && \
  sudo apt update && \
  sudo apt install -y dmg2img && \
  dmg2img -v -i /path/to/image_file.dmg -o /path/to/image_file.iso

sudo dd if=/path/to/image_file.iso of=/dev/sdd

dd if=image.dmg of=/dev/sdb bs=16M status=progress

sudo dd if=/mnt/Disk_D/Ventura.iso of=/dev/nvme0n1p2
# for windows dd if=\\.\d:\Ventura.iso of=\\.\p:
echo '#################################################################'
