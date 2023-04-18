{
  config,
  pkgs,
  ...
}: {
  imports = [];

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
      luks.devices."luks-86002586-d1f5-46e3-adc9-2ed8b53fbe09".device = "/dev/disk/by-uuid/86002586-d1f5-46e3-adc9-2ed8b53fbe09";
      secrets."/crypto_keyfile.bin" = null;
    };
    kernelModules = ["kvm-amd"];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/664f52bc-4ab0-4a84-a504-042a9c124b4d";
      fsType = "f2fs";
    };
    "/boot/efi" = {
      device = "/dev/disk/by-uuid/2E7A-D3AD";
      fsType = "vfat";
    };
  };

  networking = {
    hostName = "badura";
    networkmanager.enable = true;
  };

  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config.allowUnfree = true;
  };

  hardware.cpu.amd.updateMicrocode = true;

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
    extraGroups = ["wheel" "docker"];
    openssh.authorizedKeys.keyFiles = [
      (../../keys/ssh + "/waciejm@michair.pub")
    ];
    shell = pkgs.zsh;
  };

  programs = {
    zsh.enable = true;
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
        hidpi = true;
      };
    };
  };

  virtualisation.docker.enable = true;
}
