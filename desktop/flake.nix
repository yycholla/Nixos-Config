#
{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    zen-browser.url = "github:MarceColl/zen-browser-flake";

    nvf.url = "github:notashelf/nvf";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    catppuccin,
    home-manager,
    zen-browser,
    nvf,
    ...
  } @ inputs: {
    nixosConfigurations.yycholla-nixd = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};

      modules = [
        nvf.nixosModules.default
        ./configuration.nix

        catppuccin.nixosModules.catppuccin
        {
          home-manager = {
            useGlobalPkgs = true;
            backupFileExtension = "HMBackup";
            useUserPackages = true;
            users.yycholla = {
              imports = [../home.nix catppuccin.homeManagerModules.catppuccin];
            };
          };

          home-manager.extraSpecialArgs = {
            inherit inputs;
            system = "x86_64-linux";
          };
        }
      ];
    };
  };
}
