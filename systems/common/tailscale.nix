{
  services.tailscale = {
    enable = true;
    openFirewall = true;
    interfaceName = "tailscale0";
    extraUpFlags = ["--operator=waciejm"];
  };
  networking.firewall.trustedInterfaces = ["tailscale0"];
}
