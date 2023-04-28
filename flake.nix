{
  description = "Home and systems configurations for waciejm";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    configs-private.url = "github:waciejm/configs-private";
  };

  outputs = inputs @ {home-manager, ...}: let
    utils = import ./utils.nix;
  in {
    packages = import ./mkScripts.nix home-manager;

    homeConfigurations = import ./home/mkHomes.nix home-manager;

    nixosConfigurations = import ./systems/mkSystems.nix inputs;

    formatter = utils.forEachPlatform (
      platform:
        home-manager.inputs.nixpkgs.legacyPackages."${platform}".alejandra
    );
  };
}
