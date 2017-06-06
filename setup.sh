#!/bin/sh

PREFIX=${1:-/usr/local}

echo Okay, time to install this puppy.
set -x

mkdir -p $PREFIX/bin
cp remap.py  $PREFIX/bin/remap.py
chmod a+x $PREFIX/bin/remap.py

mkdir -p $PREFIX/etc/modules-load.d/
cp *.conf $PREFIX/etc/modules-load.d/

mkdir -p $PREFIX/etc/udev/rules.d/
cp *.rules $PREFIX/etc/udev/rules.d/

udevadm trigger
#sudo cp trackpoint-remap.service /etc/systemd/system
#sudo systemctl daemon-reload
#sudo systemctl enable trackpoint-remap.service
#sudo systemctl start trackpoint-remap.service

