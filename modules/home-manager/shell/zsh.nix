{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.custom.shell.zsh = {
    enable = lib.mkEnableOption "zsh with custom config";
  };

  config =
    let
      cfg = config.custom.shell.zsh;
    in
    lib.mkIf cfg.enable {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
          # lsd
          l = "ls -l";
          ll = "ls -lA";
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

      home.packages = [ pkgs.zsh-completions ];
    };
}
