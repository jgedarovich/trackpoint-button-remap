#!/bin/sh


PREFIX=${1:-/usr/local}

echo Okay, time to install this puppy.
set -x
mkdir -p $PREFIX/bin || (mkdir $PREFIX; mkdir $PREFIX/bin)
#sudo cp *.rules /etc/udev/rules.d/
#sudo cp *.conf /etc/modules-load.d/
#sudo udevadm trigger
cp remap.py  $PREFIX/bin/remap.py
#sudo cp trackpoint-remap.service /etc/systemd/system
#sudo systemctl daemon-reload
#sudo systemctl enable trackpoint-remap.service
#sudo systemctl start trackpoint-remap.service
chmod a+x $PREFIX/bin/remap.py

