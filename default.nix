with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "trackpointbuttonremap-0.0.0";
  
  src = fetchgit {
    url= "https://github.com/jgedarovich/trackpoint-button-remap.git";
    rev = "6e500897f93a54a17e60d1b6b27bf7edd94491c1";
  };
  
  buildInputs = [ python3 python35Packages.evdev python35Packages.python-uinput ];

  meta = {
    description = "remap the thinkpad trackpoint mouse buttons to meta keys instead";
  };
}
