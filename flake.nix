{
  description = "Home and systems configurations for waciejm";

  inputs = {
    nixpkgs.follows = "nixos-cosmic/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    configs-private.url = "github:waciejm/configs-private";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    fenix,
    configs-private,
    ...
  }: let
    utils = import ./utils.nix;
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = import ./systems/mkSystems.nix inputs;

    homeConfigurations = utils.forEachPlatform (
      platform: let
        selfPkgs = self.packages."${platform}";
      in
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."${platform}";
          extraSpecialArgs = {inherit self nixpkgs configs-private selfPkgs;};
          modules = [./home/default.nix];
        }
    );

    packages = utils.forEachPlatform (
      platform: let
        pkgs = nixpkgs.legacyPackages."${platform}";
        selfPkgs = lib.packagesFromDirectoryRecursive {
          inherit (pkgs) callPackage;
          directory = ./packages;
        };
        privatePkgs = configs-private.mkPackages pkgs;
      in
        selfPkgs // privatePkgs
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

    templates = import ./templates/mkTemplates.nix;
  };
}
