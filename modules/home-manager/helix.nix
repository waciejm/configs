{ config, lib, ... }:
{
  options.custom.helix = {
    enable = lib.mkEnableOption "helix with custom configuration as default editor";
  };

  config =
    let
      cfg = config.custom.helix;
    in
    lib.mkIf cfg.enable {
      programs.helix = {
        enable = true;
        defaultEditor = true;
        settings = {
          theme = "gruvbox_dark_hard";
          editor = {
            lsp.auto-signature-help = false;
            indent-guides = {
              render = true;
              character = "│";
            };
          };
        };
      };
    };
}
