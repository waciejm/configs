{ config, lib, ... }:
{
  options.custom.capabilities.containerisation = {
    enable = lib.mkEnableOption "docker";
  };

  config =
    let
      cfg = config.custom.capabilities.containerisation;
    in
    lib.mkIf cfg.enable {

      virtualisation.docker.enable = true;

      users = lib.mkIf config.custom.users.enable {
        groups.docker.members = [ config.custom.users.username ];
      };
    };
}
