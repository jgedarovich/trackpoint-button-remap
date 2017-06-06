with import <nixpkgs> {};
{ stdenv, fetchgit, perl }:

stdenv.mkDerivation {
  name = "tpremap";

  src = fetchgit {
    url= "https://github.com/jgedarovich/trackpoint-button-remap.git";
    rev = "b6113055a17908e5d5c682a9890b375e9a28a038";
  };

  buildInputs = [ python3 python35Packages.evdev python35Packages.python-uinput ];

  installPhase = ''
    bash ./install.sh $out
  '';

}
