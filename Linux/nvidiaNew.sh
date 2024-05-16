cd ~
wget https://us.download.nvidia.com/XFree86/Linux-x86_64/550.78/NVIDIA-Linux-x86_64-550.78.run
/etc/init.d/lightdm stop
dpkg --purge nvidia-*
chmod 700 NVIDIA-*.run
nvidia-xconfig
/etc/init.d/lightdm start


# Very huge font in LightDM after installed nVidia driver
# 1. Check the default config of xserver-command
# cat /usr/share/lightdm/lightdm.conf.d/50-xserver-command.conf | grep "xserver-command"
# xserver-command=X -core
# 2. Copy above line to the custom config file. Append "-dpi 96" to the end of the line
# nano /etc/lightdm/lightdm.conf.d/20-lubuntu.conf
# [SeatDefaults]
# user-session=Kubuntu
# xserver-command=X -core -dpi 96

# Unable to start Steam
# 1. ia32-libs is NOT required for x86_64.
# 2. Locale was not exported. Try to run steam by: LC_ALL=C steam

# Unable to run XBMC after using nVidia Propietary driver
# Link libGL.so to nVidia's version:
#     cd /usr/lib/x86_64-linux-gnu/mesa
#     rm libGL.so.1
#     ln -s /usr/lib/libGL.so libGL.so.1
