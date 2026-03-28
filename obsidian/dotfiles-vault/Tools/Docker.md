# Docker

> Container platform. Required for `lazydocker` to work.

## Install (Arch)

```bash
sudo pacman -S docker docker-compose
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
# Log out and back in for group membership to take effect
```

## TUI Tools

| Tool | Purpose |
|------|---------|
| `lazydocker` (`ld`) | Full Docker/Compose TUI — containers, logs, stats |
| `dive` | Explore image layers to find what's bloating an image |
| `ctop` | Container resource monitor (if needed alongside lazydocker) |

## Aliases

```zsh
alias ld='lazydocker'
```

## dive — Docker image explorer

```bash
dive <image>        # interactive layer explorer
dive build <tag>    # build and immediately inspect
```
