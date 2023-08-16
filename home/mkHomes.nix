{
  home-manager,
  nixpkgs,
  nixpkgs-stable,
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
        pkgs-stable = nixpkgs-stable.legacyPackages."${platform}";
      };
      modules = [
        ./${system}/home.nix
      ];
    })
