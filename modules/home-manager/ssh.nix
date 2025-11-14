{ config, lib, ... }:
{
  options.custom.ssh = {
    enable = lib.mkEnableOption "openssh with custom client configuration";
    enableIdentities = lib.mkEnableOption "identity files in ~/Keys";
    enableAgent = lib.mkEnableOption "ssh-agent and addKeysToAgent";
  };

  config =
    let
      cfg = config.custom.ssh;
    in
    lib.mkIf cfg.enable {

      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        matchBlocks = {
          "*" = {
            identityFile = lib.mkIf cfg.enableIdentities "${config.home.homeDirectory}/Keys/ssh_waciejm";
            addKeysToAgent = lib.mkIf cfg.enableAgent "yes";
          };
          "*.qed.ai" = {
            user = "mac1";
            identityFile = lib.mkIf cfg.enableIdentities "${config.home.homeDirectory}/Keys/ssh_mac1";
          };
        };
      };

      services.ssh-agent = lib.mkIf cfg.enableAgent {
        enable = true;
        enableZshIntegration = config.custom.shell.zsh.enable;
        enableNushellIntegration = config.custom.shell.nu.enable;
      };
    };
}
