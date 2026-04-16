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
| `Ctrl-b` | Prefix |
| `prefix \|` | Split vertical |
| `prefix -` | Split horizontal |
| `prefix h/j/k/l` | Navigate panes (vim-style) |
| `prefix r` | Reload config |
| `prefix Ctrl-s` | Save session (tmux-resurrect) |
| `prefix Ctrl-r` | Restore session (tmux-resurrect) |
| `prefix o` | Session manager via fzf (tmux-sessionx) |
| `prefix g` | Lazygit popup (full-screen) |
| `prefix u` | Pick URL from pane output (tmux-fzf-url) |

## Plugins (TPM)

| Plugin | Purpose |
|--------|---------|
| `tmux-sensible` | Sane defaults |
| `catppuccin/tmux#v2.3.0` | Catppuccin Mocha theme (v2, rounded windows) |
| `tmux-cpu` | CPU/RAM status bar modules |
| `tmux-battery` | Battery status bar module |
| `tmux-yank` | Copy to system clipboard |
| `tmux-resurrect` | Save & restore sessions across reboots |
| `tmux-continuum` | Auto-save every 10 min |
| `vim-tmux-navigator` | Seamless navigation between vim splits and tmux panes |
| `tmux-sessionx` | fzf-powered session manager |
| `tmux-fzf-url` | Open URLs from pane output with fzf |

## Status bar

Status bar sits at the **top**. Left shows session name; right shows:
`application → CPU → battery → date/time`

Powered by catppuccin v2 module system — modules use `#{E:@catppuccin_status_<name>}` format.
The catppuccin plugin is loaded mid-config (before status-right) so its color variables are available,
then TPM runs all plugins again at the bottom (idempotent).

## Install plugins

After first stow, open tmux and press `prefix + I` to install all TPM plugins.

## Sub-pages

- [[Tools/tmux/Config]] — all `tmux.conf` options explained
- [[Tools/tmux/Plugins]] — each TPM plugin documented
- [[Tools/tmux/Status-Bar]] — catppuccin v2 status bar
- [[Tools/tmux-vs-zellij]] — when to use tmux vs Zellij
