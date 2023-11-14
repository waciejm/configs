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
        bravo = {
          id = "HH2QXX6-O3K2MOB-RTWFDIQ-ZEDUULA-XEMX5WC-TVPGNPR-UPN5VYL-4RJC6A2";
          addresses = ["tcp://100.90.188.151:22000"];
        };
      };

      overrideFolders = true;
      folders = {
        syncthingtest = {
          path = "~/syncthingtest";
          devices = ["bravo"];
        };
      };
    };
  };
}
