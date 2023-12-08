{
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
      luks.devices."luks-766679bc-35c4-4f4b-91d5-1e4dbb964ae5" = {
        device = "/dev/disk/by-uuid/766679bc-35c4-4f4b-91d5-1e4dbb964ae5";
        allowDiscards = true;
        keyFile = "/dev/disk/by-id/usb-Kingston_DataTraveler_3.0_1C1B0D6579FCE261A9653008-0:0";
        keyFileSize = 4096;
        keyFileOffset = 0;
        fallbackToPassword = true;
      };
    };
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
    kernelPackages = pkgs.linuxPackages_latest;
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

  powerManagement.cpuFreqGovernor = "ondemand";

  fonts.fontconfig.subpixel.rgba = "rgb";
}
