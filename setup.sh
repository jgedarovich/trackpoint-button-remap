#sudo cp *.rules /etc/udev/rules.d/
#sudo cp *.conf /etc/modules-load.d/
#sudo udevadm trigger
sudo ls -s $PWD/remap.py /usr/bin/remap.py
sudo cp trackpoint-remap.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable trackpoint-remap.service
sudo systemctl start trackpoint-remap.service
