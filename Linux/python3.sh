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

sudo apt -y install cpu-checker python3-pip python3-dev python3-virtualenv \
  python3-venv python-is-python3 python3 python3-full build-essential \
  software-properties-common wget zlib1g-dev libffi-dev libgdbm-dev \
  libnss3-dev libssl-dev libreadline-dev

modprobe kvm
modprobe kvm_intel
kvm-ok
lsmod | grep kvm
ls -al /dev/kvm
sudo usermod -aG kvm msi

cd /tmp
wget https://www.python.org/ftp/python/3.12.3/Python-3.12.3.tgz
tar -xf Python-3.12.3.tgz
cd Python-3.12.3
./configure --enable-optimizations
sudo make install
cd ~

# git clone https://github.com/crytic/slither
# cd slither
# git checkout dev
# make dev
# source ./env/bin/activate

pip3 install slither-analyzer
# python3 -m pip install solc-select
# solc-select install 0.8.25
# solc-select use 0.8.25

python3 --version
pip3 --version
echo '#### Python3 installed'
echo '#################################################################'
fi
