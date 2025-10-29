{ config, lib, ... }:
{
  options.custom.shell.zoxide = {
    enable = lib.mkEnableOption "zoxide with custom configuration";
  };

  config =
    let
      cfg = config.custom.shell.zoxide;
    in
    lib.mkIf cfg.enable {
      programs.zoxide = {
        enable = true;
        enableZshIntegration = config.custom.shell.zsh.enable;
        enableNushellIntegration = config.custom.shell.nu.enable;
      };
    };
}
