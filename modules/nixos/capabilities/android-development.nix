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
      ];

      programs.adb.enable = true;

      users = lib.mkIf config.custom.users.enable {
        groups.adbusers.members = [ config.custom.users.username ];
      };

      services.udev.extraRules = lib.mkIf config.custom.users.enable ''
        SUBSYSTEM=="usb", ATTR{idVendor}=="1782", ATTR{idProduct}=="4003", MODE="0666", GROUP="adbusers"
      '';
    };
}
