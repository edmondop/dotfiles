{
  description = "Edmondo NixOS configuration";

 inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    stylix.url = "github:danth/stylix";
    mach-nix.url = "github:DavHau/mach-nix/3.3.0";
  };

  outputs = { self, nixpkgs, stylix, ... }@inputs: {


    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        stylix.nixosModules.stylix
        ./configuration.nix
        ./pyprland.nix
      ];
    };

  };
}
