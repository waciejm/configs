{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom.capabilities.android-development = {
    enable = lib.mkEnableOption "utilities for android development";
  };

  config =
    let
      cfg = config.custom.capabilities.android-development;
    in
    lib.mkIf cfg.enable {

      environment.systemPackages = [
        pkgs.android-studio
        pkgs.android-tools
      ];

    };
}
