# Antidote

> A fast, simple zsh plugin manager — the spiritual successor to Antibody.

## Why Antidote (over Oh-My-Zsh / Zinit / Sheldon)

- **Simple**: One file (`~/.zsh_plugins.txt`) lists all plugins; one command loads them
- **Fast**: Plugins are bundled into a single sourced file — no interpreter overhead per plugin
- **Flexible**: Supports `kind:` annotations (`fpath`, `defer`, `path`) for fine-grained loading
- **OMZ compatible**: Can load individual Oh-My-Zsh plugins without the full framework

## Plugin file

`~/.zsh_plugins.txt` (managed by stow from `src/zsh/dot-zsh_plugins.txt`)

Key plugins loaded:

| Plugin | Purpose |
|--------|---------|
| `Aloxaf/fzf-tab` | fzf-powered tab completion |
| `romkatv/powerlevel10k` | Prompt |
| `zsh-users/zsh-autosuggestions` | Fish-style inline suggestions |
| `zdharma-continuum/fast-syntax-highlighting` | Syntax highlighting |
| `zsh-users/zsh-history-substring-search` | Up/down history search |
| `jeffreytse/zsh-vi-mode` | Proper vi mode |
| `jonmosco/kube-ps1` | Kubernetes context in prompt |
| `ohmyzsh/ohmyzsh` | Selected OMZ plugins (git, colored-man-pages) |

## Setup

```zsh
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load
```
