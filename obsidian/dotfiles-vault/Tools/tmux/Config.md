# tmux — Config Reference

> All options in `tmux.conf` explained. File: `src/tmux/dot-config/tmux/tmux.conf`

## Prefix

```
set -g prefix C-b
```

`Ctrl+b` is the default tmux prefix. All tmux commands start with this chord.

## Mouse & window base

| Option | Value | Effect |
|--------|-------|--------|
| `mouse` | `on` | Click to focus panes/windows, scroll with wheel |
| `base-index` | `0` | Windows numbered from 0 |
| `pane-base-index` | `0` | Panes numbered from 0 |
| `renumber-windows` | `on` | Gaps close when a window is closed |

## Vi copy mode

| Option | Effect |
|--------|--------|
| `mode-keys vi` | `hjkl`, `/` search in scroll mode |
| `v` | Begin selection |
| `C-v` | Rectangle selection |
| `y` | Copy selection and exit |

## Splits

| Bind | Action |
|------|--------|
| `prefix \|` | Vertical split (opens in current path) |
| `prefix -` | Horizontal split (opens in current path) |
| `prefix c` | New window (opens in current path) |

## Pane navigation & resize

| Bind | Action |
|------|--------|
| `prefix h/j/k/l` | Move focus (vim-style) |
| `prefix H/J/K/L` | Resize pane (repeatable with `-r`) |

## Performance options

| Option | Value | Effect |
|--------|-------|--------|
| `default-terminal` | `tmux-256color` | True color inside tmux |
| `terminal-overrides` | `xterm-256color:RGB` | Enables 24-bit RGB colour |
| `escape-time` | `0` | Eliminates Neovim `<Esc>` lag |
| `history-limit` | `500000` | Scrollback lines |
| `focus-events` | `on` | Lets Neovim detect focus gain/loss |
| `set-clipboard` | `on` | Passes clipboard through to terminal |
| `allow-passthrough` | `on` | Passes sixel/kitty graphics through (yazi image preview) |

## Special binds

| Bind | Action |
|------|--------|
| `prefix r` | Reload `tmux.conf` |
| `prefix g` | Full-screen lazygit popup (closes on exit) |
| `prefix o` | Session manager (tmux-sessionx / fzf) |
| `prefix u` | Pick URL from pane output (fzf) |
