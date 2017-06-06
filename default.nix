with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "trackpointbuttonremap-0.0.0";
  
  src = fetchgit {
    url= "https://github.com/jgedarovich/trackpoint-button-remap.git";
    rev = "7295d1c1ec202cf12af2995ff9cee18c4527e5d3";
  };
  
  buildInputs = [ python3 python35Packages.evdev python35Packages.python-uinput ];

  meta = {
    description = "remap the thinkpad trackpoint mouse buttons to meta keys instead";
  };
}
