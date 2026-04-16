# Zellij

> A terminal workspace — multiplexer with a persistent UI, built-in layouts, and a plugin system.

## Why Zellij

- **Discoverable UI**: Always-visible keybind bar means no cheat-sheet needed while learning
- **Floating panes**: Overlay panes on demand — great for quick lookups without losing context
- **Built-in layouts**: Define window arrangements in KDL files; restore them instantly
- **WebAssembly plugins**: Extensible without shell scripts
- **Catppuccin built-in**: No extra theme files; just set `theme "catppuccin-mocha"`
- **Good tmux alternative**: Modal system similar to tmux but friendlier to new users

## Configuration

Config lives at `~/.config/zellij/config.kdl` (managed by stow from `src/zellij/`).

Uses [KDL](https://kdl.dev/) format — similar to TOML but block-structured.

## Keybinds

Zellij uses a **modal** system. Press the mode key, do your action, then return to Normal.

### Normal mode

| Key | Action |
|-----|--------|
| `Ctrl-p` | Enter **Pane** mode |
| `Ctrl-t` | Enter **Tab** mode |
| `Ctrl-r` | Enter **Resize** mode |
| `Ctrl-s` | Enter **Scroll** mode |
| `Ctrl-o` | Enter **Session** mode |
| `Ctrl-\` | New pane (split right) |
| `Ctrl--` | New pane (split down) |

### Pane mode (`Ctrl-p` then…)

| Key | Action |
|-----|--------|
| `h / j / k / l` | Move focus (vim-style) |
| `\|` | Split right |
| `-` | Split down |
| `x` | Close focused pane |
| `f` | Toggle fullscreen |
| `w` | Toggle floating pane |
| `Esc` | Return to Normal |

### Resize mode (`Ctrl-r` then…)

| Key | Action |
|-----|--------|
| `h / j / k / l` | Resize in direction |
| `Esc` | Return to Normal |

### Scroll / Copy mode (`Ctrl-s` then…)

| Key | Action |
|-----|--------|
| `j / k` | Scroll down / up |
| `d / u` | Half-page down / up |
| `/` | Search down |
| `?` | Search up |
| `q` or `Esc` | Return to Normal |

## Layouts

Zellij layout files go in `~/.config/zellij/layouts/`. The default layout is set in `config.kdl`:

```kdl
default_layout "compact"
```

Example custom layout (`~/.config/zellij/layouts/dev.kdl`):

```kdl
layout {
    pane split_direction="vertical" {
        pane size="60%"
        pane split_direction="horizontal" {
            pane
            pane
        }
    }
    pane size=1 borderless=true { plugin location="zellij:compact-bar"; }
}
```

Start a named layout: `zellij --layout dev`

## Sessions

```bash
zellij                          # start or attach to last session
zellij attach my-session        # attach to named session
zellij list-sessions            # list active sessions
zellij delete-session my-session
```

## vs tmux

| Feature | Zellij | tmux |
|---------|--------|------|
| Learning curve | Lower (visible UI) | Higher (muscle memory) |
| Config format | KDL | conf (tcl-like) |
| Plugin system | WASM | shell scripts |
| Performance | Very fast | Very fast |
| Server longevity | Session-based | Long-lived server |
| Floating panes | ✓ built-in | via popup |
| Scriptability | Moderate | Excellent |

**Recommendation**: Use tmux for scripted project workflows and remote sessions; use Zellij when you want a friendlier local workspace.

## Tips

- `copy_on_select true` in config means highlighted text auto-copies to clipboard — no extra keypress needed
- Pane frames are disabled (`pane_frames false`) for a cleaner look; the compact bar at the bottom shows the mode
- `scroll_buffer_size 50000` keeps plenty of history for log tailing
