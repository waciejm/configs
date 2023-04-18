{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  system.stateVersion = "22.11";

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
      kernelModules = [];
      luks.devices."luks-766679bc-35c4-4f4b-91d5-1e4dbb964ae5".device = "/dev/disk/by-uuid/766679bc-35c4-4f4b-91d5-1e4dbb964ae5";
      secrets."/crypto_keyfile.bin" = null;
    };
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/4fde5662-c84e-4e37-bf2e-0b4fb10eb56f";
      fsType = "f2fs";
    };
    "/boot/efi" = {
      device = "/dev/disk/by-uuid/1F94-FEAD";
      fsType = "vfat";
    };
  };

  swapDevices = [];

  networking = {
    hostName = "badura";
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
  };

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config.allowUnfree = true;
  };

  hardware.cpu.amd.updateMicrocode = lib.mkDefault true;

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

  services.xserver = {
    layout = "pl";
    xkbVariant = "";
  };

  console.keyMap = "pl2";

  users.users.waciejm = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
    openssh.authorizedKeys.keyFiles = [
      (../../keys/ssh + "/waciejm@michair.pub")
    ];
    shell = pkgs.zsh;
  };

  programs = {
    zsh.enable = true;
    # hyprland = {
    #   enable = true;
    #   xwayland = {
    #     enable = true;
    #     hidpi = true;
    #   };
    # };
  };
}
