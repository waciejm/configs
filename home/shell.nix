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

    starship = let
      gitModules = [
        "git_branch"
        "git_commit"
        "git_status"
        "git_state"
      ];
    in {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      settings = {
        format = let          
          vcs = lib.concatMapStrings (s: "\${custom.${s}}") (gitModules ++ [ "jj" ]);
        in ''
          $time$username$hostname$directory$cmd_duration
          $shell${vcs}$rust$python$package
          $shlvl$status[ » ](bold green)
        '';
        time = {
          disabled = false;
          format = "[$time ]($style)";
        };
        username = {
          disabled = false;
          show_always = true;
          format = "[$user]($style)";
        };
        hostname = {
          disabled = false;
          ssh_only = false;
          format = "[@$hostname ]($style)";
        };
        directory = {
          disabled = false;
          truncate_to_repo = false;
          format = "[$path]($style)[$read_only]($read_only_style) ";
        };
        cmd_duration = {
          disabled = false;
          min_time = 1000;
          show_milliseconds = true;
        };
        shell = {
          disabled = false;
          format = "[$indicator ]($style)";
        };
        custom = {
          jj = {
            description = "Show current jj status";
            shell = [ "sh" ];
            when = "jj root --ignore-working-copy";
            format = "on $output ";
            command = ''
              jj log --no-graph --color always --revisions @ --template '
                separate(" ",
                  change_id.shortest(8),
                  truncate_end(50, bookmarks, "…"),
                  label("separator", "|"),
                  concat(
                    if(conflict, label("conflict", " ")),
                    if(divergent, label("divergent", " ")),
                    if(immutable, " "),
                    if(hidden, "󰊠 "),
                  ),
                  if(empty, label("log commit empty", "(empty)")),
                  label(
                    separate(" ",
                      "log commit",
                      if(description.len() == 0 && empty, "empty"),
                      "description",
                      if(description.len() == 0, "placeholder"),
                    ),
                    coalesce(
                      truncate_end(72, description.first_line(), "…"),
                      "(no description set)",
                    ),
                  ),
                )
              '
            '';
          };
        }
        // lib.genAttrs gitModules (module: {
          description = "Show ${module} only if we're not in a jj repo";
          shell = [ "sh" ];
          when = "! jj root --ignore-working-copy";
          format = "($output )";
          command = "starship module ${module}";
        });
        git_branch = {
          disabled = false;
          when = "! jj root --ignore-working-copy";
        };
        git_commit = {
          disabled = false;
          when = "! jj root --ignore-working-copy";
        };
        git_status = {
          disabled = false;
          when = "! jj root --ignore-working-copy";
        };
        git_state = {
          disabled = false;
          when = "! jj root --ignore-working-copy";
        };
        shlvl = {
          disabled = false;
        };
        status = {
          disabled = false;
          format = "[$symbol $status]($style)";
        };
      };
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      options = ["--cmd cd"];
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

    atuin = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
  };

  home.packages = [
    pkgs.zsh-completions
  ];
}
