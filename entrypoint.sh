#!/bin/bash
cd /home/container
chmod 777 -R /home/.wine
export WINEPREFIX=/home/.wine
export WINEPATH=/home/.wine
Xvfb :0 -screen 0 320x240x8 &
#wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
#chmod +x winetricks
#cp winetricks /usr/local/bin
DISPLAY=:0.0 sh winetricks msxml4
wget https://aka.ms/vs/17/release/vc_redist.x64.exe
wine64 vc_redist.x64.exe /install /silent /norestart

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
#echo ":/home/container$ ${MODIFIED_STARTUP}"
export WINEARCH=win64
export DISPLAY=:0.0
# Run the Server

#${MODIFIED_STARTUP}
