{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
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
      };
    in {
      nixosConfigurations = {
        yycholla = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system; };

	modules = [
          ./nixos/configuration.nix
	];
	};
      };
    };
}
