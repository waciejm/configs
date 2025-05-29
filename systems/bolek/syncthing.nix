{config, ...}: {
  services.syncthing = {
    enable = true;

    user = "waciejm";
    group = "users";

    configDir = "/var/lib/syncthing";
    dataDir = "/var/lib/syncthing";

    # Device ID: HH2QXX6-O3K2MOB-RTWFDIQ-ZEDUULA-XEMX5WC-TVPGNPR-UPN5VYL-4RJC6A2
    cert = "${./secrets/syncthing-cert.pem}";
    key = config.sops.secrets."syncthing-key.pem".path;

    openDefaultPorts = false;
    guiAddress = "0.0.0.0:8384";

    overrideDevices = true;
    overrideFolders = true;

    settings = {
      options = {
        listenAddresses = ["tcp://100.90.188.151:22000"];
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
        announceLANAddresses = false;
      };

      devices = {
        # bolek = {
        #   id = "HH2QXX6-O3K2MOB-RTWFDIQ-ZEDUULA-XEMX5WC-TVPGNPR-UPN5VYL-4RJC6A2";
        #   addresses = ["tcp://100.90.188.151:22000"];
        # };
        ferra = {
          id = "KQFXNZF-OQXAZCM-7UPK65V-HKHXXUH-LZFTY2Q-OG3DVEO-HBTNBIG-QINT6AA";
          addresses = ["tcp://100.112.8.82:22000"];
        };
        frork = {
          id = "IYRL3AO-RCMCJRV-LMRV3D4-KCKOLES-X6F5CQK-LE6HJXY-GDG4BBL-BE6HSQI";
          addresses = ["tcp://100.104.91.71:22000"];
        };
        lovo = {
          id = "RGT6TQN-MDORPYU-XPBE7UK-HC22IMV-GEYOBZO-7AWI26V-RQLBC7L-O3YNCQM";
          addresses = ["tcp://100.110.126.17:22000"];
        };
        foldy = {
          id = "S7HDYYO-4GIT2Y4-ALK6FBM-IJOGPVC-KJIHCFV-B6MDEQ2-EUB2GIA-EC5ALAM";
          addresses = ["tcp://100.123.209.38:22000"];
        };
        gablet = {
          id = "FBQQIYY-QO2V3DE-6NWKG2Y-PWVW4A5-CNG5S2G-5EMQ3XB-T7YEDK3-CRSVWAA";
          addresses = ["tcp://100.68.220.48:22000"];
        };
        pineo = {
          id = "WQ6EGDG-OKMHJSI-5CNMEWY-ETT6IAB-KHGARZH-KK56AF3-JGJXVNY-ZTHCJQU";
          addresses = ["tcp://100.114.165.49:22000"];
        };
      };

      folders = {
        Archive = {
          path = "/data/syncthing/Archive";
          type = "sendreceive";
          devices = ["ferra" "frork" "lovo"];
        };
        cosmic-config = {
          path = "/data/syncthing/cosmic-config";
          type = "sendreceive";
          devices = ["ferra" "frork" "lovo"];
        };
        DCIM = {
          path = "/data/syncthing/DCIM";
          type = "sendreceive";
          devices = ["foldy" "gablet" "pineo"];
        };
        Desktop = {
          path = "/data/syncthing/Desktop";
          type = "sendreceive";
          devices = ["ferra" "frork" "lovo"];
        };
        Documents = {
          path = "/data/syncthing/Documents";
          type = "sendreceive";
          devices = ["ferra" "frork" "lovo" "foldy" "gablet" "pineo"];
        };
        Keys = {
          path = "/data/syncthing/Keys";
          type = "sendreceive";
          devices = ["ferra" "frork" "lovo" "foldy" "gablet" "pineo"];
        };
        Music = {
          path = "/data/syncthing/Music";
          type = "sendreceive";
          devices = ["ferra" "frork" "lovo"];
        };
        pad = {
          path = "/data/syncthing/pad";
          type = "sendreceive";
          devices = ["foldy" "gablet"];
        };
        Pictures = {
          path = "/data/syncthing/Pictures";
          type = "sendreceive";
          devices = ["ferra" "frork" "lovo" "foldy" "gablet" "pineo"];
        };
        Projects = {
          path = "/data/syncthing/Projects";
          type = "sendreceive";
          devices = ["ferra" "frork" "lovo"];
        };
        qed = {
          path = "/data/syncthing/qed";
          type = "sendreceive";
          devices = ["ferra" "frork" "lovo"];
        };
      };
    };
  };

  systemd = {
    services.syncthing = {
      after = ["systemd-tmpfiles-setup.service"];
      serviceConfig.StateDirectory = "syncthing";
    };
    tmpfiles.rules = let
      inherit (config.services.syncthing) user group;
    in [
      "d /data/syncthing 0750 ${user} ${group} -"
    ];
  };

  sops.secrets."syncthing-key.pem" = {
    format = "binary";
    sopsFile = ./secrets/syncthing-key.sops.pem;
    owner = config.services.syncthing.user;
    restartUnits = ["syncthing.service"];
  };
}
