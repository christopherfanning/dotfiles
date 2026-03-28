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

Atuin takes over `Ctrl+R` — loaded in `.zshrc` after fzf so it wins.

## Setup

On a new machine:

```bash
atuin login    # sync with existing account
atuin import auto   # import existing shell history
```

First machine:

```bash
atuin register    # create account for sync
```

## Usage

| Action | Command |
|--------|---------|
| Search history | `Ctrl+R` |
| Show stats | `atuin stats` |
| Sync now | `atuin sync` |
| Import history | `atuin import auto` |

## No sync (local only)

atuin works fully offline — sync is optional. The local SQLite history alone is a major upgrade over `.zsh_history`.
