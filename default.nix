with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "tpremap";

  src = ./tpbr.tar.gz;

  buildInputs = [ 
    libevdev
    # With Python configuration requiring a special wrapper
    (python3.buildEnv.override {
      ignoreCollisions = true;
      extraLibs = with python3Packages; [
        python
        evdev
        python-uinput
      ];
    })
  ];

  installPhase = ''
    install -D 94-trackpoint.rules $out/etc/udev/rules.d/94-trackpoint.rules
    install -D 93-trackpoint.conf.rules $out/etc/udev/rules.d/93-trackpoint.conf.rules
    bash ./setup.sh $out
  '';

}
