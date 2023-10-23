{
  services.syncthing = {
    enable = true;
    user = "waciejm";
    group = "users";
    dataDir = "/home/waciejm";
    settings = {
      options = {
        globalAnnounceEnabled = false;
        localAnnounceEnabled = false;
        relaysEnabled = false;
        urAccepted = 3;
      };
      devices = {
        badura = {
          id = "5IBUJSP-DYTG3ZR-OTG67BT-VOIHMLB-VW5T262-TSXJ6QL-KER2VZQ-IC56RQS";
          addresses = [
            "tcp://badura:22000"
            "quic://badura:22000"
          ];
        };
        cigma = {
          id = "5VKW33K-SDJ37JI-WFULCDG-4GDBRJW-O4DFLMM-BECZ7HU-XPOKTLK-YAUN5AU";
          addresses = [
            "tcp://cigma:22000"
            "quic://cigma:22000"
          ];
        };
      };
      folders = {
        syncthingtest = {
          path = "~/syncthingtest";
          devices = ["badura" "cigma"];
        };
      };
    };
  };

  networking.firewall = {
    allowedUDPPorts = [22000];
    allowedTCPPorts = [22000];
  };
}
