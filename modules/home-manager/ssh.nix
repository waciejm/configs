{ config, lib, ... }:
{
  options.custom.ssh = {
    enable = lib.mkEnableOption "openssh with custom client configuration";
    enableIdentities = lib.mkEnableOption "identity files in ~/Keys";
  };

  config =
    let
      cfg = config.custom.ssh;
    in
    lib.mkIf cfg.enable {

      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings = lib.mkIf cfg.enableIdentities {
          "*" = {
            identityFile = "${config.home.homeDirectory}/Keys/ssh_waciejm";
            addKeysToAgent = "yes";
            serverAliveInterval = "10";
            serverAliveCountMax = "3";
          };
          "*.qed.ai" = {
            user = "mac1";
            identityFile = "${config.home.homeDirectory}/Keys/ssh_mac1";
          };
        };
      };
    };
}
