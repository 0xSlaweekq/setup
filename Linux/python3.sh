echo '#### Installing Python3'
echo '#################################################################'
if [[ $(which --version) && $(python3 --version) && $(pip3 --version) ]]; then
   echo 'Python3 installed, continue...'
else
   echo 'Python3 NOT installed, continue...'
sudo apt update
sudo apt -y upgrade
sudo apt -y --fix-broken install
sudo apt -y autoclean
sudo apt -y autoremove --purge

modprobe kvm
modprobe kvm_intel
kvm-ok
lsmod | grep kvm
ls -al /dev/kvm
sudo usermod -aG kvm msi

sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.11

python3.11 -m pip install --user pipenv
echo $PATH
which pipenv
# For building from source code the Python module dbus-python.
sudo apt install pkgconf cmake libdbus-1-dev libglib2.0-dev python3.11-dev


pip install pipenv
pip3 install slither-analyzer
python3 --version
pip3 --version
echo '#### Python3 installed'
echo '#################################################################'
fi

# cd /tmp
# wget https://www.python.org/ftp/python/3.11.0/Python-3.11.0.tgz
# tar -xf Python-3.11.0.tgz
# cd Python-3.11.0
# ./configure --enable-optimizations
# sudo make install
# cd ~
