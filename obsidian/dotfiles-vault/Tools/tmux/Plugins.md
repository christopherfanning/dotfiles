# tmux — Plugins Reference

> All TPM plugins, what they do, and their keybinds.

Install all plugins: `prefix + I`  
Update all plugins: `prefix + U`  
Remove unlisted: `prefix + alt+u`

## Plugin list

### `tmux-plugins/tmux-sensible`
Sane defaults everyone agrees on: `utf8`, faster key sequences, larger history, focus events. No config needed.

### `catppuccin/tmux#v2.3.0`
Catppuccin Mocha colour theme. Pinned to v2.3.0.
Config: [[Tools/tmux/Status-Bar]]

### `tmux-plugins/tmux-cpu`
Provides `#{cpu_percentage}` and `#{ram_percentage}` format strings.
Used by catppuccin's `@catppuccin_status_cpu` module.

### `tmux-plugins/tmux-battery`
Provides `#{battery_percentage}` and `#{battery_icon}`.
Used by catppuccin's `@catppuccin_status_battery` module.

### `tmux-plugins/tmux-yank`
Copy to system clipboard from copy mode.

| Key | Action |
|-----|--------|
| `y` (copy mode) | Copy selection to clipboard |
| `Y` (copy mode) | Copy and paste to command line |
| `prefix y` | Copy current pane's command |

### `tmux-plugins/tmux-resurrect`
Save and restore sessions across reboots.

| Key | Action |
|-----|--------|
| `prefix Ctrl+s` | Save session |
| `prefix Ctrl+r` | Restore session |

Options set:
- `resurrect-capture-pane-contents on` — saves scrollback too
- `resurrect-strategy-nvim session` — restores Neovim sessions via `Session.vim`

### `tmux-plugins/tmux-continuum`
Auto-saves every 10 minutes using tmux-resurrect.  
`continuum-restore on` — restores last session on tmux server start.

### `christoomey/vim-tmux-navigator`
Seamless `Ctrl+h/j/k/l` movement between Neovim splits and tmux panes.  
No prefix needed — works transparently in both.

### `omerxx/tmux-sessionx`
fzf-powered session manager.

| Key | Action |
|-----|--------|
| `prefix o` | Open session picker |

Features: preview, rename, delete, create from picker.

### `wfxr/tmux-fzf-url`
Picks URLs from visible pane output and opens them in the browser.

| Key | Action |
|-----|--------|
| `prefix u` | Open URL picker |
