{
  services.syncthing = {
    enable = true;

    user = "waciejm";
    group = "users";

    configDir = "/home/waciejm/.config/syncthing";
    dataDir = "/home/waciejm/.local/state/syncthing";

    openDefaultPorts = false;
    guiAddress = "127.0.0.1:8384";

    overrideDevices = true;
    overrideFolders = false;

    settings = {
      options = {
        listenAddresses = [ "tcp://0.0.0.0:22000" ];
        globalAnnounceEnabled = false;
        localAnnounceEnabled = false;
        relaysEnabled = false;
        natEnabled = false;
        urAccepted = -1; # no usage reporting
        minHomeDiskFree = {
          value = 1;
          unit = "%";
        };
        crashReportingEnabled = false;
        stunKeepaliveStartS = 0; # disable contacting STUN servers
        announceLANAdderss = false;
      };

      devices = {
        bolek = {
          id = "HH2QXX6-O3K2MOB-RTWFDIQ-ZEDUULA-XEMX5WC-TVPGNPR-UPN5VYL-4RJC6A2";
          addresses = [ "tcp://100.90.188.151:22000" ];
        };
        # ferra = {
        #   id = "KQFXNZF-OQXAZCM-7UPK65V-HKHXXUH-LZFTY2Q-OG3DVEO-HBTNBIG-QINT6AA";
        #   addresses = ["tcp://100.112.8.82:22000"];
        # };
        # frork = {
        #   id = "3DPNCRL-NI7CEXE-UT2ZXMW-ZSOVUFP-LKJN4PX-6OL2PAU-PLUBY4Q-DBGKEQP";
        #   addresses = ["tcp://100.92.136.116:22000"];
        # };
        # lovo = {
        #   id = "RGT6TQN-MDORPYU-XPBE7UK-HC22IMV-GEYOBZO-7AWI26V-RQLBC7L-O3YNCQM";
        #   addresses = ["tcp://100.110.126.17:22000"];
        # };
        # gablet = {
        #   id = "FBQQIYY-Q02V3DE-6NWKG2Y-PWVW4A5-CNG5S2G-5EMQ3XB-T7YEDK3-CRSVWAA";
        #   addresses = ["tcp://100.68.220.48:22000"];
        # };
        # pineo = {
        #   id = "WQ6EGDG-OKMHJSI-5CNMEWY-ETT6IAB-KHGARZH-KK56AF3-JGJXVNY-ZTHCJQU";
        #   addresses = ["tcp://100.114.165.49:22000"];
        # };
      };

      folders = {
        Archive = {
          path = "/home/waciejm/Archive";
          type = "sendreceive";
          devices = [ "bolek" ];
        };
        cosmic-config = {
          path = "/home/waciejm/.config/cosmic";
          type = "sendreceive";
          devices = [ "bolek" ];
        };
        Desktop = {
          path = "/home/waciejm/Desktop";
          type = "sendreceive";
          devices = [ "bolek" ];
        };
        Documents = {
          path = "/home/waciejm/Documents";
          type = "sendreceive";
          devices = [ "bolek" ];
        };
        Keys = {
          path = "/home/waciejm/Keys";
          type = "sendreceive";
          devices = [ "bolek" ];
        };
        Music = {
          path = "/home/waciejm/Music";
          type = "sendreceive";
          devices = [ "bolek" ];
        };
        Pictures = {
          path = "/home/waciejm/Pictures";
          type = "sendreceive";
          devices = [ "bolek" ];
        };
        Projects = {
          path = "/home/waciejm/Projects";
          type = "sendreceive";
          devices = [ "bolek" ];
        };
        qed = {
          path = "/home/waciejm/qed";
          type = "sendreceive";
          devices = [ "bolek" ];
        };
      };
    };
  };
}
