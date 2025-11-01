{ config, lib, ... }:
{
  options.custom.services.sshd = {
    enable = lib.mkEnableOption "sshd with custom config";
    rootAuthorizedKeyFiles = lib.mkOption {
      type = lib.types.listOf lib.types.path;
    };
  };

  config =
    let
      cfg = config.custom.services.sshd;
    in
    lib.mkIf cfg.enable {

      assertions = [
        {
          assertion = config.custom.capabilities.networking.enable == true;
          message = "custom.services.sshd.enable requires custom.capabilities.networking.enable";
        }
      ];

      services.openssh = {
        enable = true;
        openFirewall = false;
        settings = {
          AuthenticationMethods = "publickey";
          PermitRootLogin = "prohibit-password";
        };
      };

      users.users = {
        root.openssh.authorizedKeys.keyFiles = cfg.rootAuthorizedKeyFiles;
      }
      // (
        if config.custom.users.enable then
          {
            ${config.custom.users.username}.openssh.authorizedKeys.keyFiles =
              config.custom.users.sshAuthorizedKeyFiles;
          }
        else
          { }
      );
    };
}
