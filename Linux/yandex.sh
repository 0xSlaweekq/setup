sudo add-apt-repository ppa:slytomcat/ppa
curl -fsSL http://repo.yandex.ru/yandex-disk/YANDEX-DISK-KEY.GPG | \
  sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/YANDEX-DISK-KEY.GPG

echo "deb [signed-by=/etc/apt/trusted.gpg.d/YANDEX-DISK-KEY.GPG] http://repo.yandex.ru/yandex-disk/deb/ stable main" | \
  sudo tee -a /etc/apt/sources.list.d/yandex-disk.list > /dev/null

mkdir /mnt/Disk_D/Yandex.Disk

sudo apt update
sudo apt -y install --reinstall yandex-disk yd-tools
# sudo -v ; curl https://rclone.org/install.sh | sudo bash
# rclone config
yandex-disk setup

# yandex-disk token
cat ~/.config/yandex-disk/passwd
4217cb08fbc4a3d3d014a81f08950878
riybskctsijrhnyz

sudo gpasswd -a $USER davfs2
sudo systemctl restart davfs2
sudo usermod -aG davfs2 ${USER}
sudo chmod 777 /etc/davfs2/secrets

# sudo mount.davfs https://webdav.yandex.ru /mnt/Disk_D/Yandex.Disk/
# http://domain.tld/davath /path/to/webdove   davfs   user,rw,noauto   0   0

sudo gnome-text-editor /etc/davfs2/secrets

# ~/.config/yandex-disk
# # Путь к файлу с данными авторизации
# auth="~/.config/yandex-disk/passwd"
# iid="~/.config/yandex-disk/iid"
# config.cfg="~/.config/yandex-disk/config.cfg"

# # Каталог для хранения локальной копии Диска.
# dir="/mnt/Disk_D/Yandex.Disk"

# # Не синхронизировать указанные каталоги.
# #exclude-dirs="exclude/dir1,exclude/dir2,path/to/another/exclude/dir"

# # Указать прокси-сервер. Примеры:
# #proxy=https,127.0.0.1,80
# #proxy=https,127.0.0.1,80,login,password
# #proxy=https,127.0.0.1,443
# #proxy=socks4,my.proxy.local,1080,login,password
# #proxy=socks5,my.another.proxy.local,1081
# #proxy=auto
# #proxy=no
