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
    hyprpanel.url = "github:jas-singhfsu/hyprpanel";
  };

  outputs = { self, nixpkgs, home-manager, nix-flatpak, stylix, hyprpanel, ... }: {
    nixosConfigurations = {
      nixos-vm = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./hosts/nixos-vm/configuration.nix
          nix-flatpak.nixosModules.nix-flatpak
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.blakeh = import ./home/blakeh/home.nix;
          }
          {nixpkgs.overlays = [hyprpanel.overlay];}
        ];
      };
    };
  };
}
