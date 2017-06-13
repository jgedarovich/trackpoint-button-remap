❯ tar czvf tpbr.tar.gz trackpoint-button-remap
nix-build default.nix
nix-env -f default.nix -i
sudo nixos-rebuild switch

http://superuser.com/questions/883782/how-do-i-properly-map-a-keyboard-key-to-a-mouse-button
An askubuntu post contains an answer that I will summarize below.

The problem is that xbindkeys grabs the entire mouse, making modifers+mouse click mapping uncertain. The answer uses uinput via python-uinput script to monitor /dev/my-mouse for the thumb button click and send the Ctrl key to the virtual keyboard. Here are the detailed steps:

1. Make udev rules

For the mouse, file /etc/udev/rules.d/93-mxmouse.conf.rules :

KERNEL=="event[0-9]*", SUBSYSTEM=="input", SUBSYSTEMS=="input", 
ATTRS{name}=="Logitech Performance MX", SYMLINK+="my_mx_mouse", 
GROUP="mxgrabber", MODE="640"
Udev will look for kernel devices with names like event5. The SYMLINK is for finding the mouse in /dev/my_mx_mouse, readable by the group mxgrabber.

To find hardware information run something like :

udevadm info -a -n /dev/input/eventX
For uinput, file /etc/udev/rules.d/94-mxkey.rules :

KERNEL=="uinput", GROUP="mxgrabber", MODE="660"
Unplug and plug your mouse, or force udev to trigger the rules with udevadm trigger.

2. Activate UINPUT Module

sudo modprobe uinput
And in /etc/modules-load.d/uinput.conf :

uinput
3. Create new group

sudo groupadd mxgrabber
sudo usermod -aG mxgrabber your_login
4. Python script

Install python-uinput library and python-evdev library.

The script below requires identifying the event.code of the button :

#!/usr/bin/python3.5
# -*- coding: utf-8 -*-

"""
Sort of mini driver.
Read a specific InputDevice (my_mx_mouse),
monitoring for special thumb button
Use uinput (virtual driver) to create a mini keyboard
Send ctrl keystroke on that keyboard
"""

from evdev import InputDevice, categorize, ecodes
import uinput

# Initialize keyboard, choosing used keys
ctrl_keyboard = uinput.Device([
    uinput.KEY_KEYBOARD,
    uinput.KEY_LEFTCTRL,
    uinput.KEY_F4,
    ])

# Sort of initialization click (not sure if mandatory)
# ( "I'm-a-keyboard key" )
ctrl_keyboard.emit_click(uinput.KEY_KEYBOARD)

# Useful to list input devices
#for i in range(0,15):
#    dev = InputDevice('/dev/input/event{}'.format(i))
#    print(dev)

# Declare device patch.
# I made a udev rule to assure it's always the same name
dev = InputDevice('/dev/my_mx_mouse')
#print(dev)
ctrlkey_on = False

# Infinite monitoring loop
for event in dev.read_loop():
    # My thumb button code (use "print(event)" to find)
    if event.code == 280 :
        # Button status, 1 is down, 0 is up
        if event.value == 1:
            ctrl_keyboard.emit(uinput.KEY_LEFTCTRL, 1)
            ctrlkey_on = True
        elif event.value == 0:
            ctrl_keyboard.emit(uinput.KEY_LEFTCTRL, 0)
            ctrlkey_on = False
5. Finishing

Make the python file executable and ensure it is loaded at startup.

Use of 'uaccess' instead of GROUP and MODE?

Bug openobex - relies on non-existing group plugdev, conflict with systemd made me rethink the rules I have been using for Logitech_Unifying_Receiver.

Currently, the following rule is taught to the user:

SUBSYSTEMS=="usb", ATTRS{idVendor}=="1781", ATTRS{idProduct}=="0c9f", GROUP="users", MODE="0666"
What about changing it to:

SUBSYSTEMS=="usb", ATTRS{idVendor}=="1781", ATTRS{idProduct}=="0c9f", TAG+="uaccess"
As a developer note, Ubuntu versions before 13.04 Raring needs TAG+="udev-acl" instead of uaccess. For compatibility with modern and legacy systems:

SUBSYSTEMS=="usb", ATTRS{idVendor}=="1781", ATTRS{idProduct}=="0c9f", TAG+="uaccess", TAG+="udev-acl"
References:

http://cgit.freedesktop.org/systemd/systemd/tree/src/login/70-uaccess.rules
Lekensteyn (talk) 10:16, 6 June 2013 (UTC)

https://wiki.archlinux.org/index.php/Talk:Udev#Use_of_.27uaccess.27_instead_of_GROUP_and_MODE.3F



ABS_MAX not definedA
https://github.com/tuomasjjrasanen/python-uinput/issues/15
https://github.com/tuomasjjrasanen/python-uinput/blob/master/src/ev.py


disable trackpoint
xinput set-prop "TPPS/2 IBM TrackPoint" "Device Enabled" 0

only disable buttons but keep pointer
xinput set-button-map "TPPS/2 IBM TrackPoint" 0 0 0 0 0                      

