{ config, lib, ... }:
{
  options.custom.terminal.git = {
    enable = lib.mkEnableOption "git with custom configuration";
  };

  config =
    let
      cfg = config.custom.terminal.git;
    in
    lib.mkIf cfg.enable {
      programs.git = {
        enable = true;
        settings = {
          init.defaultBranch = "main";
          pull.rebase = true;
          safe.directory = [ "*" ];
        };
        includes = [
          {
            contentSuffix = "config_personal";
            contents.user = {
              email = "git@mwojno.me";
              name = "Maciej Wojno";
            };
          }
          {
            condition = "gitdir:~/qed/";
            contentSuffix = "config_qed";
            contents.user.email = "mac1@qed.ai";
          }
        ];
      };
    };
}
