{
  modulesPath,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  custom = {
    # keep-sorted start block=yes
    capabilities = {
      # keep-sorted start block=yes
      android-development.enable = true;
      bluetooth.enable = true;
      containerisation.enable = true;
      embedded-development.enable = true;
      gaming.enable = true;
      gui.enable = true;
      printing-and-scanning.enable = true;
      # keep-sorted end
    };
    services = {
      # keep-sorted start block=yes
      syncthing.client.enable = true;
      # keep-sorted end
    };
    users.pc = true;
    # keep-sorted end
  };

  programs.nix-ld.enable = true;

  system.stateVersion = "25.05";

  boot = {
    loader.efi.canTouchEfiVariables = true;
    initrd = {
      systemd.enable = true;
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "thunderbolt"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
    };
    kernelModules = [ "kvm-amd" ];
    kernelParams = [ "amd_pstate=active" ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  disko.devices.disk.ssd1 = {
    type = "disk";
    device = "/dev/disk/by-id/nvme-Micron_MTFDKCD1T0TGE-1BK1AABLA_241247B1981F";
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
            extraArgs = [
              "-F"
              "32"
              "-n"
              "ESP"
            ];
          };
        };
        root = {
          type = "8309"; # Linux LUKS
          end = "-33G"; # leave 33G for swap
          content = {
            type = "luks";
            name = "luks-root";
            passwordFile = "/tmp/luks.key";
            settings.allowDiscards = true;
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "root" = {
                  mountpoint = "/";
                  mountOptions = [
                    "compress=zstd"
                    "relatime"
                  ];
                };
                "home" = {
                  mountpoint = "/home";
                  mountOptions = [
                    "compress=zstd"
                    "relatime"
                  ];
                };
                "nix" = {
                  mountpoint = "/nix";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
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
            settings.allowDiscards = true;
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

  services.logind.settings.Login.HandlePowerKey = "ignore";

  services.fwupd.enable = true;

  services.power-profiles-daemon.enable = true;

  hardware.cpu.amd.updateMicrocode = true;

  hardware.amdgpu.initrd.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
