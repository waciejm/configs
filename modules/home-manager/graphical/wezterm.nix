{ config, lib, ... }:
{
  options.custom.graphical.wezterm = {
    enable = lib.mkEnableOption "wezterm with custom config";
  };

  config =
    let
      cfg = config.custom.graphical.wezterm;
    in
    lib.mkIf cfg.enable {
      programs.wezterm = {
        enable = true;
        enableZshIntegration = config.custom.shell.zsh.enable;
        extraConfig = ''
          local config = wezterm.config_builder()

          config.font = wezterm.font 'IosevkaTerm Nerd Font'
          config.font_size = 12.0

          config.color_scheme = 'Gruvbox dark, hard (base16)'

          config.enable_tab_bar = false

          config.window_padding = { left = '4px', right = '4px', top = '4px', bottom = '4px' }

          return config
        '';
      };
    };
}
