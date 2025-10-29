{ config, lib, ...}: {
  options.custom.shell.atuin = {
    enable = lib.mkEnableOption "atuin with custom configuration";
  };

  config = let
    cfg = config.custom.shell.atuin;
  in lib.mkIf cfg.enable {
    programs.atuin = {
      enable = true;
      enableZshIntegration = config.custom.shell.zsh.enable;
      enableNushellIntegration = config.custom.shell.nu.enable;
      settings = {
        style = "compact";
        inline_height = 15;
        enter_accept = true;
        filter_mode_shell_up_key_binding = "directory";
      };
    };
  };
}
