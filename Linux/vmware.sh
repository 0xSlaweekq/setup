sudo apt install -y open-vm-tools-desktop

wget https://download3.vmware.com/software/WKST-1750-LX/VMware-Workstation-Full-17.5.0-22583795.x86_64.bundle
chmod +x ./VMware-Workstation-Full-17.5.0-22583795.x86_64.bundle
sudo ./VMware-Workstation-Full-17.5.0-22583795.x86_64.bundle

sudo mkdir -p /mnt/cdrom
sudo mount /dev/cdrom /mnt/cdrom
cd /mnt/cdrom
sudo tar -xf $VMwareTools.tar.gz -C /$destination

sudo vmware-installer -u vmware-workstation
