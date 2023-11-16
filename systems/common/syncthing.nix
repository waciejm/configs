{
  services.syncthing = {
    enable = true;
    user = "waciejm";
    group = "users";
    dataDir = "/home/waciejm";
    openDefaultPorts = false;

    settings = {
      options = {
        listenAddresses = ["tcp://0.0.0.0:22000"];
        globalAnnounceEnabled = false;
        localAnnounceEnabled = false;
        relaysEnabled = false;
        natEnabled = false;
        urAccepted = -1;
        crashReportingEnabled = false;
        stunKeepaliveStartS = 0;
        announceLANAdderss = false;
      };

      devices = {
        badura = {
          id = "5IBUJSP-DYTG3ZR-OTG67BT-VOIHMLB-VW5T262-TSXJ6QL-KER2VZQ-IC56RQS";
          addresses = ["tcp://100.82.104.49:22000"];
        };
        bolek = {
          id = "HH2QXX6-O3K2MOB-RTWFDIQ-ZEDUULA-XEMX5WC-TVPGNPR-UPN5VYL-4RJC6A2";
          addresses = ["tcp://100.90.188.151:22000"];
        };
      };

      overrideFolders = true;
      folders = {
        waciejm = {
          path = "~/.syncthing";
          type = "sendreceive";
          devices = ["bolek"];
        };
        waciejm-crypt = {
          path = "~/.syncthing-crypt";
          type = "sendreceive";
          devices = ["bolek"];
        };
      };
    };
  };
}
