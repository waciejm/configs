{
  services.openssh = {
    enable = true;
    settings = {
      AuthenticationMethods = "publickey";
      PermitRootLogin = "prohibit-password";
    };
  };

  users.users.waciejm.openssh.authorizedKeys.keyFiles = [
    ../../keys/ssh/waciejm.pub
  ];
}
