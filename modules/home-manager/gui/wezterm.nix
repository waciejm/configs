{ config, lib, ... }:
{
  options.custom.gui.wezterm = {
    enable = lib.mkEnableOption "wezterm with custom config";
  };

  config =
    let
      cfg = config.custom.gui.wezterm;
    in
    lib.mkIf cfg.enable {
      programs.wezterm = {
        enable = true;
        enableZshIntegration = config.custom.shell.zsh.enable;
        settings = {
          font = lib.generators.mkLuaInline ''wezterm.font("IosevkaTerm Nerd Font")'';
          font_size = 12.0;
          color_scheme = "Gruvbox dark, hard (base16)";
          enable_tab_bar = false;
          initial_cols = 300;
          initial_rows = 200;
          window_padding = {
            left = "10px";
            right = "10px";
            top = "10px";
            bottom = "10px";
          };
          set_environment_variables = {
            SHELL = config.home.sessionVariables.SHELL;
          };
        };
      };
    };
}
