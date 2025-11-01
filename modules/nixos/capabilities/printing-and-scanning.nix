{ config, lib, ... }:
{
  options.custom.capabilities.printing-and-scanning = {
    enable = lib.mkEnableOption "printer and scanner support";
  };

  config =
    let
      cfg = config.custom.capabilities.printing-and-scanning;
    in
    lib.mkIf cfg.enable {

      services.printing.enable = true;

      hardware.sane.enable = true;

      users = lib.mkIf config.custom.users.enable {
        users.${config.custom.users.username}.extraGroups = [
          "scanner"
          "lp"
        ];
      };
    };
}
