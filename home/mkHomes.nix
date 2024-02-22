{
  self,
  nixpkgs,
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
      pkgs = nixpkgs.legacyPackages."${platform}";
      extraSpecialArgs = {
        inherit self nixpkgs;
      };
      modules = [
        ./${system}/home.nix
      ];
    })
