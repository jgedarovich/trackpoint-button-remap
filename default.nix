with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "trackpointbuttonremap-0.0.0";
  
  src = fetchgit {
    url= "https://github.com/jgedarovich/trackpoint-button-remap.git";
    rev = "d0f30aae908a90d940c04c1db88f5937e36e3bba";
  };
  
  buildInputs = [ python3 python35Packages.evdev python35Packages.python-uinput ];

  postInstall = ''
    cp -v etc/systemd/system/* $out/etc/systemd/system/
    cp -v etc/udev/rules.d/* $out/etc/udev/rules.d/
    '';

  meta = {
    description = "remap the thinkpad trackpoint mouse buttons to meta keys instead";
  };
}
