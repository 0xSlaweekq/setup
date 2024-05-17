echo '#### Installing Intel gpu drivers'
echo '#################################################################'
# https://www.intel.com/content/www/us/en/download/747008/intel-arc-graphics-driver-ubuntu.html
# https://dgpu-docs.intel.com/driver/client/overview.html
wget -qO- https://repositories.intel.com/gpu/intel-graphics.key | gpg --dearmor > intel-graphics.gpg
sudo install -o root -g root -m 644 intel-graphics.gpg /etc/apt/trusted.gpg.d/
echo "deb [arch=amd64,i386] https://repositories.intel.com/gpu/ubuntu jammy client" | \
  sudo tee /etc/apt/sources.list.d/intel-gpu.list
sudo apt update

# si libgl1 libglvnd0 libglx0

# wget -qO - https://repositories.intel.com/gpu/intel-graphics.key | \
#   sudo gpg --dearmor --output /usr/share/keyrings/intel-graphics.gpg
# echo "deb [arch=amd64,i386 signed-by=/usr/share/keyrings/intel-graphics.gpg] https://repositories.intel.com/gpu/ubuntu jammy client" | \
#   sudo tee /etc/apt/sources.list.d/intel-gpu-jammy.list

sudo apt update
sudo apt -y upgrade
sudo apt -y --fix-broken install
sudo apt -y autoclean
sudo apt -y autoremove --purge

sudo apt install -y \
  intel-opencl-icd intel-level-zero-gpu level-zero \
  intel-media-va-driver-non-free libmfx1 libmfxgen1 libvpl2 \
  libegl-mesa0 libegl1-mesa libegl1-mesa-dev libgbm1 libgl1-mesa-dev  \
  libglapi-mesa libglx-mesa0 libigdgmm12 libxatracker2 mesa-va-drivers \
  mesa-vdpau-drivers mesa-vulkan-drivers va-driver-all vainfo hwinfo clinfo
# libgl1-mesa-dri libgles2-mesa-dev
sudo apt --fix-broken install
sudo apt -y install -f
sudo apt -y -s full-upgrade

sudo dpkg --add-architecture i386
sudo apt update
sudo apt install -y \
  udev mesa-va-drivers:i386 mesa-common-dev:i386 mesa-vulkan-drivers:i386 \
  libd3dadapter9-mesa-dev:i386 libegl1-mesa:i386 libegl1-mesa-dev:i386 \
  libgbm-dev:i386 libgl1-mesa-glx:i386 libgl1-mesa-dev:i386 \
  libgles2-mesa:i386 libgles2-mesa-dev:i386 libosmesa6:i386 \
  libosmesa6-dev:i386 libwayland-egl1-mesa:i386 libxatracker2:i386 \
  libxatracker-dev:i386 mesa-vdpau-drivers:i386 libva-x11-2:i386

sudo apt install -y \
  libigc-dev intel-igc-cm libigdfcl-dev libigfxcmrt-dev level-zero-dev


sudo apt update && sudo apt install  -y --install-suggests  linux-generic-hwe-24.04
sudo reboot
uname -r
sudo apt -y install \
    gawk \
    dkms \
    linux-headers-$(uname -r) \
    libc6-dev

sudo apt install -y \
  intel-i915-dkms intel-platform-vsec-dkms \
  intel-platform-cse-dkms intel-fw-gpu
sudo reboot -h now
echo '#################################################################'



