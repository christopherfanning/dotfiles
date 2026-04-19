-- Avante: ensure copilot.lua is initialized before avante tries to use it.
-- Without this, avante errors on startup: "You must setup copilot with either copilot.lua or copilot.vim"
return {
  {
    "yetone/avante.nvim",
    dependencies = {
      "zbirenbaum/copilot.lua", -- must be loaded first so the OAuth token is available
    },
  },
}
