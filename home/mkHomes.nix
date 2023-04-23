{
  nixpkgs-unstable,
  home-manager,
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
      pkgs = nixpkgs-unstable.legacyPackages."${platform}";
      modules = [
        ./${system}/home.nix
      ];
    })
