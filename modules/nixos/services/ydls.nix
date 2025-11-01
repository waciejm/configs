{ config, lib, ... }:
{
  options.custom.services.ydls = {
    enable = lib.mkEnableOption "ydls running via arion";
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

      virtualisation.arion = {
        backend = "docker";
        projects.ydls = {
          serviceName = "ydls";
          settings = {
            project.name = "ydls";
            services.ydls.service = {
              image = "mwader/ydls:latest";
              restart = "always";
              ports = [
                "127.0.0.1:${cfg.port}:8080"
              ];
            };
          };
        };
      };
    };
}
