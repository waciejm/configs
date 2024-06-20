{
  pkgs,
  modulesPath,
  nixos-hardware,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    nixos-hardware.nixosModules.framework-16-7040-amd
  ];

  system.stateVersion = "24.05";

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "thunderbolt" "usb_storage" "usbhid" "sd_mod"];
      kernelModules = ["amdgpu"];
    };
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  disko.devices.disk.ssd1 = {
    type = "disk";
    device = "/dev/disk/by-id/nvme-Samsung_SSD_980_PRO_2TB_S736NJ0X100968L";
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
        root = {
          type = "8309"; # Linux LUKS
          end = "-65G"; # leave 65G for swap
          content = {
            type = "luks";
            name = "luks-root";
            passwordFile = "/tmp/luks.key";
            settings = {
              allowDiscards = true;
              keyFile = "/dev/disk/by-partuuid/e76ecf41-a737-4172-bc1a-78f45ebca103";
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
                  mountOptions = ["compress=zstd" "noatime"];
                };
                "home" = {
                  mountpoint = "/home";
                  mountOptions = ["compress=zstd" "noatime"];
                };
                "nix" = {
                  mountpoint = "/nix";
                  mountOptions = ["compress=zstd" "noatime"];
                };
              };
            };
          };
        };
        swap = {
          type = "8309"; # Linux LUKS
          size = "100%"; # all remaining
          content = {
            type = "luks";
            name = "luks-swap";
            passwordFile = "/tmp/luks.key";
            settings = {
              allowDiscards = true;
              keyFile = "/dev/disk/by-partuuid/e76ecf41-a737-4172-bc1a-78f45ebca103";
              keyFileSize = 4096;
              keyFileOffset = 0;
              fallbackToPassword = true;
            };
            content = {
              type = "swap";
              discardPolicy = "both";
              resumeDevice = true;
            };
          };
        };
      };
    };
  };

  services.fwupd.enable = true;

  hardware.cpu.amd.updateMicrocode = true;

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", DRIVER=="usb", ATTR{power/wakeup}="disabled"
  '';
}
