{
  services.syncthing = {
    enable = true;
    user = "waciejm";
    group = "users";
    configDir = "/home/waciejm/.config/syncthing";
    dataDir = "/home/waciejm/.local/state/syncthing";
    openDefaultPorts = false;
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
        bolek = {
          id = "HH2QXX6-O3K2MOB-RTWFDIQ-ZEDUULA-XEMX5WC-TVPGNPR-UPN5VYL-4RJC6A2";
          addresses = ["tcp://100.90.188.151:22000"];
        };
      };

      folders = {
        Archive = {
          path = "/home/waciejm/Archive";
          type = "sendreceive";
          devices = ["bolek"];
        };
        Desktop = {
          path = "/home/waciejm/Desktop";
          type = "sendreceive";
          devices = ["bolek"];
        };
        Documents = {
          path = "/home/waciejm/Documents";
          type = "sendreceive";
          devices = ["bolek"];
        };
        Music = {
          path = "/home/waciejm/Music";
          type = "sendreceive";
          devices = ["bolek"];
        };
        Pictures = {
          path = "/home/waciejm/Pictures";
          type = "sendreceive";
          devices = ["bolek"];
        };
        Projects = {
          path = "/home/waciejm/Projects";
          type = "sendreceive";
          devices = ["bolek"];
        };
        # can't be declarative, overwrites encryption password to blank
        # Keys = {
        #   path = "/home/waciejm/Keys";
        #   type = "sendreceive";
        #   devices = ["bolek"];
        # };
        # qed = {
        #   path = "/home/waciejm/qed";
        #   type = "sendreceive";
        #   devices = ["bolek"];
        # };
      };
    };
  };
}
