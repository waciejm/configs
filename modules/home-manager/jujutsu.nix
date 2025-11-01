{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.custom.jujutsu = {
    enable = lib.mkEnableOption "jujutsu with custom configuration";
  };

  config =
    let
      cfg = config.custom.jujutsu;
    in
    lib.mkIf cfg.enable {
      programs.jujutsu = {
        enable = true;
        settings = {
          user = {
            name = "Maciej Wojno";
            email = "git@mwojno.me";
          };
          ui = {
            default-command = "log";
            pager = "less -FRX";
            diff-editor = ":builtin";
            diff-formatter = [
              "difft"
              "--color=always"
              "$left"
              "$right"
            ];
          };
          "--scope" = [
            {
              "--when".repositories = [ "~/qed" ];
              user.email = "mac1@qed.ai";
              templates.commit_trailers = ''if(!trailers.contains_key("Change-Id"), format_gerrit_change_id_trailer(self))'';
            }
          ];
        };
      };
      home.packages = [ pkgs.difftastic ];
    };
}
