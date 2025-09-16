{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.waciejm.graphical {
    programs.rofi = {
      enable = true;
      theme = "purple";
      extraConfig = {
        show-icons = true;
      };
    };
  };
}
