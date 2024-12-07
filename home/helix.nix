{
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
}
