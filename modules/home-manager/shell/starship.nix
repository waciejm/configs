{ config, lib, ... }:
{
  options.custom.shell.starship = {
    enable = lib.mkEnableOption "starship with custom configuration";
  };

  config =
    let
      cfg = config.custom.shell.starship;
    in
    lib.mkIf cfg.enable {
      programs.starship = {
        enable = true;
        enableZshIntegration = config.custom.shell.zsh.enable;
        enableNushellIntegration = config.custom.shell.nu.enable;
        settings =
          let
            gitModules = [
              "git_branch"
              "git_commit"
              "git_status"
              "git_state"
            ];
          in
          {
            format =
              let
                vcs = lib.concatMapStrings (s: "\${custom.${s}}") (gitModules ++ [ "jj" ]);
              in
              ''
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
              min_time = 1;
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
                command =
                  let
                    bold = ''\e[1m'';
                    green = ''\e[32m'';
                    red = ''\e[31m'';
                    reset = ''\e[0m'';
                  in
                  ''
                    to_wc=$(jj log --count --revisions 'trunk()..@-')
                    if [ "''${to_wc}" -gt 0 ]; then
                      printf "${bold}%s${green}+${reset} " "''${to_wc}"
                    fi

                    to_trunk=$(jj log --ignore-working-copy --count --revisions '@..trunk()')
                    if [ "''${to_trunk}" -gt 0 ]; then
                      printf "${bold}%s${red}-${reset} " "''${to_trunk}"
                    fi

                    jj log --ignore-working-copy --no-graph --color always --revisions @ --template '
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
            shlvl = {
              disabled = false;
            };
            status = {
              disabled = false;
              format = "[$symbol $status]($style)";
            };
          };
      };
    };
}
