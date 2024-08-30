#!/bin/bash

PS3='Please select the VM: '
n=0
while read line ; do
  options[n++]="$line"
done <<<"$(vboxmanage list vms | awk '{$NF=""; print $0}' | tr -d '"')"
select opt in "${options[@]}" ; do
  vm_name="$opt"
  break
done

echo "Running updates for \"${vm_name}\" VM"

vboxmanage modifyvm "$vm_name" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff && echo "Changed CPU ID Set" ; sleep .5
vboxmanage setextradata "$vm_name" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac11,3" && echo "Changed DmiSystemProduct" ; sleep .5
vboxmanage setextradata "$vm_name" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0" && echo "Changed DmiSystemVersion" ; sleep .5
vboxmanage setextradata "$vm_name" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Iloveapple" && echo "Changed DmiBoardProduct" ; sleep .5
vboxmanage setextradata "$vm_name" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc" && echo "Changed DeviceKey" ; sleep .5
vboxmanage setextradata "$vm_name" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1 && echo "Changed GetKeyFromRealSMC" ; sleep .5
vboxmanage setextradata "$vm_name" "VBoxInternal2/EfiGraphicsResolution" "1920x1080" && echo "Changed resolution to 1280x1024" ; sleep .5