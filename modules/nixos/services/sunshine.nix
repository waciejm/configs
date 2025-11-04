{ config, lib, ... }:
{
  options.custom.services.sunshine = {
    enable = lib.mkEnableOption "sunshine game streaming";
  };

  config =
    let
      cfg = config.custom.services.sunshine;
    in
    lib.mkIf cfg.enable {

      services.sunshine = {
        enable = true;
        autoStart = false;
        capSysAdmin = true;
      };
    };
}
