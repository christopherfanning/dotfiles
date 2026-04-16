# Neovim — LazyVim Extras

> Enabled extras from `src/nvim/dot-config/nvim/lazyvim.json`

Extras are LazyVim's curated plugin packs. Enable them in `lazyvim.json` and they install, configure, and wire up LSPs automatically.

## Enabled extras

### AI
| Extra | What it adds |
|-------|-------------|
| `extras.ai.avante` | Avante.nvim — inline AI assistant with diff view |
| `extras.ai.copilot` | GitHub Copilot inline completions |
| `extras.ai.copilot-chat` | Copilot chat panel (`<leader>a` binds) |

### Editor
| Extra | What it adds |
|-------|-------------|
| `extras.editor.harpoon2` | Harpoon 2 — quick-mark and jump between files |

### Languages
| Extra | What it adds |
|-------|-------------|
| `extras.lang.docker` | Dockerfile LSP + syntax |
| `extras.lang.go` | Go LSP, formatter, test runner |
| `extras.lang.json` | JSON LSP + schema validation |
| `extras.lang.typescript` | TypeScript/JavaScript LSP + formatter |

### Utilities
| Extra | What it adds |
|-------|-------------|
| `extras.util.octo` | GitHub PRs and issues inside Neovim |

## Adding an extra

1. Open Neovim, run `:LazyExtras`
2. Find the extra and press `x` to enable
3. This writes to `lazyvim.json` — changes are tracked in git

## Browse available extras

```
:LazyExtras
```

Or visit: https://www.lazyvim.org/extras
