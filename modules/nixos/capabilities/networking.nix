{
  config,
  lib,
  ...
}:
{
  options.custom.capabilities.networking = {
    enable = lib.mkEnableOption "custom networking configuration";
    hostName = lib.mkOption {
      type = lib.types.str;
    };
    domain = lib.mkOption {
      type = lib.types.str;
    };
    wifi = lib.mkEnableOption "wifi support using networkmanager";
    mdns = lib.mkEnableOption "Multicast DNS using Avahi";
    tailscale = lib.mkEnableOption "Tailscale VPN";
  };

  config =
    let
      cfg = config.custom.capabilities.networking;
    in
    lib.mkIf cfg.enable {

      networking.useDHCP = lib.mkDefault true;

      networking.hostName = cfg.hostName;

      networking.domain = cfg.domain;

      networking.networkmanager.enable = cfg.wifi;

      services.avahi = lib.mkIf cfg.mdns {
        enable = true;
        nssmdns4 = true;
        openFirewall = false;
      };

      services.tailscale = lib.mkIf cfg.tailscale {
        enable = true;
        interfaceName = "tailscale0";
        openFirewall = true;
        useRoutingFeatures = "both";
        extraSetFlags = [ "--operator=${config.custom.users.username}" ];
      };

      networking.firewall.trustedInterfaces = lib.mkIf cfg.tailscale [ "tailscale0" ];
    };
}
