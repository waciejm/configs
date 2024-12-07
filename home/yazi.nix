{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    shellWrapperName = "yy";
    plugins = {
      open-with-cmd = pkgs.fetchFromGitHub {
        owner = "Ape";
        repo = "open-with-cmd.yazi";
        rev = "8d7abc8a347bfa065b6d339d26480f6fdcfac37e";
        hash = "sha256-tUxdxOk2Dm2S/KRpc87aIEWU3SzQNm2/RaVT2Z1dqgQ=";
      };
    };
    keymap = {
      manager.prepend_keymap = [
        {
          desc = "Open with command in terminal";
          on = "o";
          run = "plugin open-with-cmd --args=block";
        }
        {
          desc = "Open with command in background";
          on = "O";
          run = "plugin open-with-cmd";
        }
        {
          desc = "Trash with rip";
          on = "d";
          run = "shell --confirm \"rip \\\"$@\\\"\"";
        }
        {
          desc = "Undo trash with rip";
          on = "D";
          run = "shell --confirm \"rip -u\"";
        }
      ];
    };
  };
}
