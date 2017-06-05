
install:
		cp 94-trackpoint.rules /etc/udev/rules.d/
		cp 93-trackpoint.rules.conf /etc/udev/rules.d/
		udevadm trigger
		cp trackpoint-button-remap /usr/bin/trackpoint-button-remap
		systemctl daemon-reload
		systemctl enable trackpoint-remap.service
		systemctl start trackpoint-remap.service
