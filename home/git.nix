{
  programs.git = {
    enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
      safe = {
        directory = ["*"];
      };
    };
    includes = [
      {
        contentSuffix = "config_personal";
        contents = {
          user = {
            email = "git@mwojno.me";
            name = "Maciej Wojno";
          };
        };
      }
      {
        condition = "gitdir:~/qed/";
        contentSuffix = "config_qed";
        contents = {
          user = {
            email = "mac1@qed.ai";
            name = "Maciej Wojno";
          };
        };
      }
    ];
  };
}
