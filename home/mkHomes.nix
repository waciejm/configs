{
  home-manager,
  nixpkgs,
  ...
}: let
  utils = import ../utils.nix;
  mkHomeConfigName = arch: system: "waciejm-${arch}-${system}";
in
  utils.forEachPlatformImpl mkHomeConfigName ({
    platform,
    system,
    ...
  }:
    home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."${platform}";
      extraSpecialArgs = {
        inherit nixpkgs;
      };
      modules = [
        ./${system}/home.nix
      ];
    })
