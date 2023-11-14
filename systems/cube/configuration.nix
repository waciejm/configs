{modulesPath, ...}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  system.stateVersion = "23.05";

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "sd_mod"];
      kernelModules = [];
      luks.devices."luks-8f3ccf86-d4d7-4f6f-b235-5e7c3d7e9e10".device = "/dev/disk/by-uuid/8f3ccf86-d4d7-4f6f-b235-5e7c3d7e9e10";
    };
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/93c21b95-fd72-4af7-94bf-c4a0618200c0";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/A658-4035";
      fsType = "vfat";
    };
  };

  swapDevices = [];

  hardware.cpu.intel.updateMicrocode = true;

  powerManagement.cpuFreqGovernor = "powersave";

  services.openssh.enable = true;
}
