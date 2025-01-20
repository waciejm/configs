{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Maciej Wojno";
        email = "jj@mwojno.me";
      };
      ui = {
        default-command = "log";
        pager = "less -FRX";
        diff-editor = ":builtin";
      };
    };
  };
}
