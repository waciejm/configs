{
  modulesPath,
  nixos-hardware,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    nixos-hardware.nixosModules.framework-16-7040-amd
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
          end = "-65G"; # leave 65G for swap
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

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchDocked = "ignore";
    HandleLidSwitchExternalPower = "suspend-then-hibernate";
  };

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=12h
  '';

  services.fwupd.enable = true;

  services.fprintd.enable = false;

  hardware.cpu.amd.updateMicrocode = true;

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", DRIVER=="usb", ATTR{power/wakeup}="disabled"
    ACTION=="add", SUBSYSTEM=="i2c", DRIVER=="i2c_hid_acpi", ATTR{power/wakeup}="disabled"

    ACTION=="add", KERNEL=="0000:03:00.0", SUBSYSTEM=="pci", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
  '';

  fonts.fontconfig.subpixel.rgba = "rgb";
}
