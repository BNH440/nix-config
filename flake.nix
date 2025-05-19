{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    stylix.url = "github:danth/stylix";
    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
      overlays = [
        inputs.hyprpanel.overlay
      ];
    };
  in {
    nixosConfigurations."bnh440-pc" = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs pkgs; };
      modules = [
        ./hosts/bnh440-pc/configuration.nix
        inputs.nix-flatpak.nixosModules.nix-flatpak
        inputs.stylix.nixosModules.stylix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs  = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs pkgs; };
          home-manager.users.blakeh     = import ./home/blakeh/home.nix;
          home-manager.backupFileExtension = "backup";
        }
      ];
    };
  };
}
