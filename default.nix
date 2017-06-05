with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "trackpointRemapKeys-0.0.0";
  
  src = fetchgit {
    url= "https://github.com/jgedarovich/trackpoint-button-remap.git";
    rev = "9ebda55a8185fb96c04d253ee123480bf8129deb";
  };
  
  buildInputs = [ python3 python35Packages.evdev python35Packages.python-uinput ];

  meta = {
    description = "remap the thinkpad trackpoint mouse buttons to meta keys instead";
  };

  systemd.services.trackpoint-button-remap = {
      description = "remap lenovo x1 carbon buttons to metas";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      #path = cfg.packages;
      serviceConfig = {
        Type = "simple";
        ExecStart = ''
            ${pkgs.trackpoint-button-remap}/bin/trackpoint-button-remap
            '';
      };
  };
}
