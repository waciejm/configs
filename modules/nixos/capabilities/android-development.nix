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

      services.udev.extraRules = ''
        SUBSYSTEM=="usb", ATTRS{idVendor}=="18d1", ATTRS{idProduct}=="2d00", MODE="0660", GROUP="users", TAG+="uaccess"
        SUBSYSTEM=="usb", ATTRS{idVendor}=="18d1", ATTRS{idProduct}=="2d01", MODE="0660", GROUP="users", TAG+="uaccess"
      '';
    };
}
