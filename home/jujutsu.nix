{
  programs.jujutsu = {
    enable = true;
    settings = {
      "--scope" = [
        {
          "--when".repositories = ["~/qed"];
          user.email = "mac1@qed.ai";
        }
      ];
      user = {
        name = "Maciej Wojno";
        email = "git@mwojno.me";
      };
      ui = {
        default-command = "log";
        pager = "less -FRX";
        diff-editor = ":builtin";
        diff-formatter = ["difft" "--color=always" "$left" "$right"];
      };
      git.write-change-id-header = true;
    };
  };
}
