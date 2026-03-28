# tmux

> Terminal multiplexer — persistent sessions, splits, and windows in any terminal.

## Why tmux

- **Persistence**: Sessions survive terminal closes and SSH disconnects
- **Splits**: Horizontal/vertical panes without needing a tiling WM
- **Scripting**: Automate window/pane layouts at project startup
- **Ubiquitous**: Available on every Linux/macOS machine; no GUI required

## Configuration

Config lives at `~/.config/tmux/tmux.conf` (managed by stow from `src/tmux/`).

### Key Bindings

| Key | Action |
|-----|--------|
| `Ctrl-a` | Prefix (replaces default `Ctrl-b`) |
| `prefix \|` | Split vertical |
| `prefix -` | Split horizontal |
| `prefix h/j/k/l` | Navigate panes (vim-style) |
| `prefix r` | Reload config |
| `prefix Ctrl-s` | Save session (tmux-resurrect) |
| `prefix Ctrl-r` | Restore session (tmux-resurrect) |
| `prefix o` | Session manager via fzf (tmux-sessionx) |

## Plugins (TPM)

| Plugin | Purpose |
|--------|---------|
| `tmux-sensible` | Sane defaults |
| `catppuccin/tmux` | Catppuccin Mocha theme |
| `tmux-yank` | Copy to system clipboard |
| `tmux-resurrect` | Save & restore sessions across reboots |
| `tmux-continuum` | Auto-save every 10 min |
| `vim-tmux-navigator` | Seamless navigation between vim splits and tmux panes |
| `tmux-sessionx` | fzf-powered session manager |

## Install plugins

After first stow, open tmux and press `prefix + I` to install all TPM plugins.
