wget https://github.com/Castro-Fidel/PortProton_dpkg/releases/download/portproton_1.7-2_amd64/portproton_1.7-2_amd64.deb

sudo dpkg --add-architecture i386
sudo add-apt-repository multiverse
sudo apt update
sudo apt upgrade
sudo apt install -y \
  curl file libc6 libnss3 policykit-1 xz-utils bubblewrap mesa-utils icoutils tar libvulkan1:{i386,amd64} zstd cabextract xdg-utils openssl libgl1:{i386,amd64}


sudo apt install lutris

git clone --recurse-submodules https://github.com/flightlessmango/MangoHud.git &&\
  cd MangoHud && \
  ./build.sh build && \
  ./build.sh package && \
  ./build.sh install
