echo '#### Audio'
echo '#################################################################'
sudo apt-get install -y pipewire pipewire-audio-client-libraries pulseaudio-utils
sudo apt-get install -y wireplumber

systemctl enable --user pipewire
systemctl enable --user wireplumber
systemctl start --user pipewire
systemctl start --user wireplumber
pactl info | grep Server


sudo nano /etc/apt/apt.conf
sudo apt-get update
sudo apt-get install -y \
  libsystemd-dev libudev-dev libreadline6-dev pkg-config libxml2-dev \
  libboost-all-dev libelf-dev libnl-3-dev yasm zlib1g-dev libssl-dev




















sudo apt-get install -y linux-sound-base alsa-base alsa-utils alsa-tools
sudo gedit /etc/modprobe.d/alsa-base.conf
# paste after all text
options snd-hda-intel position fix=1
options snd-hda-intel model=alc298-dell1

# options snd-hda-codec-realtek dyndbg
# options snd-hda-intel model=,dell-headset-multi
# options snd-hda-intel model=dell-headset3
# options snd-hda-intel patch=alc298-sound-patch.fw,alc298-sound-patch.fw,


alsamixer
# press F6 & after, select correct audio card
sudo alsa force-reload

echo '#################################################################'
pacmd list-sinks

amixer -c 0 sset "Auto-Mute Mode" Enabled
pactl set-sink-port 0 'Speaker'

-Скачать эту программу:
sudo apt-get install -y pavucontrol

-Какие именно методы дискритизации поддерживает ваш компьютер:
pulseaudio --dump-resample-methods

-Изменение метода дискритизации и улучшение звука в наушниках:
sudo gedit /etc/pulse/daemon.conf

находим строчку и убераем знак ; в самом начале строки
resample-method = ""(без ковычек впишите нужный вам метод)

resample-method = soxr-vhq

находим эти строки и так же убераем знак ; в начале каждой строки
default-sample-format = s16le
default-sample-rate = 48000
; alternate-sample-rate = 48000
default-sample-channels = 2
default-channel-map = front-left,front-right




00:1f.3 Multimedia audio controller [0401]: Intel Corporation Alder Lake PCH-P High Definition Audio Controller [8086:51c8] (rev 01)
        DeviceName: Onboard - Sound
        Subsystem: Micro-Star International Co., Ltd. [MSI] Alder Lake PCH-P High Definition Audio Controller [1462:131d]
        Kernel driver in use: sof-audio-pci-intel-tgl
        Kernel modules: snd_hda_intel, snd_sof_pci_intel_tgl
