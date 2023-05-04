{modulesPath, ...}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  networking.hostName = "cigma";

  nixpkgs.hostPlatform = "x86_64-linux";

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
      availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "sd_mod"];
      kernelModules = [];
      luks.devices."luks-83be875d-e979-49b6-8fb7-20ded35d8d6d".device = "/dev/disk/by-uuid/83be875d-e979-49b6-8fb7-20ded35d8d6d";
      secrets."/crypto_keyfile.bin" = null;
    };
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/1c847849-482d-4120-95cd-9d13773e6ffa";
      fsType = "ext4";
    };
    "/boot/efi" = {
      device = "/dev/disk/by-uuid/A2F1-4F3B";
      fsType = "vfat";
    };
  };

  swapDevices = [];

  hardware.cpu.intel.updateMicrocode = true;

  powerManagement.cpuFreqGovernor = "powersave";
}
