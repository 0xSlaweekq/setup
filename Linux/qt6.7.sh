cd ~/Downloads
wget https://ftp.nluug.nl/languages/qt/archive/qt/6.6/6.6.3/single/qt-everywhere-src-6.6.3.tar.xz

cd /tmp
tar xf ~/Downloads/qt-everywhere-src-6.6.3.tar.xz

mkdir -p ~/dev/qt-build
cd ~/dev/qt-build
/tmp/qt-everywhere-src-6.6.3/configure

cmake --build . --parallel
cmake --install .

PATH=/usr/local/Qt-6.6.3/bin:$PATH
export PATH