# sudo apt install -y --reinstall aha appmenu-gtk-module-common appmenu-gtk3-module apport \
#   apport-core-dump-handler apport-symptoms bluez-obexd ca-certificates-java \
#   cryfs cups-pk-helper default-jre-headless docbook-xml docbook-xsl fonts-ibm-plex \
#   fonts-noto-unhinted gir1.2-freedesktop-dev gir1.2-notify-0.7 gir1.2-udisks-2.0 \
#   ibus-data java-common kamera kate5-data kdeplasma-addons-data kdoctools5 \
#   kio-extras-data kirigami-addons-data kpeople-vcard ktexteditor-data \
#   ktexteditor-katepart kubuntu-notification-helper lame libappmenu-gtk3-parser0 \
#   libatk-bridge2.0-dev libatk1.0-dev libatkmm-1.6-1v5 libatspi2.0-dev libb2-1 \
#   libboost-chrono1.83.0t64 libboost-program-options1.83.0 libbrotli-dev libbsh-java \
#   libbz2-dev libcairo2-dev libcairomm-1.0-1v5 libcddb2 libcdio-cdda2t64 \
#   libcdio-paranoia2t64 libcfitsio10t64 libchm1 libcpuid16 libdatrie-dev \
#   libdc1394-25 libdca0 libdeflate-dev libdolphinvcs5 libdrm-dev \
#   libdrm-dev:i386 libdvbpsi10 libdvdnav4 libebml5 libeditorconfig0 \
#   libegl-mesa0:i386 libel-api-java libfaad2 libfakekey0 libfmt9 libfontconfig-dev \
#   libfreetype-dev libfribidi-dev libgdk-pixbuf-2.0-dev libgl1-amber-dri libgles1 \
#   libglibmm-2.4-1t64 libglu1-mesa libglx-mesa0:i386 libgps30t64 libgrantlee-templates5 \
#   libgraphite2-dev libgsettings-qt1 libgsoap-2.8.132t64 libgssdp-1.6-0 libgtkmm-3.0-1t64 \
#   libgupnp-1.6-0 libgupnp-igd-1.6-0 libharfbuzz-cairo0 libharfbuzz-dev libhsqldb1.8.0-java \
#   libibus-1.0-5 libical3t64 libixml11t64 libjavascriptcoregtk-4.1-0 libjbig-dev libjpeg-dev\
#   libjpeg-turbo8-dev libjpeg8-dev libjsp-api-java libkate1 libkcolorpicker0 libkdsoap1 \
#   libkf5activities-doc libkf5archive-doc libkf5attica-doc libkf5auth-dev-bin libkf5auth-doc \
#   libkf5bookmarks-doc libkf5calendarevents5 libkf5cddb5 libkf5codecs-doc libkf5completion-doc \
#   libkf5config-dev-bin libkf5config-doc libkf5configwidgets-doc libkf5contacts-data \
#   libkf5contacts5 libkf5coreaddons-dev-bin libkf5coreaddons-doc libkf5crash-doc \
#   libkf5dbusaddons-doc libkf5declarative-doc libkf5globalaccel-doc libkf5guiaddons-doc \
#   libkf5holidays-data libkf5holidays5 libkf5i18n-doc libkf5i18nlocaledata5 \
#   libkf5iconthemes-doc libkf5itemviews-doc libkf5jobwidgets-doc libkf5js5t64 \
#   libkf5khtml-data libkf5kio-doc libkf5modemmanagerqt6 libkf5newstuff-doc libkf5notifications-doc libkf5package-doc libkf5people-data libkf5people5 libkf5peoplebackend5 libkf5peoplewidgets5 libkf5plasma-doc libkf5plasmaquick5 libkf5pulseaudioqt3 libkf5service-doc libkf5solid-doc libkf5texteditor-bin libkf5texteditor5 libkf5unitconversion-data libkf5unitconversion5 libkf5wayland-doc libkf5waylandserver5 libkf5widgetsaddons-doc libkf5windowsystem-doc libkf5xmlgui-doc libkimageannotator-common libkimageannotator0 libkubuntu1 libkuserfeedbackwidgets1 liblerc-dev liblirc-client0t64 libllvm17t64 libllvm17t64:i386 liblua5.2-0 liblzf1 liblzma-dev libmad0 libmanette-0.2-0 libmatroska7 libmpcdec6 libmtp-common libmtp-runtime libmtp9t64 libmujs3 libmusicbrainz5cc2v5 libneon27t64-gnutls libnice10 libnvidia-common-550 libnvidia-decode-550 libnvidia-decode-550:i386 libnvidia-encode-550 libnvidia-encode-550:i386 libnvidia-extra-550 libnvidia-fbc1-550 libnvidia-fbc1-550:i386 libnvidia-gl-550 libnvidia-gl-550:i386 libopengl-dev libopengl0 libopenmpt-modplug1 libpango1.0-dev libpangomm-1.4-1v5 libpciaccess-dev libpciaccess-dev:i386 libpcre3 libpixman-1-dev libpng-dev libpng-tools libprotobuf-lite32t64 libproxy-tools libpthread-stubs0-dev:i386 libqalculate-data libqalculate22t64 libqt5concurrent5t64 libqt5designer5 libqt5help5 libqt5quickparticles5-gles libqt5quicktest5 libqt5script5 libqt5scripttools5 libqt6core6t64 libqt6dbus6t64 libqt6network6t64 libqt6qml6 libqt6qmlmodels6 libqt6sql6-sqlite libqt6sql6t64 libqt6xml6t64 libresid-builder0c2a libscim8v5 libservlet-api-java libservlet3.1-java libsharpyuv-dev libsidplay2 libsixel1 libspatialaudio0t64 libspdlog1.12 libspectre1 libthai-dev libtiff-dev libtiffxx6 libtorrent-rasterbar2.0t64 libts0t64 libupnp17t64 libvlc-bin libvlc5 libvlccore9 libvncserver1 libvulkan-dev libwebp-dev libwebpdecoder3 libwebsocket-api-java libx11-dev:i386 libxatracker2 libxau-dev:i386 libxcb-glx0:i386 libxcb-shm0-dev libxcb-xv0 libxcb1-dev:i386 libxcomposite-dev libxcursor-dev libxdamage-dev libxdmcp-dev:i386 libxfont2 libxft-dev libxinerama-dev libxkbcommon-dev libxpresent1 libxrandr-dev libxrender-dev libxtst-dev libxvmc1 libxxf86dga1 libzstd-dev nvidia-prime nvidia-utils-550 openjdk-21-jre-headless pango1.0-tools phonon-backend-vlc-common python3-apport python3-cups python3-cupshelpers python3-dbus.mainloop.pyqt5 python3-mutagen python3-problem-report python3-pycryptodome python3-pyqt5.sip python3-systemd python3-websockets qapt-batch qml-module-gsettings1.0 qml-module-org-kde-draganddrop qml-module-org-kde-kconfig qml-module-org-kde-kholidays qml-module-org-kde-kio qml-module-org-kde-kirigami-addons-labs-mobileform qml-module-org-kde-people qml-module-org-kde-solid qml-module-org-kde-userfeedback qml-module-qtquick-particles2 qml-module-qtwebengine qt6-translations-l10n qtbase5-dev-tools qtdeclarative5-dev-tools sgml-data sshfs system-config-printer-common system-config-printer-udev usb-creator-common virtualbox-guest-utils vlc-bin vlc-data vlc-l10n vlc-plugin-access-extra vlc-plugin-base vlc-plugin-notify vlc-plugin-qt vlc-plugin-samba vlc-plugin-skins2 vlc-plugin-video-splitter vulkan-tools wayland-protocols wayland-utils x11-session-utils x11-xkb-utils xcvt xfonts-base xfonts-scalable xinit xinput xserver-common xserver-xorg-legacy yelp-xsl yt-dlp

