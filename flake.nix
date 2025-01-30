{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    swww = {
      url = "github:LGFae/swww";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    hyprpanel,
    ...
  }: let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      yycholla = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix

          {nixpkgs.overlays = [inputs.hyprpanel.overlay];}

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.yycholla = import ./home.nix;
          }
        ];
        specialArgs = {
          inherit inputs;
          inherit system;
        };
      };
    };
  };
}
