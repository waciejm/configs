{
  config,
  pkgs,
  ...
}: {
  assertions = [
    {
      assertion = config.boot.loader.systemd-boot.enable == false;
      message = "systemd-boot must be diabled if using lanzaboote";
    }
    {
      assertion = config.boot.loader.supportsInitrdSecrets == true;
      message = "Boot loader doesn't support initrd secrets";
    }
    {
      assertion = config.boot.initrd.systemd.network.networks != {};
      message = "no networks configured for stage 1 systemd-networkd";
    }
  ];

  environment.systemPackages = [
    pkgs.sbctl # secure boot
    pkgs.tpm2-tss # required for unlocking LUKS devices with TPM2
  ];

  # boot.loader.systemd-boot.enable = false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    settings.editor = false;
  };
  boot.loader.timeout = 1;

  boot.kernelModules = ["kvm-amd"];

  boot.initrd = {
    kernelModules = [];
    availableKernelModules = [
      "nvme"
      "xhci_pci"
      "thunderbolt"
      "uas"
      "sd_mod"
      "r8169" # ethernet
    ];

    systemd.enable = true;

    network.enable = true;
    network.ssh = {
      enable = true;
      port = 2222; # ssh port during boot for luks decryption
      hostKeys = ["/etc/ssh/stage1_ssh_host_ecdsa_key"];
      authorizedKeys = [(builtins.readFile ../../keys/ssh/waciejm.pub)];
    };

    secrets = {
      "/etc/ssh/stage1_ssh_host_ecdsa_key" = "/etc/ssh/stage1_ssh_host_ecdsa_key";
    };

    systemd.contents."/etc/profile".text = ''
      systemctl default
    '';
  };
}
