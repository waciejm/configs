{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom.capabilities.python-development = {
    enable = lib.mkEnableOption "utilities for python development";
  };

  config =
    let
      cfg = config.custom.capabilities.python-development;
    in
    lib.mkIf cfg.enable {

      environment.systemPackages = [
        pkgs.python3
        pkgs.uv
        pkgs.jetbrains.pycharm
      ];
    };
}
