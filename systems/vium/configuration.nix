{
  modulesPath,
  lib,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./assertions.nix
  ];

  system.stateVersion = "24.05";

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      systemd.enable = true;
      availableKernelModules = ["ata_piix" "ohci_pci" "ehci_pci" "ahci" "sd_mod" "sr_mod"];
    };
  };

  disko.devices.disk.vdi = {
    type = "disk";
    device = "/dev/disk/by-id/ata-VBOX_HARDDISK_VB3c542ba5-62353bd0";
    content = {
      type = "gpt";
      partitions = {
        esp = {
          type = "ef00"; # EFI system partition
          size = "1G";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            extraArgs = ["-F" "32" "-n" "ESP"];
          };
        };
        luks = {
          size = "100%"; # all remaining
          content = {
            type = "btrfs";
            extraArgs = ["-f"];
            subvolumes = {
              "root" = {
                mountpoint = "/";
                mountOptions = ["compress=zstd" "relatime"];
              };
              "home" = {
                mountpoint = "/home";
                mountOptions = ["compress=zstd" "relatime"];
              };
              "nix" = {
                mountpoint = "/nix";
                mountOptions = ["compress=zstd" "noatime"];
              };
            };
          };
        };
      };
    };
  };

  swapDevices = [];

  virtualisation.virtualbox.guest.enable = true;

  services.openssh.openFirewall = lib.mkForce true;
}
