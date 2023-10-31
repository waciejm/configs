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
          addresses = ["tcp://badura:22000"];
        };
        mmmmmm = {
          id = "FAQ3MPE-HBQXTHR-RZ6HNRI-YLLZ3KM-PG6QU2G-KS4BYK4-YQ4NBNF-6YYZYAB";
          addresses = ["tcp://mmmmmm:22000"];
        };
      };
      folders = {
        syncthingtest = {
          path = "~/syncthingtest";
          devices = ["badura" "mmmmmm"];
        };
      };
    };
  };
}
