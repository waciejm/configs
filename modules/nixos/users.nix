{
  config,
  lib,
  pkgs,
  nixpkgsFlake,
  selfFlake,
  ...
}:
{
  options.custom.users = {
    enable = lib.mkEnableOption "my user configuration";
    pc = lib.mkEnableOption "pc option in my home manager configuration";
    username = lib.mkOption {
      type = lib.types.str;
      default = "waciejm";
    };
    hashedPassword = lib.mkOption {
      type = lib.types.str;
    };
    sshAuthorizedKeyFiles = lib.mkOption {
      type = lib.types.listOf lib.types.path;
      default = [ ];
    };
  };

  config =
    let
      cfg = config.custom.users;
    in
    lib.mkIf cfg.enable {
      users = {
        mutableUsers = false;
        users.${cfg.username} = {
          isNormalUser = true;
          extraGroups = [ "wheel" ];
          shell = pkgs.zsh;
          hashedPassword = cfg.hashedPassword;
        };
      };

      programs.zsh = {
        enable = true;
        enableGlobalCompInit = false;
      };

      environment.pathsToLink = [ "/share/zsh" ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "hm-backup";
        sharedModules = [ ../home-manager ];
        extraSpecialArgs = {
          nixpkgsFlake = nixpkgsFlake;
          selfFlake = selfFlake;
        };
        users.${cfg.username} = {
          custom.my-home-manager-configuration = {
            enable = true;
            pc = cfg.pc;
            username = cfg.username;
          };
        };
      };
    };
}
