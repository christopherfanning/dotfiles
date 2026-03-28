# ctop

> Real-time container resource monitor. Think `htop` but for Docker containers.

## Why ctop

- See CPU, memory, network, block I/O per container at a glance
- Pause, stop, remove containers from the TUI
- Complements `lazydocker` — use ctop for live resource monitoring, lazydocker for logs/config

## Usage

```bash
ctop          # interactive TUI
ctop -i       # show idle (stopped) containers too
```

## Key bindings

| Key | Action |
|-----|--------|
| `q` | Quit |
| `s` | Sort by field |
| `a` | Toggle idle containers |
| `f` | Filter by name |
| `Enter` | Container detail view |
| `p` | Pause/unpause container |
