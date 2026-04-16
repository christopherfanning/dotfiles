# Zsh

> The shell powering this stack — fast, extensible, and fully configured for a modern dev workflow.

## Why Zsh

- **Antidote** handles plugins — no slow `oh-my-zsh` framework overhead
- **Powerlevel10k** prompt with instant prompt (zero startup lag)
- **Vi mode** built-in — same muscle memory as Neovim
- **fzf-tab** replaces the default completion menu with fuzzy search

## Config files (managed by stow from `src/zsh/`)

| File | Purpose |
|------|---------|
| `~/.zshrc` | Main interactive config |
| `~/.zshenv` | Environment vars (all contexts) |
| `~/.zsh_plugins.txt` | Antidote plugin list |

## Sub-pages

- [[Tools/Zsh/Config]] — `.zshrc` sections explained
- [[Tools/Zsh/Plugins]] — antidote plugin list explained
- [[Tools/Zsh/Options]] — `setopt` flags reference
- [[Tools/Zsh/Completions]] — completion system deep-dive
