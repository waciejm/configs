{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "gruvbox-tweaked";
      editor = {
        lsp.auto-signature-help = false;
        indent-guides = {
          render = true;
          character = "│";
        };
      };
    };
    themes.gruvbox-tweaked = {
      inherits = "gruvbox_dark_hard";
      "ui.background" = {};
    };
  };
}
