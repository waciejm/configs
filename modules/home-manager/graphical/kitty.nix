{ config, lib, ...}: {
  options.custom.graphical.kitty = {
    enable = lib.mkEnableOption "kitty with custom configuration";
  };

  config = let
    cfg = config.custom.graphical.kitty;
  in lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = config.custom.shell.zsh.enable;
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
