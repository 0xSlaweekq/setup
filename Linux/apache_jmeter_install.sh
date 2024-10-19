#!/bin/bash

sudo apt update -y
sudo apt install openjdk-11-jdk apache2 -y
java -version

sudo systemctl start apache2
sudo systemctl enable apache2

cd ~
wget https://downloads.apache.org//jmeter/binaries/apache-jmeter-5.6.3.tgz

mkdir $HOME/jmeter $HOME/jmeter/backups
tar -xvzf apache-jmeter-5.6.3.tgz -C $HOME/jmeter --strip-components=0
chmod +x $HOME/jmeter/bin/jmeter
rm -rf apache-jmeter-5.6.3.tgz

tee -a ~/.bashrc <<< \
'
export PATH="$PATH:$HOME/jmeter/bin"'
source ~/.bashrc

sudo tee -a /usr/share/applications/jmeter.desktop <<< \
'
[Desktop Entry]
Name=JMeter
Comment=Apache JMeter v5.6.3
GenericName=Apache JMeter v5.6.3
Exec=$HOME/jmeter/bin/jmeter %F
Icon=jmeter
Type=Application
StartupNotify=false
StartupWMClass=jmeter
Categories=Network;
Actions=new-window;
Keywords=jmeter;

[Desktop Action new-window]
Name=New Window
Name[ru]=Новое окно
Exec=$HOME/jmeter/bin/jmeter --new-window %F
Icon=jmeter'

echo "
##### Start UI: jmeter or alt+F2 -> JMeter in Applications
Start CLI: jmeter -n -t your_test_plan.jmx -l results.jtl"
