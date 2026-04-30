{ config, lib, pkgs, ... }:
{
  options.custom.gpg = {
    enable = lib.mkEnableOption "gnupg with custom homedir";
  };

  config =
    let
      cfg = config.custom.gpg;
    in
    lib.mkIf cfg.enable {

      programs.gpg = {
        enable = true;
      };

      services.gpg-agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-curses;
        enableZshIntegration = config.custom.shell.zsh.enable;
        enableNushellIntegration = config.custom.shell.nu.enable;
      };
    };
}
