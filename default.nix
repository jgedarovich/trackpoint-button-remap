with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "trackpointbuttonremap-0.0.0";
  
  src = fetchgit {
    url= "https://github.com/jgedarovich/trackpoint-button-remap.git";
    rev = "ab719683062ab00accb531c533c97e00a8b569c5";
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
