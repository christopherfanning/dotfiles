# Neovim + LazyVim

> Neovim with the LazyVim distribution — batteries-included, fast startup, great defaults.

## Why LazyVim

- **lazy.nvim** underneath — plugins load lazily, startup is near-instant
- Sane defaults for LSP, Treesitter, formatting, and diagnostics out of the box
- Modular: override only what you need in `lua/plugins/`
- Active ecosystem with official "extras" for languages and tools

## Extras enabled (`lazyvim.json`)

| Extra | Purpose |
|-------|---------|
| `ai.claudecode` | Claude Code integration |
| `editor.harpoon2` | Fast file navigation |
| `lang.docker` | Docker LSP + syntax |
| `lang.go` | Go LSP + tools |
| `lang.json` | JSON schema validation |
| `lang.typescript` | TypeScript/TSX LSP |
| `util.octo` | GitHub PRs/issues inside Neovim |

## Theme

Catppuccin Mocha via `lua/plugins/colorscheme.lua` — overrides LazyVim's default tokyonight.

## Structure

```
src/nvim/dot-config/nvim/
├── init.lua                   # bootstraps lazy.nvim
├── lazyvim.json               # enabled extras
└── lua/
    ├── config/
    │   ├── lazy.lua           # lazy.nvim setup
    │   ├── options.lua        # vim options
    │   ├── keymaps.lua        # custom keymaps
    │   └── autocmds.lua       # custom autocmds
    └── plugins/
        └── colorscheme.lua    # catppuccin mocha
```
