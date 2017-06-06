with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "tpremap";

  src = fetchgit {
    url= "https://github.com/jgedarovich/trackpoint-button-remap.git";
    rev = "c68f5bf60683f0365625f3e3ef351e0ef4ef4515";
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
    bash ./setup.sh $out
  '';

}