# sudo apt install  --reinstall ark baloo-kf5 breeze debconf-kde-helper drkonqi fcitx5-config-qt fcitx5-frontend-qt5 fcitx5-pinyin-gui ffmpegthumbs frameworkintegration kaccounts-integration kactivitymanagerd kamera kcalc kcharselect kde-cli-tools kde-config-fcitx5 kde-config-gtk-style kde-config-screenlocker kde-config-sddm kde-config-updates kde-config-whoopsie kde-spectacle kde-style-breeze kde-style-oxygen-qt5 kded5 kdegraphics-thumbnailers kdenetwork-filesharing kdialog keditbookmarks kgamma5 khotkeys kimageformat-plugins kinit kio kio-admin kio-fuse kio-gdrive kirigami2-dev kmenuedit konsole konsole-kpart kpackagelauncherqml kpeople-vcard krdc ksshaskpass ksystemlog ksystemstats ktexteditor-katepart kubuntu-notification-helper kup-backup kwalletmanager kwayland-integration kwin-common kwin-decoration-oxygen kwin-style-breeze kwin-x11 kwrited layer-shell-qt libcolorcorrect5 libdbusmenu-qt5-2 libdebconf-kde1 libegl1  libfcitx5-qt1 libgles2 libglu1-mesa libkaccounts2 libkcolorpicker0 libkdecorations2-5v5 libkdecorations2private10 libkf5auth5 libkf5authcore5 libkf5baloo5 libkf5baloowidgets-bin libkf5baloowidgets-data libkf5baloowidgets5 libkf5bookmarks5 libkf5cddb5 libkf5completion5 libkf5configgui5 libkf5configwidgets5 libkf5contacts5 libkf5crash5 libkf5dbusaddons5 libkf5declarative5 libkf5filemetadata-bin libkf5globalaccel-bin libkf5globalaccel5 libkf5globalaccelprivate5 libkf5guiaddons-bin libkf5guiaddons5 libkf5iconthemes-bin libkf5iconthemes5 libkf5idletime5 libkf5itemviews5 libkf5jobwidgets5 libkf5kcmutils5 libkf5kcmutilscore5 libkf5kdcraw5 libkf5kdelibs4support5 libkf5kdelibs4support5-bin libkf5kexiv2-15.0.0 libkf5kiocore5 libkf5kiofilewidgets5 libkf5kiogui5 libkf5kiowidgets5 libkf5kirigami2-5 libkf5newstuff5 libkf5newstuffcore5 libkf5newstuffwidgets5 libkf5notifications5 libkf5notifyconfig5 libkf5parts-plugins libkf5parts5 libkf5people5 libkf5peoplewidgets5 libkf5plasma5 libkf5plasmaquick5 libkf5prison5 libkf5pulseaudioqt3 libkf5purpose-bin libkf5purpose5 libkf5quickaddons5 libkf5runner5 libkf5sane5 libkf5screen-bin libkf5screen8 libkf5screendpms8 libkf5service-bin libkf5service5 libkf5solid5 libkf5sonnetui5 libkf5style5 libkf5syntaxhighlighting5 libkf5sysguard-bin libkf5texteditor-bin libkf5texteditor5 libkf5textwidgets5 libkf5wallet-bin libkf5wallet5 libkf5waylandclient5 libkf5waylandserver5 libkf5widgetsaddons5 libkf5windowsystem5 libkf5xmlgui5 libkfontinstui5 libkimageannotator0 libkpim5gapicore5 libkpim5gapidrive5 libkpipewire5 libkpipewiredmabuf5 libkpipewirerecord5 libkpmcore12 libksanecore1 libkscreenlocker5 libksignalplotter9 libksysguardformatter1 libksysguardsensorfaces1 libksysguardsensors1 libkubuntu1 libkuserfeedbackcore1 libkuserfeedbackwidgets1 libkwalletbackend5-5 libkwineffects14 libkwinglutils14 libkworkspace5-5 liblayershellqtinterface5 liblsofui9 libnotificationmanager1 libopengl-dev liboxygenstyle5-5 liboxygenstyleconfig5-5 libphonon4qt5-4t64 libpolkit-qt5-1-1 libpoppler-qt5-1t64 libpowerdevilcore2 libprocesscore9 libprocessui9 libqaccessibilityclient-qt5-0 libqapt3-runtime libqmobipocket2 libqt5designer5 libqt5gui5-gles libqt5help5 libqt5hunspellinputmethod5 libqt5multimedia5 libqt5multimediaquick5 libqt5printsupport5t64 libqt5quick5-gles libqt5quickcontrols2-5 libqt5quickparticles5-gles libqt5quickshapes5 libqt5quicktemplates2-5 libqt5quicktest5 libqt5quickwidgets5 libqt5scripttools5 libqt5svg5 libqt5virtualkeyboard5 libqt5waylandclient5 libqt5waylandclient5-dev libqt5webengine5 libqt5webenginecore5 libqt5webenginewidgets5 libqt5webkit5 libqt5webview5 libqt5widgets5t64 libqt5x11extras5 libreoffice-kf5 libreoffice-plasma libreoffice-qt5 libtaskmanager6 libweather-ion7  partitionmanager phonon4qt5settings pinentry-qt plasma-browser-integration plasma-discover plasma-discover-backend-flatpak plasma-discover-backend-fwupd plasma-discover-backend-snap plasma-discover-notifier plasma-disks plasma-distro-release-notifier plasma-firewall plasma-integration plasma-systemmonitor plasma-theme-oxygen plasma-thunderbolt polkit-kde-agent-1 powerdevil qapt-batch qapt-deb-installer qml-module-org-kde-activities qml-module-org-kde-draganddrop qml-module-org-kde-kaccounts qml-module-org-kde-kcm qml-module-org-kde-kcmutils qml-module-org-kde-kconfig qml-module-org-kde-kcoreaddons qml-module-org-kde-kio qml-module-org-kde-kirigami-addons-labs-mobileform qml-module-org-kde-kirigami2 qml-module-org-kde-kquickcontrols qml-module-org-kde-kquickcontrolsaddons qml-module-org-kde-ksysguard qml-module-org-kde-kwindowsystem qml-module-org-kde-newstuff qml-module-org-kde-people qml-module-org-kde-pipewire qml-module-org-kde-prison qml-module-org-kde-purpose qml-module-org-kde-qqc2breezestyle qml-module-org-kde-qqc2desktopstyle qml-module-org-kde-quickcharts qml-module-org-kde-runnermodel qml-module-org-kde-solid qml-module-org-kde-sonnet qml-module-org-kde-syntaxhighlighting qml-module-org-kde-userfeedback qml-module-qt-labs-platform qml-module-qtgraphicaleffects qml-module-qtmultimedia qml-module-qtquick-controls qml-module-qtquick-controls2 qml-module-qtquick-dialogs qml-module-qtquick-layouts qml-module-qtquick-particles2 qml-module-qtquick-privatewidgets qml-module-qtquick-shapes qml-module-qtquick-templates2 qml-module-qtquick-virtualkeyboard qml-module-qtquick-window2 qml-module-qtquick2 qml-module-qtwebengine qml-module-sso-onlineaccounts qml-module-ubuntu-onlineaccounts qt5-gtk-platformtheme qt5-image-formats-plugins qt5-qmltooling-plugins qt5-style-kvantum qtdeclarative5-dev-tools qtspeech5-flite-plugin qtvirtualkeyboard-plugin signon-kwallet-extension signon-ui-x11 skanlite skanpage sweeper systemsettings vlc-plugin-qt vlc-plugin-skins2 xdg-desktop-portal-kde


# libegl1-mesa ocs-url
