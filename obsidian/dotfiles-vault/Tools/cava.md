# cava — Console Audio Visualizer

> Real-time audio spectrum visualizer for the terminal.

## Why cava

- Visualizes audio output in real-time in a terminal window
- Customizable bars, colors, and frame rate
- Pairs well with music players (mpv, cmus, spotify)
- Great in a tmux pane alongside your workflow

## Usage

```bash
cava    # start visualizer (Ctrl+C to exit)
```

## Config

`~/.config/cava/config` — auto-generated on first run.

Key settings:

```ini
[general]
bars = 50
framerate = 60

[color]
gradient = 1
gradient_color_1 = '#94e2d5'  # catppuccin teal
gradient_color_2 = '#89dceb'  # catppuccin sky
gradient_color_3 = '#89b4fa'  # catppuccin blue
gradient_color_4 = '#b4befe'  # catppuccin lavender
```

## Key bindings (while running)

| Key | Action |
|-----|--------|
| `q` / `Ctrl+C` | Quit |
| `+` / `-` | Increase/decrease sensitivity |
| `r` | Reload config |
| `f` / `b` | Cycle foreground/background color |
