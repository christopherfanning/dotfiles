# Ghostty

> Fast, native terminal emulator written in Zig/Swift. GPU-accelerated, first-class shell integration.

## Why Ghostty

- **Performance**: GPU-rendered, noticeably faster than Kitty or Alacritty for large scrollback
- **Shell integration**: Native cursor tracking, sudo prompts, window title — no hacks required
- **Config is simple**: One flat config file, no complex YAML or TOML syntax
- **Actively maintained**: Rapid development cadence

## Configuration

Config lives at `~/.config/ghostty/config` (managed by stow from `src/ghostty/`).

Key settings:

```
term = xterm-256color   # see Issues/Ghostty-Remote-TERM
font-family = MesloLGS NF
theme = catppuccin-mocha
shell-integration = zsh
```

## Known Issues

- [[Issues/Ghostty-Remote-TERM]] — `htop` / `ncurses` programs fail on remote SSH sessions
