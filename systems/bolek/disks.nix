{
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

  swapDevices = [ ];
}
