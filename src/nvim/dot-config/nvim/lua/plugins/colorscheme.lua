-- Catppuccin Mocha — consistent theme across tmux, ghostty, yazi, nvim
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      background = { light = "latte", dark = "mocha" },
      integrations = {
        cmp              = true,
        gitsigns         = true,
        harpoon          = true,
        noice            = true,
        notify           = true,
        telescope        = { enabled = true },
        treesitter       = true,
        which_key        = true,
        mini             = { enabled = true },
        native_lsp       = { enabled = true },
        indent_blankline = { enabled = true },
        mason            = true,
        lsp_trouble      = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
