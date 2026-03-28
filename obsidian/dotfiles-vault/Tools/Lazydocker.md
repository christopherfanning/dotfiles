# Lazydocker

> A simple terminal UI for Docker and Docker Compose, written in Go.

## Why Lazydocker

- Same philosophy as Lazygit — everything visual, keyboard-driven
- Browse containers, images, volumes, networks in one screen
- Tail logs, exec into containers, restart/stop without remembering flags
- Docker Compose aware — shows service health, restarts whole stacks

## Key Bindings

| Key | Action |
|-----|--------|
| `[` / `]` | Switch between panels |
| `r` | Restart container |
| `s` | Stop container |
| `d` | Remove container/image |
| `l` | View logs |
| `e` | Exec into container |
| `?` | Help |

## Alias

```zsh
alias ld='lazydocker'
```
