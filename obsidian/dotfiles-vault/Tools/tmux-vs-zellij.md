# tmux vs Zellij

> Both are terminal multiplexers — persistent sessions, splits, windows. Here's how to choose.

## Quick decision

| If you want… | Use |
|---|---|
| Maximum scriptability and remote-server muscle memory | **tmux** |
| A discoverable UI while learning | **Zellij** |
| Plugin ecosystem (resurrect, sessionx, etc.) | **tmux** |
| Floating panes | **Zellij** |
| Layouts as code (KDL files) | **Zellij** |
| Long-running server that persists past reboots | **tmux** |

**TL;DR**: Use tmux as your daily driver. Use Zellij when you want a friendlier local workspace or to explore its layout system.

## Feature comparison

| Feature | tmux | Zellij |
|---------|------|--------|
| Config format | `tmux.conf` (tcl-like) | KDL |
| Plugin system | Shell scripts (TPM) | WASM |
| Floating panes | Via `display-popup` | Built-in, persistent |
| Session persistence | tmux-resurrect + continuum | Session-based (restores on attach) |
| UI discoverability | Invisible (learn keybinds) | Always-visible mode bar |
| Vim keybinds | Full copy mode | Partial (pane/resize modes) |
| Remote server use | Excellent — ubiquitous | Less common on servers |
| GPU/rendering | None (terminal handles it) | None |
| Image passthrough | Yes (`allow-passthrough on`) | Yes |
| Startup overhead | tmux server stays running | Starts fresh each time |
| Status bar | Highly customisable | Fixed (tabs + mode bar) |

## Modal system comparison

Both use **modes** — a key chord switches mode, you act, then return to normal.

**tmux**: `prefix` → action → back to normal (single-action modal)  
**Zellij**: `Ctrl+p` → pane mode → multiple actions → `Esc` (persistent modal)

Zellij's persistent modes are more efficient for multi-step operations (e.g. resize several panes). tmux's single-shot prefix is faster for isolated commands.

## Plugin ecosystem

tmux has a mature, battle-tested ecosystem:
- **tmux-resurrect** — save/restore sessions including Neovim state
- **tmux-continuum** — automatic saves
- **tmux-sessionx** — fzf session manager
- **vim-tmux-navigator** — transparent Neovim integration

Zellij plugins are WASM-based — more sandboxed and portable, but the ecosystem is younger.

## When to use each

**Use tmux when:**
- SSH-ing into remote servers (tmux is everywhere)
- Running long background processes that must survive disconnects
- You want Neovim ↔ pane navigation without thinking about it
- You need session save/restore across reboots

**Use Zellij when:**
- Onboarding someone new to terminal multiplexers
- You want persistent floating panes (scratch terminals)
- You want to define project layouts declaratively in KDL
- Local-only workflow where you don't need remote compatibility

## This setup

Both are configured and stowed:
- tmux: `src/tmux/` → `~/.config/tmux/tmux.conf`
- Zellij: `src/zellij/` → `~/.config/zellij/config.kdl`

They can run simultaneously — open Zellij inside a tmux pane, or vice versa.
