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
        # badura = {
        #   id = "5IBUJSP-DYTG3ZR-OTG67BT-VOIHMLB-VW5T262-TSXJ6QL-KER2VZQ-IC56RQS";
        #   addresses = ["tcp://100.82.104.49:22000"];
        # };
        # boxy = {
        #   id = "GWR427B-IRJQUWH-UNE4WYF-GYFEN67-K2OGQWE-436QY5X-6HI3CV7-JJ77GQU";
        #   addresses = ["tcp://100.73.138.82:22000"];
        # };
        # foldy = {
        #   id = "S7HDYYO-4GIT2Y4-ALK6FBM-IJOGPVC-KJIHCFV-B6MDEQ2-EUB2GIA-EC5ALAM";
        #   addresses = ["tcp://100.123.209.38:22000"];
        # };
        # frork = {
        #   id = "3DPNCRL-NI7CEXE-UT2ZXMW-ZSOVUFP-LKJN4PX-6OL2PAU-PLUBY4Q-DBGKEQP";
        #   addresses = ["tcp://100.92.136.116:22000"];
        # };
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
        Keys = {
          path = "/home/waciejm/Keys";
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
        qed = {
          path = "/home/waciejm/qed";
          type = "sendreceive";
          devices = ["bolek"];
        };
      };
    };
  };
}
