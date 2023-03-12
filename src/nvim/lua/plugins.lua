-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- use 'nvim-treesitter/nvim-treesitter'
  use 'sheerun/vim-polyglot'


 use {
      "nvim-treesitter/nvim-treesitter",
      run = ':TSUpdate',
      config = function() require('nvim-treesitter.configs').setup({
        ensure_installed = { "lua", "java"},
        sync_install = true,
        auto_install = true,
      }) end,
    }
  -- Load on a combination of conditions: specific filetypes or commands
  -- Also run code after load (see the "config" key)
--  use {
--    'w0rp/ale',
--    ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
--    cmd = 'ALEEnable',
--    config = 'vim.cmd[[ALEEnable]]'
--  }

  -- Post-install/update hook with neovim command
--  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- You can specify multiple plugins in a single call
--   use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}
  --
-- You can alias plugin names
  use {'dracula/vim', as = 'dracula'}
end)
