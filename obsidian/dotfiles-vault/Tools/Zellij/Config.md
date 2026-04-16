# Zellij — Config Reference

> All options in `config.kdl` explained. File: `src/zellij/dot-config/zellij/config.kdl`

## Top-level options

| Option | Value | Effect |
|--------|-------|--------|
| `theme` | `catppuccin-mocha` | Built-in Catppuccin Mocha palette — no extra files |
| `default_shell` | `zsh` | Shell used for new panes |
| `mouse_mode` | `true` | Click to focus, scroll with wheel |
| `copy_on_select` | `true` | Highlighted text auto-copies to clipboard |
| `scroll_buffer_size` | `50000` | Scrollback lines per pane |
| `pane_frames` | `false` | Hides pane border titles — cleaner look |
| `simplified_ui` | `false` | Keep the full UI (mode bar etc.) |
| `default_layout` | `compact` | Single-line status bar at bottom |

## Available layouts

| Value | Effect |
|-------|--------|
| `default` | Full UI with tab bar and mode bar |
| `compact` | Single-line combined bar |
| `disable-status-bar` | No status bar at all |

## Keybind config

`clear-defaults=false` — custom binds **add to** defaults, not replace them.

See [[Tools/Zellij/Keybinds]] for the full keybind reference.

## Themes

Catppuccin variants available out of the box:
- `catppuccin-mocha` (dark, warm purple)
- `catppuccin-macchiato`
- `catppuccin-frappe`
- `catppuccin-latte` (light)

Change by updating `theme "catppuccin-mocha"` in `config.kdl`.
