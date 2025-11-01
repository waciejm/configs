{
  config,
  lib,
  pkgs,
  nixpkgsFlake,
  ...
}:
{
  options.custom.nix = {
    enable = lib.mkEnableOption "custom nix configuration";
  };

  config =
    let
      cfg = config.custom.nix;
    in
    lib.mkIf cfg.enable {

      nix = {
        package = pkgs.lix;
        registry.nixpkgs = {
          from = {
            id = "nixpkgs";
            type = "indirect";
          };
          flake = nixpkgsFlake;
        };
        settings = {
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          trusted-users = [
            "root"
            "@wheel"
          ];
        };
      };

      nixpkgs.config = {
        allowUnfree = true;
        hostPlatform = "x86_64-linux";
      };
    };
}
