{
  description = "Home and systems configurations for waciejm";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    configs-private.url = "github:waciejm/configs-private";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    fenix,
    ...
  }: let
    utils = import ./utils.nix;
    lib = nixpkgs.lib;
  in {
    homeConfigurations = import ./home/mkHomes.nix inputs;
    nixosConfigurations = import ./systems/mkSystems.nix inputs;

    packages = utils.forEachPlatform (
      platform: let
        pkgs = nixpkgs.legacyPackages."${platform}";
      in
        lib.packagesFromDirectoryRecursive {
          inherit (pkgs) callPackage;
          directory = ./packages;
        }
    );

    devShells = utils.forEachPlatform (
      platform: let
        pkgs = nixpkgs.legacyPackages."${platform}";
        fenixPkgs = fenix.packages."${platform}";
        selfPkgs = self.packages."${platform}";
        attrSetOfShellLists = lib.packagesFromDirectoryRecursive {
          callPackage = lib.callPackageWith (pkgs // {inherit fenixPkgs selfPkgs;});
          directory = ./shells;
        };
        listOfShells = builtins.concatLists (lib.attrValues attrSetOfShellLists);
      in
        builtins.listToAttrs listOfShells
    );

    formatter = utils.forEachPlatform (
      platform: nixpkgs.legacyPackages."${platform}".alejandra
    );
  };
}
