{
  services.openssh = {
    enable = true;
    openFirewall = false;
    settings = {
      AuthenticationMethods = "publickey";
      PermitRootLogin = "prohibit-password";
    };
  };

  users.users.waciejm.openssh.authorizedKeys.keyFiles = [
    (../../keys/ssh + "/waciejm.pub")
  ];
}
