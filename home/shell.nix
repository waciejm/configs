{
  pkgs,
  lib,
  ...
}: {
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      historySubstringSearch.enable = true;
      history = {
        path = "$HOME/.zhistory";
        size = 100000;
        save = 100000;
        share = true;
      };
      shellAliases = {
        # lsd
        l = "lsd -l";
        ls = "lsd";
        la = "lsd -lA";
        # git
        glog = "git log --all --oneline --graph";
        gc = "git commit";
        gca = "git commit --amend";
        gch = "git checkout";
        gaa = "git add .";
        gr = "git review";
        gs = "git status";
        gd = "git diff";
        # sops
        homesops = "SOPS_AGE_KEY=$(age -d ~/Keys/homeops.age) sops";
        # nix
        ns = "nix shell";
        nd = "nix develop";
      };
      initContent = ''
        # dev shells
        ds() {
        	nix develop "c#shell-$1" -c zsh
        }

        # Disable terminal controls bound by default to ^Q ^S ^U ^O ^V ^R ^W
        stty start undef stop undef kill undef
        stty discard undef lnext undef rprnt undef werase undef
      '';
    };

    nushell = {
      enable = true;
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      settings = {
        format = ''
          $time$username$hostname$directory$cmd_duration
          $git_branch$git_status$git_state$rust$python$package
          $shlvl$status[ » ](bold green)
        '';
        username = {
          show_always = true;
          format = "[$user]($style)";
        };
        hostname = {
          ssh_only = false;
          format = "[@$hostname ]($style)";
        };
        time = {
          disabled = false;
          format = "[$time ]($style)";
        };
        directory = {
          truncate_to_repo = false;
          format = "[$path]($style)[$read_only]($read_only_style) ";
        };
        cmd_duration = {
          min_time = 1000;
        };
        status = {
          disabled = false;
          format = "[$symbol $status]($style)";
        };
        shlvl = {
          disabled = false;
        };
      };
    };

    zoxide = {
      enable = true;
      options = ["--cmd cd"];
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };

    keychain = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      keys = [
        "~/Keys/ssh_waciejm"
        "~/Keys/ssh_mac1"
      ];
    };
  };

  home.packages = [
    pkgs.zsh-completions
  ];
}
