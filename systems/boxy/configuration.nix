{
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  system.stateVersion = "23.11";

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "thunderbolt" "usb_storage" "usbhid"];
      kernelModules = [];
    };
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
    kernelPackages = pkgs.linuxPackages_latest;
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
              keyFile = "/dev/disk/by-id/usb-Kingston_DataTraveler_3.0_1C1B0D6579FCE261A9653008-0:0";
              keyFileSize = 4096;
              keyFileOffset = 0;
              fallbackToPassword = true;
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

  powerManagement.cpuFreqGovernor = "powersave";

  fonts.fontconfig.subpixel.rgba = "rgb";
}
