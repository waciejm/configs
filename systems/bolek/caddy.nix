{
  config,
  lib,
  ...
}: {
  services.tailscale.permitCertUid = "caddy";

  users.users.caddy.extraGroups = ["users"];

  services.caddy = {
    enable = true;
    email = "caddy+bolek@mwojno.me";

    globalConfig = ''
      default_bind 100.90.188.151
    '';

    # `get_certificate tailscale` should not be needed for `.ts.net` domains, but it is...
    virtualHosts."${config.networking.fqdn}:443".extraConfig = ''

      handle /ydls/* {
        uri strip_prefix /ydls/
        reverse_proxy "127.0.0.1:8451"
      }

      file_server /data* browse

      tls {
        get_certificate tailscale
      }
    '';
  };

  systemd.services.caddy = {
    requires = ["tailscaled.service"];
    after = ["tailscaled.service"];
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
}
