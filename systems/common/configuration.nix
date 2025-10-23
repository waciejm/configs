{
  self,
  system,
  hostname,
  nixpkgs,
  home-manager,
  pkgs,
  selfPkgs,
  lib,
  configs-private,
  ...
}: {
  imports = [
    home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.waciejm = ../../home/default.nix;
    extraSpecialArgs = {
      inherit self nixpkgs configs-private selfPkgs;
    };
    backupFileExtension = "hm-backup";
  };

  nix = {
    package = pkgs.lix;
    registry.nixpkgs = {
      from = {
        id = "nixpkgs";
        type = "indirect";
      };
      flake = nixpkgs;
    };
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" "@wheel"];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = system;
  };

  networking = {
    hostName = hostname;
    useDHCP = lib.mkDefault true;
  };

  time.timeZone = "Europe/Warsaw";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pl_PL.UTF-8";
      LC_IDENTIFICATION = "pl_PL.UTF-8";
      LC_MEASUREMENT = "pl_PL.UTF-8";
      LC_MONETARY = "pl_PL.UTF-8";
      LC_NAME = "pl_PL.UTF-8";
      LC_NUMERIC = "pl_PL.UTF-8";
      LC_PAPER = "pl_PL.UTF-8";
      LC_TELEPHONE = "pl_PL.UTF-8";
      LC_TIME = "pl_PL.UTF-8";
    };
  };

  console.keyMap = "pl2";

  users = {
    mutableUsers = false;
    users.waciejm = {
      isNormalUser = true;
      extraGroups = ["wheel" "disk"];
      shell = pkgs.nushell;
      hashedPassword = configs-private.hashedUserPassword;
    };
  };

  security = {
    sudo.execWheelOnly = true;
    polkit.enable = true;
  };

  programs.zsh = {
    enable = true;
    enableGlobalCompInit = false;
  };

  environment.pathsToLink = ["/share/zsh"];

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = false;
    };
    fstrim.enable = true;
  };
}
