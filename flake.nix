{
  description = "Home and systems configurations for waciejm";

  inputs = {
    # keep-sorted start block=yes
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
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # keep-sorted end
  };

  outputs =
    inputs@{
      # keep-sorted start
      configs-private,
      deploy-rs,
      fenix,
      home-manager,
      nixpkgs,
      self,
      treefmt-nix,
      # keep-sorted end
      ...
    }:
    let
      utils = import ./utils.nix;
      lib = nixpkgs.lib;
      treefmtEval = utils.forEachPlatform (
        platform: (treefmt-nix.lib.evalModule nixpkgs.legacyPackages.${platform} ./treefmt.nix)
      );
    in
    {
      nixosConfigurations = import ./systems/mkSystems.nix inputs;

      homeConfigurations = utils.forEachPlatform (
        platform:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."${platform}";
          extraSpecialArgs = {
            nixpkgsFlake = nixpkgs;
            selfFlake = self;
          };
          modules = [
            ./modules/home-manager/default.nix
            { custom.my-home-manager-configuration.enable = true; }
          ];
        }
      );

      devShells = utils.forEachPlatform (
        platform:
        let
          pkgs = nixpkgs.legacyPackages.${platform};
          fenixPkgs = fenix.packages.${platform};
          attrSetOfShellLists = lib.packagesFromDirectoryRecursive {
            callPackage = lib.callPackageWith (pkgs // { inherit fenixPkgs; });
            directory = ./shells;
          };
          listOfShells = builtins.concatLists (lib.attrValues attrSetOfShellLists);
        in
        builtins.listToAttrs listOfShells
      );

      apps = utils.forEachPlatform (platform: {
        deploy = deploy-rs.apps.${platform}.default;
      });

      formatter = utils.forEachPlatform (platform: treefmtEval.${platform}.config.build.wrapper);

      checks = utils.forEachPlatform (
        platform:
        {
          formatting = treefmtEval.${platform}.config.build.check self;
        }
        // deploy-rs.lib.${platform}.deployChecks self.deploy
      );

      deploy.nodes.bolek = {
        hostname = self.nixosConfigurations.bolek.config.networking.fqdn;
        user = "root";
        profiles.system.path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.bolek;
      };
    };
}
