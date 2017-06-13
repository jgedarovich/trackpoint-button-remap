with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "tpremap";

  src = fetchgit {
    url= "https://github.com/jgedarovich/trackpoint-button-remap.git";
    rev = "35543efd3e5fc5fbffd88124b4140ea3b4eb8c60";
  };

  buildInputs = [ 
    libevdev
    # With Python configuration requiring a special wrapper
    (python35.buildEnv.override {
      ignoreCollisions = true;
      extraLibs = with python35Packages; [
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
