{
  config,
  lib,
  ...
}:
{
  options.custom.services.syncthing.client = {
    enable = lib.mkEnableOption "syncthing with custom config for \"client\" PCs";
  };

  config =
    let
      cfg = config.custom.services.syncthing.client;
    in
    lib.mkIf cfg.enable {

      assertions = [
        {
          assertion = config.custom.users.enable == true;
          message = "custom.services.syncthing.client.enable requires custom.users.enable";
        }
        {
          assertion = config.custom.capabilities.networking.enable == true;
          message = "custom.services.syncthing.client.enable requires custom.capabilities.networking.enable";
        }
        {
          assertion = config.custom.capabilities.networking.tailscale == true;
          message = "custom.services.syncthing.client.enable requires custom.capabilities.networking.tailscale";
        }
        {
          assertion = config.custom.services.syncthing.server.enable == false;
          message = "custom.services.syncthing.client is incompatible with custom.services.syncthing.server";
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

          configDir = "/home/${user}/.config/syncthing";
          dataDir = "/home/${user}/.local/state/syncthing";

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
            };

            folders = {
              # keep-sorted start block=yes
              Archive = {
                path = "/home/${user}/Archive";
                type = "sendreceive";
                devices = [ "bolek" ];
              };
              Desktop = {
                path = "/home/${user}/Desktop";
                type = "sendreceive";
                devices = [ "bolek" ];
              };
              Documents = {
                path = "/home/${user}/Documents";
                type = "sendreceive";
                devices = [ "bolek" ];
              };
              Keys = {
                path = "/home/${user}/Keys";
                type = "sendreceive";
                devices = [ "bolek" ];
              };
              Music = {
                path = "/home/${user}/Music";
                type = "sendreceive";
                devices = [ "bolek" ];
              };
              Pictures = {
                path = "/home/${user}/Pictures";
                type = "sendreceive";
                devices = [ "bolek" ];
              };
              Projects = {
                path = "/home/${user}/Projects";
                type = "sendreceive";
                devices = [ "bolek" ];
              };
              cosmic-config = {
                path = "/home/${user}/.config/cosmic";
                type = "sendreceive";
                devices = [ "bolek" ];
              };
              qed = {
                path = "/home/${user}/qed";
                type = "sendreceive";
                devices = [ "bolek" ];
              };
              # keep-sorted end
            };
          };
        };
    };
}
