{
  config,
  lib,
  ...
}:
{
  imports = [
    # keep-sorted start
    ./assertions
    ./capabilities
    ./nix.nix
    ./services
    ./users.nix
    # keep-sorted end
  ];

  options.custom.my-nixos-configuration = {
    enable = lib.mkEnableOption "parts of my NixOS configuration common to all systems";
    hostName = lib.mkOption {
      type = lib.types.str;
      description = "system hostname";
    };
    hashedUserPassword = lib.mkOption {
      type = lib.types.str;
    };
    sshAuthorizedKeyFiles = lib.mkOption {
      type = lib.types.listOf lib.types.path;
    };
  };

  config =
    let
      cfg = config.custom.my-nixos-configuration;
    in
    lib.mkIf cfg.enable {

      time.timeZone = "Europe/Warsaw";

      i18n = {
        defaultLocale = "en_US.UTF-8";
        extraLocaleSettings = {
          LC_ADDRESS = "pl_PL.UTF-8";
          LC_IDENTIFICATION = "pl_PL.UTF-8";
          LC_MEASUREMENT = "pl_PL.UTF-8";
          LC_MONETARY = "pl_PL.UTF-8";
          LC_NAME = "pl_PL.UTF-8";
          LC_NUMERIC = "pl_PL.UTF-8";
          LC_PAPER = "pl_PL.UTF-8";
          LC_TELEPHONE = "pl_PL.UTF-8";
          LC_TIME = "pl_PL.UTF-8";
        };
      };

      console.keyMap = "pl2";

      security = {
        sudo.execWheelOnly = true;
        polkit.enable = true;
      };

      services.fstrim.enable = true;

      custom = {
        # keep-sorted start block=yes
        assertions.firewall.enable = true;
        capabilities = {
          # keep-sorted start block=yes
          networking = {
            enable = true;
            hostName = cfg.hostName;
            domain = "rat-interval.ts.net";
            wifi = true;
            mdns = true;
            tailscale = true;
          };
          secureboot.enable = true;
          # keep-sorted end
        };
        nix.enable = true;
        services.sshd = {
          enable = true;
          rootAuthorizedKeyFiles = cfg.sshAuthorizedKeyFiles;
        };
        users = {
          enable = true;
          hashedPassword = cfg.hashedUserPassword;
          sshAuthorizedKeyFiles = cfg.sshAuthorizedKeyFiles;
        };
        # keep-sorted end
      };
    };
}
