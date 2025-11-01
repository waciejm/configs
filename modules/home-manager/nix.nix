{
  config,
  lib,
  pkgs,
  nixpkgsFlake,
  selfFlake,
  osConfig ? null,
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
        package = lib.mkDefault pkgs.lix;
        settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
        registry = {
          nixpkgs = lib.mkIf (nixpkgsFlake != null) {
            flake = nixpkgsFlake;
            from = {
              id = "n";
              type = "indirect";
            };
          };
          config = lib.mkIf (selfFlake != null) {
            flake = selfFlake;
            from = {
              id = "c";
              type = "indirect";
            };
          };
        };
      };

      nixpkgs.config = lib.mkIf (osConfig == null) {
        allowUnfree = true;
      };

      home.sessionVariables.NIX_USER_CONF_FILES = lib.concatStringsSep ":" [
        "${config.xdg.configHome}/nix/nix.conf"
        "${config.home.homeDirectory}/Keys/nix-github-access.conf"
      ];
    };
}
