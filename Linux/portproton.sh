wget https://github.com/Castro-Fidel/PortProton_dpkg/releases/download/portproton_1.7-2_amd64/portproton_1.7-2_amd64.deb

sudo dpkg --add-architecture amd64
sudo dpkg --add-architecture i386
sudo add-apt-repository multiverse
sudo apt update
sudo apt upgrade
sudo apt install -y \
  dkms linux-headers-$(uname -r) meson libsystemd-dev pkg-config ninja-build git \
  libdbus-1-dev libinih-dev build-essential curl file libc6 libnss3 policykit-1 \
  xz-utils bubblewrap mesa-utils icoutils tar libvulkan1:{i386,amd64} zstd \
  cabextract xdg-utils openssl libgl1:{i386,amd64} libpoppler-glib8:{i386,amd64} \
  libgtk-3-dev glslang-tools \
  mingw-w64 mingw-w64-common mingw-w64-i686-dev mingw-w64-tools mingw-w64-x86-64-dev
  
sudo apt install --fix-broken -y

sudo apt install lutris

git clone --recurse-submodules https://github.com/flightlessmango/MangoHud.git && \
  cd MangoHud && \
  ./build.sh build && \
  ./build.sh package && \
  ./build.sh install && \
  cd ~
  
 
