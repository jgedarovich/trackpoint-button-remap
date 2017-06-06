with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "trackpointbuttonremap-0.0.0";
  
  src = fetchgit {
    url= "https://github.com/jgedarovich/trackpoint-button-remap.git";
    rev = "9dd2becda5e9fc3282fffb535b41aae0a1dda8b2";
  };
  
  buildInputs = [ python3 python35Packages.evdev python35Packages.python-uinput ];

  meta = {
    description = "remap the thinkpad trackpoint mouse buttons to meta keys instead";
  };
}
