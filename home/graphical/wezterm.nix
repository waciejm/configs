{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.waciejm.graphical {
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
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
