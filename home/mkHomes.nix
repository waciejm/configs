home-manager: let
  utils = import ../utils.nix;
  mkHomeConfigName = arch: system: "waciejm-${arch}-${system}";
in
  utils.forEachPlatformImpl mkHomeConfigName ({
    platform,
    system,
    ...
  }:
    home-manager.lib.homeManagerConfiguration {
      pkgs = home-manager.inputs.nixpkgs.legacyPackages."${platform}";
      extraSpecialArgs = {
        nixpkgs-flake = home-manager.inputs.nixpkgs;
      };
      modules = [
        ./${system}/home.nix
      ];
    })
