# Neovim — Fresh Install Errors

## Problem

On a fresh Arch Linux install (after running `arch-install.sh` then `install.dotfiles.sh`), opening Neovim for the first time shows a cluster of errors before plugins finish setting up.

### Error 1: tree-sitter-markdown build failure

```
mv: cannot stat 'tree-sitter-markdown-tmp/tree-sitter-markdown-master': No such file or directory
```

nvim-treesitter downloads a source tarball and tries to extract it to a predictable path, but the archive's internal directory name doesn't match the expected pattern. Happens on the first `:TSInstall markdown` attempt.

### Error 2: Mason plugin origin changed

```
Failed (2)
  ○ mason-lspconfig.nvim  nvim-lspconfig
      Origin has changed:
        * old: https://github.com/williamboman/mason-lspconfig.nvim.git
        * new: https://github.com/mason-org/mason-lspconfig.nvim.git
      Please run update to fix
  ● mason.nvim 14.85ms  nvim-dap
      Origin has changed:
        * old: https://github.com/williamboman/mason.nvim.git
        * new: https://github.com/mason-org/mason.nvim.git
      Please run update to fix
```

The mason repositories migrated from `williamboman/` to `mason-org/` on GitHub. If `lazy-lock.json` has commits tied to the old remote URL, lazy.nvim detects the mismatch on launch.

### Error 3: Invalid treesitter node type

```
/usr/share/nvim/runtime/lua/vim/treesitter/query.lua:374: Query error at 113:4. Invalid node type "tab"
```

nvim's built-in runtime queries reference a node type that doesn't exist in the currently installed parser version. A parser version mismatch between the system nvim and the lazy.nvim-managed parsers causes this.

## Fix (applied in dotfiles)

`install.dotfiles.sh` now runs a headless Neovim initialization block immediately after stowing:

```bash
nvim --headless "+Lazy! sync" +qa    # install all plugins
nvim --headless "+Lazy! update" +qa  # resolve any origin URL changes
nvim --headless "+TSUpdate" +qa      # install parsers, fix node-type mismatches
```

This runs before the user ever opens Neovim manually, so all three errors are resolved before the first interactive session.

## Immediate Fix (existing machines)

If you already hit these errors, open Neovim and run:

```
:Lazy update
:TSUpdate
```

Wait for both to complete (watch the progress in the Lazy UI / TSUpdate output), then restart Neovim.
