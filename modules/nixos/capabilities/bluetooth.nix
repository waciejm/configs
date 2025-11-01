{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom.capabilities.bluetooth = {
    enable = lib.mkEnableOption "bluetooth and utils";
  };

  config =
    let
      cfg = config.custom.capabilities.bluetooth;
    in
    lib.mkIf cfg.enable {
      hardware.bluetooth.enable = true;
      environment.systemPackages = [ pkgs.bluetuith ];
    };
}
