{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.waciejm.graphical {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      theme = "purple";
      extraConfig = {
        show-icons = true;
      };
    };
  };
}
