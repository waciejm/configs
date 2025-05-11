{
  description = "Home and systems configurations for waciejm";

  inputs = {
    arion = {
      url = "github:hercules-ci/arion";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    configs-private.url = "github:waciejm/configs-private";
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-analyzer-src.follows = "";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    fenix,
    configs-private,
    deploy-rs,
    ...
  }: let
    utils = import ./utils.nix;
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = import ./systems/mkSystems.nix inputs;

    deploy.nodes.bolek = {
      hostname = self.nixosConfigurations.bolek.config.networking.fqdn;
      user = "root";
      profiles.system.path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.bolek;
    };

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

    apps = utils.forEachPlatform (
      platform: {
        deploy = deploy-rs.apps.${platform}.default;
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

    checks = utils.forEachPlatform (
      platform: deploy-rs.lib.${platform}.deployChecks self.deploy
    );
  };
}
