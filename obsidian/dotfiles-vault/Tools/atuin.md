# atuin — Shell History Sync

> Replaces shell history with a searchable, syncable SQLite database.

## Why atuin (over fzf Ctrl+R)

| Feature | fzf+history | atuin |
|---------|-------------|-------|
| Search | Fuzzy text | Fuzzy + regex + prefix |
| Context | Command only | Command + exit code + duration + cwd |
| Sync | None | Encrypted sync across machines |
| Stats | None | `atuin stats` — most used commands |
| Storage | `~/.zsh_history` flat file | SQLite database |

Atuin takes over `Ctrl+R` — loaded in `.zshrc` after fzf and `zsh-fzf-history-search` so it wins when installed.

## Storage

- **DB location:** `~/.local/share/atuin/history.db` (SQLite)
- **No row limit** — keeps history forever
- **~450 bytes/entry** → 1 million commands ≈ 430 MB
- Secrets filter strips AWS keys, GitHub PATs, Slack tokens automatically

## Config

Managed by stow: `src/atuin/dot-config/atuin/config.toml` → `~/.config/atuin/config.toml`

Key settings:

| Setting | Value |
|---------|-------|
| `search_mode` | `fuzzy` |
| `invert` | `true` (search bar at top) |
| `inline_height` | `0` (full-screen TUI) |
| `enter_accept` | `true` (Enter executes, Tab edits) |
| `secrets_filter` | `true` |
| `[tmux] enabled` | `true` — popup (90×70%) inside tmux |
| `columns` | exit · duration · time · directory · command |

## Setup

On a new machine (handled automatically by `install.dotfiles.sh`):

```bash
atuin import zsh   # import ~/.local/share/zsh/history
atuin import bash  # import ~/.bash_history
```

To sync across machines (optional — works fully offline without this):

```bash
atuin register    # first machine
atuin login       # subsequent machines
```

## HISTFILE

`~/.zshrc` explicitly sets `HISTFILE="$HOME/.local/share/zsh/history"` so zsh and atuin always use the same file. Without this, zsh falls back to `~/.histfile` or `~/.zsh_history` and the import path breaks.

## Usage

| Action | Shortcut / Command |
|--------|--------------------|
| Search history | `Ctrl+R` |
| Show stats | `atuin stats` |
| Sync now | `atuin sync` |
| Import history | `atuin import auto` |

## No sync (local only)

atuin works fully offline — sync is optional. The local SQLite history alone is a major upgrade over `.zsh_history`.
