{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        host = "*";
        identityFile = "~/Keys/ssh_waciejm";
      };
      "*.qed.ai" = {
        host = "*.qed.ai";
        user = "mac1";
        identityFile = "~/Keys/ssh_mac1";
      };
      "arnold" = {
        host = "arnold";
        hostname = "arnold.bearded-pangolin.ts.net";
        forwardAgent = true;
      };
      "arnold-luks" = {
        host = "arnold-luks";
        user = "root";
        hostname = "192.168.0.64";
        port = 2222;
      };
      "bolek" = {
        host = "bolek";
        forwardAgent = true;
      };
      "bolek-luks" = {
        host = "bolek-luks";
        user = "root";
        hostname = "192.168.0.65";
        port = 2222;
      };
    };
  };
}
