# Lazygit

> A simple terminal UI for git commands, written in Go.

## Why Lazygit

- **Speed**: Navigate commits, branches, diffs, and stash without typing git commands
- **Vim keybindings**: `hjkl` navigation, `/` to filter, `?` for help panel
- **Interactive rebase**: Squash, reorder, drop commits with a keypress
- **One-key operations**: Stage hunks, resolve conflicts, cherry-pick, all in-place
- **Paired with delta**: `git-delta` as the pager makes diffs beautiful

## Key Bindings

| Key | Action |
|-----|--------|
| `space` | Stage / unstage file |
| `c` | Commit |
| `P` | Push |
| `p` | Pull |
| `b` | Branch menu |
| `i` | Interactive rebase |
| `?` | Keybinding help |

## Alias

```zsh
alias lg='lazygit'
```
