# Atuin — Config Reference

> All options in `config.toml` explained. File: `src/atuin/dot-config/atuin/config.toml`

## Search

| Option | Value | Effect |
|--------|-------|--------|
| `search_mode` | `fuzzy` | Fuzzy match anywhere in the command |
| `search_mode_shell_up_key_binding` | `fuzzy` | Same mode when pressing `↑` |
| `filter_mode` | `global` | Search across all machines and sessions |
| `filter_mode_shell_up_key_binding` | `global` | Same for `↑` key |

Filter mode options: `global` · `host` · `session` · `directory`

## UI

| Option | Value | Effect |
|--------|-------|--------|
| `show_preview` | `true` | Shows full command below the list |
| `max_preview_height` | `4` | Preview area height (lines) |
| `enter_accept` | `true` | `Enter` executes immediately; `Tab` to edit first |
| `inline_height` | `0` | `0` = full-screen TUI |
| `invert` | `true` | Search bar at top (more natural full-screen) |
| `keymap_mode` | `auto` | Uses vi or emacs bindings to match shell mode |

## Privacy

| Option | Value | Effect |
|--------|-------|--------|
| `secrets_filter` | `true` | Strips AWS keys, GitHub PATs, Slack tokens, etc. |
| `auto_sync` | `false` | No automatic cloud sync — opt-in only |

## Columns (what's shown per row)

```toml
columns = ["exit", "duration", { type = "time", width = 10 }, { type = "directory", width = 25 }, "command"]
```

| Column | Shows |
|--------|-------|
| `exit` | Coloured exit code (green=0, red=non-zero) |
| `duration` | How long the command ran |
| `time` | When it ran (10 chars wide) |
| `directory` | Where it ran (25 chars wide) |
| `command` | The command itself |

## Stats tracking

```toml
[stats]
common_subcommands = ["cargo", "docker", "git", "go", "kubectl", "npm", "pnpm", "systemctl", "tmux", "yay", "pacman"]
ignored_commands   = ["ls", "ll", "la", "cd", "exit", "clear"]
```

`common_subcommands` — `atuin stats` shows `git commit` not just `git`  
`ignored_commands` — excluded from stats (too noisy)

## tmux popup

```toml
[tmux]
enabled = true
width   = "90%"
height  = "70%"
```

Opens the Atuin TUI as a tmux popup instead of inline. Requires tmux ≥ 3.2.

## Sync (optional)

```toml
[sync]
records = true
```

Sync is off by default. To opt in:
```bash
atuin register   # first machine
atuin login      # subsequent machines
atuin sync       # manual sync
```
