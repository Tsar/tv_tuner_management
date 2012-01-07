#!/bin/bash

# This script installs soft to work with AverMedia MCE116 Plus (for XUbuntu 11.10)
# Run as root or with "sudo"

apt-get install ivtv-utils vlc
rmmod ivtv
modprobe ivtv
wget http://www.steventoth.net/linux/xc5000/HVR-12x0-14x0-17x0_1_25_25271_WHQL.zip  #if this URL doesn't work, comment this line and uncomment next
#wget https://raw.github.com/Tsar/tv_tuner_management/master/files_for_installer/HVR-12x0-14x0-17x0_1_25_25271_WHQL.zip
unzip -j HVR-12x0-14x0-17x0_1_25_25271_WHQL.zip Driver85/hcw85bda.sys
wget http://linuxtv.org/hg/v4l-dvb/raw-file/3919b17dc88e/linux/Documentation/video4linux/extract_xc3028.pl  #if this URL doesn't work, comment this line and uncomment next
#wget https://raw.github.com/Tsar/tv_tuner_management/master/files_for_installer/extract_xc3028.pl
perl extract_xc3028.pl
cp xc3028-v27.fw /lib/firmware/xc3028-v27.fw

echo "Now you should run TV tuner in Windows; than reboot back and use \"tv_tuner_channels_switcher.sh\""
