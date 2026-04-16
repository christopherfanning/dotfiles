# Neovim — Colorscheme

> Catppuccin Mocha configuration. File: `src/nvim/dot-config/nvim/lua/plugins/colorscheme.lua`

## Setup

```lua
colorscheme = "catppuccin-mocha"
flavour = "mocha"
background = { light = "latte", dark = "mocha" }
```

`background.light/dark` means toggling `vim.o.background` switches between Latte (light) and Mocha (dark) automatically.

## Plugin integrations enabled

| Integration | What it themes |
|-------------|---------------|
| `cmp` | Completion menu |
| `gitsigns` | Git diff signs in gutter |
| `harpoon` | Harpoon mark UI |
| `noice` | Command line / notifications |
| `notify` | Notification popups |
| `telescope` | Fuzzy finder UI |
| `treesitter` | Syntax highlighting |
| `which_key` | Keybind popup |
| `mini` | mini.nvim components |
| `native_lsp` | LSP diagnostic highlights |
| `indent_blankline` | Indentation guides |
| `mason` | Package manager UI |
| `lsp_trouble` | Diagnostics list |

## Consistency

The same Catppuccin Mocha palette is used across the entire stack:
- Ghostty → `theme = Catppuccin Mocha`
- tmux → `@catppuccin_flavor 'mocha'`
- Yazi → `src/yazi/dot-config/yazi/theme.toml`
- Zellij → `theme "catppuccin-mocha"`
- Neovim → this file
