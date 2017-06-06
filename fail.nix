with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "trackpointbuttonremap-0.0.0";
  
  src = fetchgit {
    url= "https://github.com/jgedarovich/trackpoint-button-remap.git";
    rev = "6706e3abe5df0090be4b02c521c36b64e8c72117";
  };
  
  buildInputs = [ python3 python35Packages.evdev python35Packages.python-uinput ];

  installPhase = ''
      pwd
      ls -lrta
      mkdir -p $out
      cp -R * $out/
      ls -lrta $out/
      ls -lrta $out/
    '';

  meta = {
    description = "remap the thinkpad trackpoint mouse buttons to meta keys instead";
  };
}
