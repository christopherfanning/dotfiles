# Shell — Environment

> Environment variables and PATH setup. Files: `src/zsh/dot-zshenv`, `src/zsh/dot-zshrc`

## `~/.zshenv` — loaded everywhere

`zshenv` is sourced for **every** zsh invocation — interactive, non-interactive, login, scripts.  
Keep it minimal: only variables that must exist in all contexts.

```zsh
export EDITOR=nvim
export VISUAL=nvim
export PATH="$HOME/.local/bin:$PATH"
```

### Why set `EDITOR` here and not in `.zshrc`?

`.zshrc` is only loaded for interactive shells. Tools like `git commit`, `crontab -e`, and `visudo` launch `$EDITOR` from non-interactive contexts. Setting it in `.zshenv` ensures Neovim is always used.

---

## PATH — all additions

Defined in `.zshrc` (interactive additions) and `.zshenv` (always-on):

| Path | Source | Purpose |
|------|--------|---------|
| `~/.local/bin` | `.zshenv` | Local user binaries (pip install --user, etc.) |
| `~/bin` | `.zshrc` | Personal scripts (stowed from `src/bin/`) |
| `/usr/local/bin` | `.zshrc` | Homebrew / manual installs |
| `~/.local/share/JetBrains/Toolbox/apps` | `.zshrc` | JetBrains apps (IDEA, Rider, etc.) |
| `~/.local/share/JetBrains/Toolbox/scripts` | `.zshrc` | JetBrains wrapper scripts |
| `~/.krew/bin` | `.zshrc` | kubectl plugins installed via krew |
| `~/.config/emacs/bin` | `.zshrc` | Doom Emacs CLI tools |
| `~/.local/share/pnpm` | `.zshrc` | pnpm global package binaries |

## Key environment variables

| Variable | Value | Set in |
|----------|-------|--------|
| `EDITOR` | `nvim` | `.zshenv` |
| `VISUAL` | `nvim` | `.zshenv` |
| `HISTFILE` | `~/.local/share/zsh/history` | `.zshrc` |
| `NVM_DIR` | `~/.nvm` | `.zshrc` |
| `SDKMAN_DIR` | `~/.sdkman` | `.zshrc` |

## Tool environment initialisation order

Order in `.zshrc` matters — later inits can override earlier ones:

```
fzf bindings  →  atuin (overrides Ctrl+R)  →  navi  →  zoxide
→  mise  →  cargo  →  brew  →  SDKMan (must be last)
```

SDKMan must be at the very end — it resets the `sdk` function after every other init.
