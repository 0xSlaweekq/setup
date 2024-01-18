sudo apt update
sudo apt install wireguard

sudo mkdir /etc/wireguard
ls /etc/wireguard
wg genkey | sudo tee /etc/wireguard/private.key
sudo chmod go= /etc/wireguard/private.key
# 6H1oDiwEOBDQv0TMNlr8yfiTd2ndwh6k8+kbLvk05FU=

sudo cat /etc/wireguard/private.key | \
    wg pubkey | \
    sudo tee /etc/wireguard/public.key
# t9WPsbPpKYw7mFerxrAi+e0WtEmf3akYmOZErp1JDAk=

# 10.110.0.3
# 10.110.110.1
# printf `${date +%s%N}${cat /var/lib/dbus/machine-id}` | sha1sum | cut -c 31-
# 90afd80709
# fd90:afd8:0709::/64

# fd42:42:42::1/64

sudo bash -c \
'cat << EOF > /etc/wireguard/wg0.conf
[Interface]
PrivateKey = 6H1oDiwEOBDQv0TMNlr8yfiTd2ndwh6k8+kbLvk05FU=
Address = 10.110.110.1/24, fd42:42:42::1/64
ListenPort = 51820
SaveConfig = true
PostUp = ufw route allow in on wg0 out on eth0
PostUp = iptables -I INPUT -p udp --dport 51820 -j ACCEPT
PostUp = iptables -I FORWARD -i eth0 -o wg0 -j ACCEPT
PostUp = iptables -I FORWARD -i wg0 -j ACCEPT
PostUp = iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE
PreDown = ufw route delete allow in on wg0 out on eth0
PreDown = iptables -D INPUT -p udp --dport 51820 -j ACCEPT
PreDown = iptables -D FORWARD -i eth0 -o wg0 -j ACCEPT
PreDown = iptables -D FORWARD -i wg0 -j ACCEPT
PreDown = iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
PostUp = ip rule add table 200 from 188.166.15.133
PostUp = ip route add table 200 default via 188.166.15.1
PreDown = ip rule delete table 200 from 188.166.15.133
PreDown = ip route delete table 200 default via 188.166.15.1
EOF'

sudo tee -a /etc/sysctl.conf <<< \
'net.ipv4.ip_forward=1
net.ipv6.conf.all.forwarding=1'
sudo sysctl -p

ip route list default
# default via 188.166.0.1 dev eth0 proto static

sudo ufw allow 63287/udp
sudo ufw allow OpenSSH
sudo ufw disable
sudo ufw enable
sudo ufw status

sudo systemctl enable wg-quick@wg0.service
sudo systemctl start wg-quick@wg0.service
sudo systemctl status wg-quick@wg0.service
sudo systemctl daemon-reload



# add peer
wg genkey | sudo tee /etc/wireguard/private_msi.key
sudo chmod go= /etc/wireguard/private_msi.key
# uC4FjyDUUGT+61sSwyzGqIL34rZU2beN/6yLb9kuy2E=

sudo cat /etc/wireguard/private_msi.key | \
  wg pubkey | \
  sudo tee /etc/wireguard/public_msi.key
# RfcBqDI2W3KrpgD8su/IXNNqerLRsZ+QsZZYJlekoxI=

sudo bash -c \
'cat << EOF > /etc/wireguard/msi.conf
[Interface]
PrivateKey = uC4FjyDUUGT+61sSwyzGqIL34rZU2beN/6yLb9kuy2E=
Address = 10.110.110.2/24,fd42:42:42::2/64
DNS = 8.8.8.8,8.8.4.4

[Peer]
PublicKey = RfcBqDI2W3KrpgD8su/IXNNqerLRsZ+QsZZYJlekoxI=
Endpoint = 188.166.12.166:51820
AllowedIPs = 0.0.0.0/0,::/0
EOF'

ip route list table main default
# default via 188.166.0.1 dev eth0 proto static
ip -brief address show eth0
# eth0             UP             188.166.15.133/18 10.18.0.6/16 fe80::48a2:57ff:fea3:7391/64
resolvectl dns eth0
# Link 2 (eth0): 67.207.67.2 67.207.67.3

sudo wg set wg0 peer RfcBqDI2W3KrpgD8su/IXNNqerLRsZ+QsZZYJlekoxI= allowed-ips 0.0.0.0/0,::/0
sudo wg













# PostUp = ufw route allow in on wg0 out on eth0
# PostUp = iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE
# PreDown = ufw route delete allow in on wg0 out on eth0
# PreDown = iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
