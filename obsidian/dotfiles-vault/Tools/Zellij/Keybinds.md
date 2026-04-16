# Zellij — Keybinds

> Complete keybind reference for this config. File: `src/zellij/dot-config/zellij/config.kdl`

## Mode system

Zellij is **modal** — press a mode key, act, then `Esc` to return to Normal.

```
Normal  →  Ctrl+p  →  Pane mode
Normal  →  Ctrl+t  →  Tab mode
Normal  →  Ctrl+r  →  Resize mode
Normal  →  Ctrl+s  →  Scroll mode
Normal  →  Ctrl+o  →  Session mode
```

## Normal mode

| Key | Action |
|-----|--------|
| `Ctrl+p` | Enter Pane mode |
| `Ctrl+t` | Enter Tab mode |
| `Ctrl+r` | Enter Resize mode |
| `Ctrl+s` | Enter Scroll mode |
| `Ctrl+o` | Enter Session mode |
| `Ctrl+\` | New pane (split right) |
| `Ctrl+-` | New pane (split down) |

## Pane mode (`Ctrl+p` then…)

| Key | Action |
|-----|--------|
| `h` | Focus left pane → Normal |
| `j` | Focus down pane → Normal |
| `k` | Focus up pane → Normal |
| `l` | Focus right pane → Normal |
| `\|` | Split right → Normal |
| `-` | Split down → Normal |
| `x` | Close focused pane → Normal |
| `f` | Toggle fullscreen → Normal |
| `w` | Toggle floating pane → Normal |
| `Esc` | Return to Normal |

## Resize mode (`Ctrl+r` then…)

| Key | Action |
|-----|--------|
| `h` | Resize left (stays in Resize mode) |
| `j` | Resize down |
| `k` | Resize up |
| `l` | Resize right |
| `Esc` | Return to Normal |

## Scroll / Copy mode (`Ctrl+s` then…)

| Key | Action |
|-----|--------|
| `j` | Scroll down one line |
| `k` | Scroll up one line |
| `d` | Half-page down |
| `u` | Half-page up |
| `/` | Search downward |
| `?` | Search upward |
| `n` | Toggle case sensitivity |
| `q` or `Esc` | Return to Normal |

## Tab mode (`Ctrl+t` then…)

Built-in defaults (not customised):

| Key | Action |
|-----|--------|
| `n` | New tab |
| `x` | Close tab |
| `r` | Rename tab |
| `h / ←` | Previous tab |
| `l / →` | Next tab |

## Session management

In Session mode (`Ctrl+o`):

| Key | Action |
|-----|--------|
| `d` | Detach from session |
| `w` | Session manager (list/switch) |
