echo 'Install programm'
echo '#################################################################'
sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
sudo add-apt-repository -y ppa:atareao/telegram
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo add-apt-repository -y multiverse
# Adding keys
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo wget -O /etc/apt/trusted.gpg.d/winehq.key https://dl.winehq.org/wine-builds/winehq.key
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/packages.microsoft.gpg
# wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# Adding repos
sudo echo "deb [signed-by=/etc/apt/trusted.gpg.d/winehq.key] https://dl.winehq.org/wine-builds/ubuntu $(lsb_release -cs) main" | \
  sudo tee /etc/apt/sources.list.d/winehq.list > /dev/null

sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |\
  sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/microsoft.gpg] https://packages.microsoft.com/repos/edge stable main" |\
  sudo tee /etc/apt/sources.list.d/microsoft-edge.list > /dev/null
# sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo rm -rf packages.microsoft.gpg
sudo rm -rf microsoft.gpg
# installing
sudo apt update
sudo dpkg --add-architecture amd64
sudo dpkg --add-architecture i386
sudo apt update
sudo apt -y upgrade
sudo apt -y install --install-recommends winehq-stable
# wine winecfg
# sudo apt -y install google-chrome-stable
sudo apt -y install grub-customizer solc telegram code \
  microsoft-edge-stable libgl1-mesa-dri:amd64 libgl1-mesa-dri:i386 \
  libgl1-mesa-glx:amd64 libgl1-mesa-glx:i386 \
  librust-proton-call-dev proton-caller
sudo apt -y --fix-broken install

# Options for shell in vscode
xdg-mime default code.desktop text/plain
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
mkdir -p "~"/.local/share/trusted.gpg.d
code --locate-shell-integration-path bash
[[ "$TERM_PROGRAM" == "vscode" ]] && . "/path/to/shell/integration/script.sh"

sudo flatpak install -y \
  flathub org.gnome.Maps org.kde.isoimagewriter org.kde.elisa \
  org.getoutline.OutlineClient org.getoutline.OutlineManager

sudo curl https://raw.githubusercontent.com/Tenderly/tenderly-cli/master/scripts/install-linux.sh | sudo sh
tenderly login --authentication-method access-key --access-key pdGB-7bDcER1WgNviv5KpUjUJcb-W22b --force
echo 'All programm installed'
echo '#################################################################'
