{ config, lib, ... }:
{
  options.custom.services.ydls = {
    enable = lib.mkEnableOption "ydls running on port 8080";
    port = lib.mkOption {
      type = lib.types.str;
      description = "localhost port to bind to";
      default = "8451";
    };
  };

  config =
    let
      cfg = config.custom.services.ydls;
    in
    lib.mkIf cfg.enable {

      assertions = [
        {
          assertion = config.custom.capabilities.networking.enable == true;
          message = "custom.services.ydls.enable requires custom.capabilities.networking.enable";
        }
        {
          assertion = config.custom.capabilities.containerisation.enable == true;
          message = "custom.services.ydls.enable requires custom.capabilities.containerisation.enable";
        }
      ];

      virtualisation.oci-containers = {
        backend = "docker";
        containers.ydls = {
          image = "mwader/ydls:latest";
          ports = [ "127.0.0.1:${cfg.port}:8080" ];
        };
      };
    };
}
