{
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
      };
      git.write-change-id-header = true;
    };
  };
}
