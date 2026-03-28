# Hyprland

> Wayland compositor with tiling layout, smooth animations, and excellent multi-monitor support.

## Why Hyprland

- Best-in-class Wayland performance and animations
- Declarative config — everything in `~/.config/hypr/hyprland.conf`
- Vim-style keybindings (`Super+hjkl` for focus, `Super+Shift+hjkl` to move windows)
- Catppuccin Mocha themed across the full stack
- Switchable at login — KDE Plasma still available, not replaced

## Stack

| Component | Role |
|-----------|------|
| **hyprland** | Compositor / window manager |
| **waybar** | Status bar (top, catppuccin mocha) |
| **hyprpaper** | Wallpaper |
| **hypridle** | Idle management (dim → lock → screen off) |
| **hyprlock** | Screen locker (catppuccin clock face) |
| **wofi** | App launcher (`Super+Space`) |
| **dunst** | Notifications |
| **grim + slurp** | Screenshots |
| **cliphist** | Clipboard history (`Super+.`) |

## Keybindings

| Key | Action |
|-----|--------|
| `Super+Return` | Terminal (Ghostty) |
| `Super+Space` | App launcher (wofi) |
| `Super+hjkl` | Move focus (vim-style) |
| `Super+Shift+hjkl` | Move window |
| `Super+Ctrl+hjkl` | Resize window |
| `Super+1-9` | Switch workspace |
| `Super+Shift+1-9` | Move window to workspace |
| `Super+S` | Toggle scratchpad |
| `Super+V` | Toggle floating |
| `Super+Z` | Fullscreen |
| `Super+Shift+Q` | Close window |
| `Super+F` | Yazi (file manager) |
| `Super+G` | Lazygit |
| `Super+Shift+D` | Lazydocker |
| `Super+.` | Clipboard history |
| `Print` | Full screenshot |
| `Shift+Print` | Region screenshot |
| `Super+Shift+X` | Lock screen |

## Stow packages

Three separate packages (can stow/unstow independently):

```bash
stow --dotfiles -d src -t ~ hyprland   # hyprland.conf, hyprpaper, hypridle, hyprlock
stow --dotfiles -d src -t ~ waybar     # status bar config + CSS
stow --dotfiles -d src -t ~ wofi       # launcher config + CSS
```

## First run

1. Drop a wallpaper at `~/Pictures/wallpapers/default.png`
2. Select **Hyprland** at the login screen
3. `waybar` and `hyprpaper` autostart via `exec-once`

## Notes

- `xdg-desktop-portal-hyprland` is required for screen sharing (Zoom, OBS, etc.)
- KDE apps work fine under Hyprland via XWayland and `qt5/6-wayland`
