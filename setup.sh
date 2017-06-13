#!/bin/sh

PREFIX=${1:-/usr/local}

echo Okay, time to install this puppy.
set -x

mkdir -p $PREFIX/bin
cp remap.py  $PREFIX/bin/remap.py
chmod a+x $PREFIX/bin/remap.py

mkdir -p $PREFIX/etc/modules-load.d/
cp *.conf $PREFIX/etc/modules-load.d/

#mkdir -p $PREFIX/etc/udev/rules.d/
#cp *.rules $PREFIX/etc/udev/rules.d/

# do this instead of the above two lines - add to configuration.nix under services.udev.extraRules

# KERNEL=="event[0-9]*", SUBSYSTEM=="input", SUBSYSTEMS=="input", 
# ATTRS{name}=="TPPS/2 IBM TrackPoint", SYMLINK+="my_trackpoint", 
# TAG+="uaccess"
# KERNEL=="uinput", TAG+="uaccess"


#udevadm trigger
#sudo cp trackpoint-remap.service /etc/systemd/system
#sudo systemctl daemon-reload
#sudo systemctl enable trackpoint-remap.service
#sudo systemctl start trackpoint-remap.service

