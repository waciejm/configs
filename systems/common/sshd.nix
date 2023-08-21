{
  services.openssh = {
    enabled = true;
    permitRootLogin = "prohibit-password";
    passwordAuthentication = false;
  };

  security.sudo = {
    execWheelOnly = true;
    wheelNeedsPasswrod = false;
  };

  users.users.waciejm.openssh.authorizedKeys.keyFiles = [
    (../../keys/ssh + "/waciejm.pub")
  ];
}
