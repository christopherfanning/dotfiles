# Zsh — Config Reference

> `.zshrc` section-by-section breakdown. File: `src/zsh/dot-zshrc`

## Load order

```
P10k instant prompt  →  antidote  →  history  →  completions
→  options  →  keybindings  →  PATH  →  aliases  →  tool inits
→  P10k theme
```

## Powerlevel10k instant prompt

Must be **first** — caches the prompt so it renders before the rest of `.zshrc` loads.

```zsh
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source ...
fi
```

## Antidote

Tries three paths in order — works on Arch (yay), macOS (brew), or manual clone:

```zsh
for _p in /usr/share/zsh-antidote/antidote.zsh \
           $(brew --prefix)/opt/antidote/... \
           ~/.antidote/antidote.zsh
```

`antidote load` reads `~/.zsh_plugins.txt` and sources all plugins.

## History

| Option | Effect |
|--------|--------|
| `HISTFILE=~/.local/share/zsh/history` | XDG-compliant, never lost |
| `HISTSIZE=100000` | In-memory entries |
| `SAVEHIST=100000` | Written to file |
| `EXTENDED_HISTORY` | Saves timestamp + duration per entry |
| `INC_APPEND_HISTORY_TIME` | Writes immediately after each command (crash-safe) |
| `HIST_IGNORE_ALL_DUPS` | Removes older duplicates |
| `HIST_VERIFY` | Shows expansion before executing `!` history |

## Keybindings

| Binding | Action |
|---------|--------|
| `bindkey -v` | Vi mode (insert/normal) |
| `↑ / ↓` | History substring search |
| `k / j` (normal mode) | History substring search up/down |

## PATH additions

| Path | Purpose |
|------|---------|
| `~/bin` | Personal scripts |
| `~/.local/share/JetBrains/...` | JetBrains Toolbox apps + scripts |
| `~/.krew/bin` | kubectl plugins |
| `~/.config/emacs/bin` | Doom Emacs |
| `~/.local/share/pnpm` | pnpm global bins |

## Tool initialisations (eval lines)

| Tool | Why it's here |
|------|--------------|
| `atuin init zsh` | After fzf bindings — takes over `Ctrl+R` |
| `navi widget zsh` | `Ctrl+G` cheatsheet browser |
| `zoxide init zsh --cmd cd` | Replaces `cd` with smart jump |
| `mise activate zsh` | Polyglot version manager |
| `brew shellenv` | Linuxbrew path setup |
