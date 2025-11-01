{ config, lib, ... }:
{
  options.custom.services.caddy = {
    enable = lib.mkEnableOption "caddy with custom config";
    bindIP = lib.mkOption {
      type = lib.types.str;
    };
    enableFileServer = lib.mkEnableOption "file server from provided dir";
    fileServerDir = lib.mkOption {
      type = lib.types.path;
    };
  };

  config =
    let
      cfg = config.custom.services.caddy;
    in
    lib.mkIf cfg.enable {

      assertions = [
        {
          assertion = config.custom.capabilities.networking.enable == true;
          message = "custom.services.caddy.enable requires custom.capabilities.networking.enable";
        }
        {
          assertion = config.custom.capabilities.networking.tailscale == true;
          message = "custom.services.caddy.enable requires custom.capabilities.networking.tailscale";
        }
      ];

      services.tailscale.permitCertUid = "caddy";

      users.users.caddy.extraGroups = [ "users" ];

      services.caddy = {
        enable = true;
        email = "caddy+${config.networking.hostName}@mwojno.me";

        globalConfig = ''
          default_bind ${cfg.bindIP}
        '';

        # `get_certificate tailscale` should not be needed for `.ts.net` domains, but it is...
        virtualHosts."${config.networking.fqdn}:443".extraConfig =
          let
            enableYdlsHandler = config.custom.services.ydls.enable;
            enableHttpsIngress = cfg.enableFileServer || enableYdlsHandler;
          in
          lib.mkIf enableHttpsIngress ''

            tls {
              get_certificate tailscale
            }

            ${
              if cfg.enableFileServer then
                ''
                  file_server ${cfg.fileServerDir}* browse
                ''
              else
                ""
            }

            ${
              if enableYdlsHandler then
                ''
                  handle /ydls/* {
                    uri strip_prefix /ydls/
                    reverse_proxy "127.0.0.1:${config.custom.services.ydls.port}"
                  }

                ''
              else
                ""
            }
          '';
      };

      systemd.services.caddy = {
        requires = [ "tailscaled.service" ];
        after = [ "tailscaled.service" ];
        # waiting for tailscaled is not enough, and it still fails on boot with
        # `cannot assign requested address`, so we try restarting a few times
        serviceConfig = {
          Restart = "on-failure";
          RestartSec = lib.mkForce "3s";
          RestartPreventExitStatus = lib.mkForce "";
        };
        startLimitIntervalSec = lib.mkForce 60;
        startLimitBurst = lib.mkForce 20;
      };
    };
}
