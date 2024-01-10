curl -fsSL http://repo.yandex.ru/yandex-disk/YANDEX-DISK-KEY.GPG | \
  sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/YANDEX-DISK-KEY.GPG

echo "deb [signed-by=/etc/apt/trusted.gpg.d/YANDEX-DISK-KEY.GPG] http://repo.yandex.ru/yandex-disk/deb/ stable main" | \
  sudo tee -a /etc/apt/sources.list.d/yandex-disk.list > /dev/null

sudo apt update
sudo apt -y install yandex-disk
yandex-disk setup
# yandex-disk token
cat ~/.config/yandex-disk/passwd

sudo mount -t davfs https://webdav.yandex.ru /mnt/Disk_D/Yandex.Disk/
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
