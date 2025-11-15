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

      nixpkgs = {
        config = {
          allowUnfree = true;
          hostPlatform = "x86_64-linux";
        };
        # temporary workaroud for cosmic-session exporting wrong path to ssh agent
        overlays = [
          (final: prev: {
            cosmic-session = prev.cosmic-session.overrideAttrs (old: {
              postPatch = old.postPatch + ''
                substituteInPlace data/start-cosmic --replace-fail \
                  'export SSH_AUTH_SOCK="/run/user/$(id -u)/keyring/ssh"' \
                  'export SSH_AUTH_SOCK="/run/user/$(id -u)/gcr/ssh"'
              '';
            });
          })
        ];
      };
    };
}
