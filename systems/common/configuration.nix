{
  system,
  hostname,
  nixpkgs,
  home-manager,
  pkgs-stable,
  pkgs,
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
    users.waciejm = ../../home/linux/home.nix;
    extraSpecialArgs = {
      inherit nixpkgs;
      inherit pkgs-stable;
    };
  };

  nix = {
    registry.nixpkgs = {
      from = {
        type = "indirect";
        id = "nixpkgs";
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

  boot.supportedFilesystems = ["ntfs"];

  users.users.waciejm = {
    isNormalUser = true;
    extraGroups = ["wheel" "disk"];
    shell = pkgs.zsh;
    hashedPassword = configs-private.hashedUserPassword;
  };

  security.sudo.execWheelOnly = true;

  programs.zsh.enable = true;

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    fstrim.enable = true;
    printing.enable = true;
  };

  hardware = {
    keyboard.zsa.enable = true;
  };
}
