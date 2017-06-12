from evdev import InputDevice, categorize, ecodes

for i in range(0,15):
    dev = InputDevice('/dev/input/event{}'.format(i))
    print(dev)
