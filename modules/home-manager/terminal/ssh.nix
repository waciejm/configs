{ config, lib, ... }:
{
  options.custom.terminal.ssh = {
    enable = lib.mkEnableOption "openssh with custom client configuration";
    enableIdentities = lib.mkEnableOption "identity files in ~/Keys";
  };

  config =
    let
      cfg = config.custom.terminal.ssh;
    in
    lib.mkIf cfg.enable {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        matchBlocks = lib.mkIf cfg.enableIdentities {
          "*" = {
            identityFile = "${config.home.homeDirectory}/Keys/ssh_waciejm";
          };
          "*.qed.ai" = {
            user = "mac1";
            identityFile = "${config.home.homeDirectory}/Keys/ssh_mac1";
          };
        };
      };
    };
}
