let
  mach-nix = import (builtins.fetchTarball {
    url = "https://github.com/DavHau/mach-nix/tarball/3.3.0";
  });
in
{
  environment.systemPackages = with pkgs; [
    (mach-nix.mkPython {
      packages = p: [ p.pyprland ];
    })
  ];
}

