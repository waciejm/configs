{
  config,
  pkgs,
  flakeInputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  nix = {
    registry.nixpkgs = {
      from = {
        type = "indirect";
        id = "nixpkgs";
      };
      flake = flakeInputs.nixpkgs;
    };
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" "@wheel"];
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-vm";

  time.timeZone = "Europe/Warsaw";

  console.keyMap = "pl";

  users = {
    mutableUsers = false;
    users.waciejm = {
      isNormalUser = true;
      extraGroups = ["wheel" "docker"];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keyFiles = [
        (../../keys/ssh + "/waciejm@michair.pub")
      ];
    };
  };

  security.sudo = {
    execWheelOnly = true;
    wheelNeedsPassword = false;
  };

  services.openssh = {
    enable = true;
    permitRootLogin = "prohibit-password";
    passwordAuthentication = false;
  };

  networking.firewall.enable = false;

  programs.zsh.enable = true;

  virtualisation.docker.enable = true;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
