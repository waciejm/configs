{
  description = "Home and systems configurations for waciejm";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    configs-private.url = "github:waciejm/configs-private";
  };

  outputs = inputs @ {
    nixpkgs,
    ...
  }: let
    utils = import ./utils.nix;
  in {
    homeConfigurations = import ./home/mkHomes.nix inputs;
    nixosConfigurations = import ./systems/mkSystems.nix inputs;

    formatter = utils.forEachPlatform (
      platform:
        nixpkgs.legacyPackages."${platform}".alejandra
    );
  };
}
