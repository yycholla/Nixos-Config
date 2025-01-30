{
  pkgs,
  lib,
  ...
}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        options = {
          shiftwidth = 0;
          tabstop = 2;
        };
        autopairs.nvim-autopairs.enable = true;
        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = false;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "catppuccin";
          };
        };
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        lsp = {
          formatOnSave = true;
        };
        languages = {
          enableLSP = true;
          enableTreesitter = true;
          enableFormat = true;
          enableExtraDiagnostics = true;

          nix.enable = true;
          ts.enable = true;
          java.enable = true;
          go.enable = true;
          python.enable = true;
          lua.enable = true;
          markdown.enable = true;
        };
      };
    };
  };
}
