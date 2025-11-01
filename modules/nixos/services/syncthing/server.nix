{
  config,
  lib,
  ...
}:
{
  options.custom.services.syncthing.server = {
    enable = lib.mkEnableOption "syncthing with custom config for servers";
    foldersDir = lib.mkOption {
      type = lib.types.path;
      description = "directory in which synced folders will be placed";
    };
    certFile = lib.mkOption {
      type = lib.types.path;
      description = "path to the cert file";
    };
    keyFile = lib.mkOption {
      type = lib.types.path;
      description = "path to the key file";
    };
  };

  config =
    let
      cfg = config.custom.services.syncthing.server;
    in
    lib.mkIf cfg.enable {

      assertions = [
        {
          assertion = config.custom.users.enable == true;
          message = "custom.services.syncthing.server.enable requires custom.users.enable";
        }
        {
          assertion = config.custom.capabilities.networking.enable == true;
          message = "custom.services.syncthing.server.enable requires custom.capabilities.networking.enable";
        }
        {
          assertion = config.custom.capabilities.networking.tailscale == true;
          message = "custom.services.syncthing.server.enable requires custom.capabilities.networking.tailscale";
        }
        {
          assertion = config.custom.services.syncthing.client.enable == false;
          message = "custom.services.syncthing.server is incompatible with custom.services.syncthing.client";
        }
      ];

      services.syncthing =
        let
          user = config.custom.users.username;
        in
        {
          enable = true;

          user = user;
          group = config.users.users.${user}.group;

          configDir = "/var/lib/syncthing";
          dataDir = "/var/lib/syncthing";

          cert = cfg.certFile;
          key = cfg.keyFile;

          openDefaultPorts = false;
          guiAddress = "127.0.0.1:8384";

          overrideDevices = true;
          overrideFolders = true;

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
              # keep-sorted start block=yes
              ferra = {
                id = "KQFXNZF-OQXAZCM-7UPK65V-HKHXXUH-LZFTY2Q-OG3DVEO-HBTNBIG-QINT6AA";
                addresses = [ "tcp://100.112.8.82:22000" ];
              };
              frork = {
                id = "3DPNCRL-NI7CEXE-UT2ZXMW-ZSOVUFP-LKJN4PX-6OL2PAU-PLUBY4Q-DBGKEQP";
                addresses = [ "tcp://100.92.136.116:22000" ];
              };
              gablet = {
                id = "FBQQIYY-Q02V3DE-6NWKG2Y-PWVW4A5-CNG5S2G-5EMQ3XB-T7YEDK3-CRSVWAA";
                addresses = [ "tcp://100.68.220.48:22000" ];
              };
              lovo = {
                id = "RGT6TQN-MDORPYU-XPBE7UK-HC22IMV-GEYOBZO-7AWI26V-RQLBC7L-O3YNCQM";
                addresses = [ "tcp://100.110.126.17:22000" ];
              };
              pineo = {
                id = "WQ6EGDG-OKMHJSI-5CNMEWY-ETT6IAB-KHGARZH-KK56AF3-JGJXVNY-ZTHCJQU";
                addresses = [ "tcp://100.114.165.49:22000" ];
              };
              # keep-sorted end
            };

            folders =
              let
                pcs = [
                  # keep-sorted start
                  "ferra"
                  "frork"
                  "lovo"
                  # keep-sorted end
                ];
                mobiles = [
                  # keep-sorted start
                  "gablet"
                  "pineo"
                  # keep-sorted end
                ];
              in
              {
                # keep-sorted start block=yes
                Archive = {
                  path = "${cfg.foldersDir}/Archive";
                  type = "sendreceive";
                  devices = pcs;
                };
                DCIM = {
                  path = "${cfg.foldersDir}/DCIM";
                  type = "sendreceive";
                  devices = mobiles;
                };
                Desktop = {
                  path = "${cfg.foldersDir}/Desktop";
                  type = "sendreceive";
                  devices = pcs;
                };
                Documents = {
                  path = "${cfg.foldersDir}/Documents";
                  type = "sendreceive";
                  devices = pcs ++ mobiles;
                };
                Keys = {
                  path = "${cfg.foldersDir}/Keys";
                  type = "sendreceive";
                  devices = pcs ++ mobiles;
                };
                Music = {
                  path = "${cfg.foldersDir}/Music";
                  type = "sendreceive";
                  devices = pcs;
                };
                Pictures = {
                  path = "${cfg.foldersDir}/Pictures";
                  type = "sendreceive";
                  devices = pcs ++ mobiles;
                };
                Projects = {
                  path = "${cfg.foldersDir}/Projects";
                  type = "sendreceive";
                  devices = pcs;
                };
                cosmic-config = {
                  path = "${cfg.foldersDir}/cosmic-config";
                  type = "sendreceive";
                  devices = pcs;
                };
                pad = {
                  path = "${cfg.foldersDir}/pad";
                  type = "sendreceive";
                  devices = mobiles;
                };
                qed = {
                  path = "${cfg.foldersDir}/qed";
                  type = "sendreceive";
                  devices = pcs;
                };
                # keep-sorted end
              };
          };
        };

      systemd = {
        services.syncthing = {
          after = [ "systemd-tmpfiles-setup.service" ];
          serviceConfig.StateDirectory = "syncthing";
        };
        tmpfiles.rules =
          let
            user = config.services.syncthing.user;
            group = config.services.syncthing.group;
          in
          [
            "d ${cfg.foldersDir} 0750 ${user} ${group} -"
          ];
      };
    };
}
