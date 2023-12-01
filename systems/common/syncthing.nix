{
  home-manager.sharedModules = [{waciejm.linkSyncthing = true;}];

  services.syncthing = {
    enable = true;
    user = "waciejm";
    group = "users";
    configDir = "/home/waciejm/.config/syncthing";
    dataDir = "/home/waciejm/.local/state/syncthing";
    openDefaultPorts = false;

    # required for setting up waciejm-crypt
    overrideFolders = false;

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

      folders = {
        waciejm = {
          path = "~/.st";
          type = "sendreceive";
          devices = ["bolek"];
        };
        # can't be declarative, overwrites encryption password to blank
        # waciejm-crypt = {
        #   path = "~/.stc";
        #   type = "sendreceive";
        #   devices = ["bolek"];
        # };
      };
    };
  };
}
