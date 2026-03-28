# Zoxide

> A smarter `cd` that learns your most-used directories, written in Rust.

## Why Zoxide (over z / autojump)

- **Faster**: No shell function overhead — it's a native binary
- **Smarter ranking**: Frecency algorithm (frequency + recency)
- **Interactive**: `zi` opens an fzf picker of your top directories
- **Drop-in**: Replaces `z`, `j`, and plain `cd` with no workflow change

## Usage

```zsh
z dotfiles        # jump to ~/dotfiles (or wherever matches)
z con nvim        # jump to ~/.config/nvim
zi                # interactive fzf picker
```

## Setup

Initialised in `.zshrc`:

```zsh
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"
```

This creates the `z` and `zi` commands (and optionally aliases `cd` — not done here to avoid surprises).
