{ config, lib, ... }:
{
  options.custom.shell.carapace = {
    enable = lib.mkEnableOption "carapace with custom configuration";
  };

  config =
    let
      cfg = config.custom.shell.carapace;
    in
    lib.mkIf cfg.enable {
      programs.carapace = {
        enable = true;
        enableZshIntegration = config.custom.shell.zsh.enable;
        enableNushellIntegration = config.custom.shell.nu.enable;
      };
    };
}
