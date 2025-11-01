{ config, lib, ... }:
{
  options.custom.gui.rofi = {
    enable = lib.mkEnableOption "rofi with custom configuration";
  };

  config =
    let
      cfg = config.custom.gui.rofi;
    in
    lib.mkIf cfg.enable {
      programs.rofi = {
        enable = true;
        theme = "purple";
        extraConfig = {
          show-icons = true;
        };
      };
    };
}
