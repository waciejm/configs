{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.waciejm.graphical {
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      themeFile = "gruvbox-dark-hard";
      font = {
        name = "IosevkaTerm Nerd Font";
        size = 12.0;
      };
      settings = {
        window_padding_width = 4;
      };
    };
  };
}
