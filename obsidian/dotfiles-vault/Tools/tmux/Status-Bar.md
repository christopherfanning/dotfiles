# tmux — Status Bar

> Catppuccin v2 module-based status bar. Config: `src/tmux/dot-config/tmux/tmux.conf`

## Layout

```
[session name]                    [application] [cpu] [battery] [date time]
```

Status bar is at the **top** (`status-position top`).

## How catppuccin v2 modules work

After `run '...catppuccin.tmux'`, the plugin sets tmux user-options like `@catppuccin_status_session`. These are format strings that expand to styled segments.

```tmux
set -g status-left  "#{E:@catppuccin_status_session}"
set -g status-right "#{E:@catppuccin_status_application}"
```

`#{E:...}` tells tmux to expand the option as a format string.  
`set -agF` is used when the value itself contains format strings needing further expansion (e.g. battery percentage).

## Config keys

| Key | Value | Effect |
|-----|-------|--------|
| `@catppuccin_flavor` | `mocha` | Colour palette |
| `@catppuccin_window_status_style` | `rounded` | Rounded pill window tabs |
| `@catppuccin_window_current_number_color` | `#{@thm_peach}` | Active window tab colour |
| `@catppuccin_window_text` | ` #W` | Inactive window label (name) |
| `@catppuccin_window_current_text` | ` #W` | Active window label (name) |
| `@catppuccin_date_time_text` | `%a %Y-%m-%d %H:%M` | Date/time format |

## Available built-in modules

| Module | Requires | Shows |
|--------|----------|-------|
| `session` | — | Session name |
| `application` | — | Foreground process name |
| `directory` | — | Current pane path |
| `host` | — | Hostname |
| `user` | — | Username |
| `cpu` | tmux-cpu plugin | CPU % |
| `battery` | tmux-battery plugin | Battery % + icon |
| `date_time` | — | Date and time |
| `uptime` | — | System uptime |
| `load` | — | Load average |

## Adding a module

Append to `status-right` after the catppuccin `run` line:
```tmux
set -ag status-right "#{E:@catppuccin_status_uptime}"
```

## Load order note

Catppuccin must be `run` **before** the `status-left`/`status-right` lines so its color variables (`@thm_*`) are defined. The TPM `run` at the bottom re-runs it (idempotent). The mid-config `run` is guarded:

```tmux
run 'if [ -f ~/.tmux/plugins/tmux/catppuccin.tmux ]; then ...; fi'
```
