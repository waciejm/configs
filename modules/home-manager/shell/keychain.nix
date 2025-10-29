{ config, lib, ... }:
{
  options.custom.shell.keychain = {
    enable = lib.mkEnableOption "keychain with custom configuration";
  };

  config =
    let
      cfg = config.custom.shell.keychain;
    in
    lib.mkIf cfg.enable {
      programs.keychain = {
        enable = true;
        enableZshIntegration = config.custom.shell.zsh.enable;
        enableNushellIntegration = config.custom.shell.nu.enable;
        keys = [
          "${config.home.homeDirectory}/Keys/ssh_waciejm"
          "${config.home.homeDirectory}/Keys/ssh_mac1"
        ];
      };
    };
}
