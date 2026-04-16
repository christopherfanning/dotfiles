# Ghostty — Config Reference

> All options in `~/.config/ghostty/config` explained. File: `src/ghostty/dot-config/ghostty/config`

## Terminal type

```
term = xterm-256color
```

| Value | Effect |
|-------|--------|
| `xterm-256color` | Maximum remote server compatibility — htop, ncurses, etc. work over SSH |
| `ghostty` | Native Ghostty terminfo — best features, but breaks on servers without it |

> See [[Issues/Ghostty-Remote-TERM]] for details on why `xterm-256color` is used.

## Font

| Option | Value | Effect |
|--------|-------|--------|
| `font-family` | `MesloLGS NF` | Nerd Font with Powerlevel10k icons |
| `font-size` | `14` | Base font size (pt) |
| `font-thicken` | `true` | Slight weight boost for readability on HiDPI |

## Window

| Option | Value | Effect |
|--------|-------|--------|
| `window-decoration` | `false` | No titlebar — cleaner look with Hyprland |
| `window-padding-x` | `10` | Horizontal padding (px) |
| `window-padding-y` | `10` | Vertical padding (px) |
| `window-inherit-working-directory` | `true` | New windows open in the same directory |

## Cursor

| Option | Value | Effect |
|--------|-------|--------|
| `cursor-style` | `block` | Block cursor (vs beam or underline) |
| `cursor-style-blink` | `false` | Static cursor — less distracting |

## Scrollback

```
scrollback-limit = 1000000
```

1 million lines. tmux has its own scrollback (`history-limit 500000`) — these are independent.

## Clipboard

| Option | Value | Effect |
|--------|-------|--------|
| `clipboard-read` | `allow` | Apps can read clipboard |
| `clipboard-write` | `allow` | Apps can write clipboard |
| `clipboard-paste-protection` | `true` | Warns before pasting multi-line content |

## Shell integration

```
shell-integration = zsh
shell-integration-features = cursor,sudo,title
```

| Feature | Effect |
|---------|--------|
| `cursor` | Cursor shape changes in insert vs normal vi mode |
| `sudo` | Preserves shell integration when running `sudo` |
| `title` | Sets window title to current command / directory |

## Theme

```
theme = Catppuccin Mocha
```

Ghostty ships Catppuccin themes built-in. No extra files needed.
