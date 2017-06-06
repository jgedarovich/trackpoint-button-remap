with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "tpremap";

  src = fetchgit {
    url= "https://github.com/jgedarovich/trackpoint-button-remap.git";
    rev = "bf93dfa1178fecb2600b4cd86b0faf4c1a1dbb49";
  };

  buildInputs = [ python3 python35Packages.evdev python35Packages.python-uinput ];

  installPhase = ''
    bash ./setup.sh $out
  '';

}
