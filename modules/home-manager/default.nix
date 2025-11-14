{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    # keep-sorted start
    ./git.nix
    ./gui
    ./helix.nix
    ./jujutsu.nix
    ./nix.nix
    ./rip.nix
    ./shell
    ./ssh.nix
    # keep-sorted end
  ];

  options.custom.my-home-manager-configuration = {
    enable = lib.mkEnableOption "my home-manager configuration for specified user";
    pc = lib.mkEnableOption "GUI and other components for personal PCs";
    username = lib.mkOption {
      type = lib.types.str;
      default = "waciejm";
    };
  };

  config =
    let
      cfg = config.custom.my-home-manager-configuration;
    in
    lib.mkIf cfg.enable {

      custom = {
        # keep-sorted start block=yes
        git.enable = true;
        gui = lib.mkIf cfg.pc {
          # keep-sorted start block=yes
          kitty.enable = true;
          rofi.enable = true;
          theming.enable = true;
          wezterm.enable = true;
          # keep-sorted end
        };
        helix.enable = true;
        jujutsu.enable = true;
        nix.enable = true;
        rip.enable = true;
        shell = {
          # keep-sorted start block=yes
          atuin.enable = cfg.pc;
          nu.enable = true;
          starship.enable = true;
          yazi.enable = true;
          zoxide.enable = true;
          zsh.enable = true;
          # keep-sorted end
        };
        ssh = {
          enable = true;
          enableIdentities = cfg.pc;
        };
        # keep-sorted end
      };

      programs.home-manager.enable = true;

      home = {
        stateVersion = "22.11";
        username = cfg.username;
        homeDirectory = "/home/${cfg.username}";
      };

      home.packages = builtins.attrValues {
        inherit (pkgs)
          # keep-sorted start
          age
          amber
          bat
          bottom
          cyme
          dive
          dust
          eza
          fd
          ffmpeg
          glow
          gzip
          htop
          inotify-tools
          jless
          just
          mediainfo
          mergiraf
          mpv
          nil
          nix-output-monitor
          ripgrep
          rsync
          sops
          taplo
          tdf
          unzip
          viu
          yt-dlp
          zip
          # keep-sorted end
          ;
      };
    };
}
