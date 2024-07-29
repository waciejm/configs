{
  pkgs,
  ...
}: {
  programs.steam.enable = true;

  environment.systemPackages = [
    pkgs.prismlauncher
    # pkgs.rpcs3
  ];

  # security.pam.loginLimits = [
  #   {
  #     domain = "*";
  #     type = "soft";
  #     item = "memlock";
  #     value = "unlimited";
  #   }
  #   {
  #     domain = "*";
  #     type = "hard";
  #     item = "memlock";
  #     value = "unlimited";
  #   }
  # ];
}
