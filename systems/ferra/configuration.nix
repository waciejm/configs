{modulesPath, ...}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  system.stateVersion = "24.05";

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      systemd.enable = true;
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
    };
    kernelModules = ["kvm-amd"];
  };

  disko.devices.disk.ssd1 = {
    type = "disk";
    device = "/dev/disk/by-id/nvme-KINGSTON_SKC3000D2048G_50026B7382848583";
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
          type = "8309"; # Linux LUKS
          size = "100%"; # all remaining
          content = {
            type = "luks";
            name = "luks-root";
            passwordFile = "/tmp/luks.key";
            settings = {
              allowDiscards = true;
              keyFile = "/dev/disk/by-partuuid/e76ecf41-a737-4172-bc1a-78f45ebca103";
              keyFileSize = 4096;
              keyFileOffset = 0;
              keyFileTimeout = 5;
            };
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
  };

  swapDevices = [];

  hardware.cpu.amd.updateMicrocode = true;

  fonts.fontconfig.subpixel.rgba = "rgb";
}
