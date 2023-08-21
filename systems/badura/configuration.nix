{modulesPath, ...}: {
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

  hardware.cpu.amd.updateMicrocode = true;

  fonts.fontconfig.subpixel.rgba = "none";
}
