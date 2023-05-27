-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'sheerun/vim-polyglot'


 use {
      "nvim-treesitter/nvim-treesitter",
      run = ':TSUpdate',
      config = function() require('nvim-treesitter.configs').setup({
        ensure_installed = { "lua", "java", "python", "markdown", "rust", "kotlin", "dockerfile", "gitignore", "html", "javascript", "jq", "json", "org", "regex", "yaml", "typescript"},
        sync_install = true,
        auto_install = true,
      }) end,
    }

    use {
         'nvim-telescope/telescope.nvim', tag = '0.1.1',
         requires = { {'nvim-lua/plenary.nvim'} }
        }

  -- You can specify multiple plugins in a single call
--   use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}
  --
-- You can alias plugin names
  use {'dracula/vim', as = 'dracula'}
end)
