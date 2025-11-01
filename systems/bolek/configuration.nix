{
  config,
  modulesPath,
  configs-private,
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
      bluetooth.enable = true;
      containerisation.enable = true;
      gaming.enable = true;
      gui.enable = true;
      # keep-sorted end
    };
    services = {
      # keep-sorted start block=yes
      caddy = {
        enable = true;
        bindIP = "100.90.188.151";
        enableFileServer = true;
        fileServerDir = "/data";
      };
      syncthing.server = {
        enable = true;
        foldersDir = "/data/syncthing";
        certFile = "${configs-private}/secrets/bolek/syncthing-cert.pem";
        keyFile = config.sops.secrets."syncthing-key.pem".path;
      };
      ydls.enable = true;
      # keep-sorted end
    };
    # keep-sorted end
  };

  sops = {
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    gnupg.sshKeyPaths = [ ];

    secrets."syncthing-key.pem" = {
      format = "binary";
      sopsFile = "${configs-private}/secrets/bolek/syncthing-key.sops.pem";
      owner = config.services.syncthing.user;
      restartUnits = [ "syncthing.service" ];
    };
  };

  system.stateVersion = "24.05";

  boot = {
    loader.efi.canTouchEfiVariables = true;
    initrd = {
      systemd.enable = true;
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "thunderbolt"
        "uas"
        "sd_mod"
        "r8169" # ethernet
      ];
    };
    kernelModules = [ "kvm-amd" ];
  };

  disko.devices.disk = {
    ssd1 = {
      type = "disk";
      device = "/dev/disk/by-id/nvme-XPG_GAMMIX_S11_Pro_2J3720127841";
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
            end = "475G";
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
        };
      };
    };
    ssd2 = {
      type = "disk";
      device = "/dev/disk/by-id/usb-Samsung_SSD_870_QVO_000000123BBD-0:0";
      content = {
        type = "gpt";
        partitions = {
          data = {
            type = "8309"; # Linux LUKS
            end = "7.3T";
            content = {
              type = "luks";
              name = "luks-data";
              passwordFile = "/tmp/luks.key";
              settings.allowDiscards = true;
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "data" = {
                    mountpoint = "/data";
                    mountOptions = [
                      "compress=zstd"
                      "relatime"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };

  hardware.cpu.amd.updateMicrocode = true;
}
