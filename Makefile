
install:
		udevadm trigger
		systemctl daemon-reload
		systemctl enable trackpoint-remap.service
		systemctl start trackpoint-remap.service
