# Dotfiles Vault

> Documentation for the `~/dotfiles` repo — why each tool was chosen, how it's configured, and known issues.

> 📋 **[[Keybinds]]** — full cross-tool keybind reference (tmux · Neovim · zsh · Hyprland · Yazi · Lazygit · atuin)

## Shell

| Doc | Purpose |
|-----|---------|
| [[Tools/Zsh]] | Zsh overview |
| [[Tools/Zsh/Config]] | `.zshrc` sections explained |
| [[Tools/Zsh/Plugins]] | Antidote plugin list |
| [[Tools/Zsh/Options]] | `setopt` flags reference |
| [[Tools/Zsh/Completions]] | Completion system deep-dive |
| [[Shell/Aliases]] | All aliases documented |
| [[Shell/Environment]] | `EDITOR`, `PATH`, env vars |

## Terminal & Multiplexer

| Tool | Purpose |
|------|---------|
| [[Tools/Ghostty]] | Terminal emulator |
| [[Tools/Ghostty/Config]] | Config reference |
| [[Tools/tmux]] | Terminal multiplexer |
| [[Tools/tmux/Config]] | `tmux.conf` reference |
| [[Tools/tmux/Plugins]] | TPM plugins explained |
| [[Tools/tmux/Status-Bar]] | Catppuccin v2 status bar |
| [[Tools/Zellij]] | Terminal workspace (multiplexer alternative) |
| [[Tools/Zellij/Config]] | `config.kdl` reference |
| [[Tools/Zellij/Keybinds]] | Full keybind reference |
| [[Tools/tmux-vs-zellij]] | Comparison — when to use each |

## Editor

| Tool | Purpose |
|------|---------|
| [[Tools/Neovim-LazyVim]] | Neovim + LazyVim overview |
| [[Tools/Neovim/Extras]] | Enabled LazyVim extras |
| [[Tools/Neovim/AI-Plugins]] | CodeCompanion + MCP Hub |
| [[Tools/Neovim/Colorscheme]] | Catppuccin integration |

## File Management & Navigation

| Tool | Purpose |
|------|---------|
| [[Tools/Yazi]] | File manager |
| [[Tools/Yazi/Config]] | `yazi.toml` reference |
| [[Tools/Yazi/Keymap]] | Custom keybinds |
| [[Tools/Yazi/Image-Preview]] | Image preview in tmux |
| [[Tools/Zoxide]] | Smarter `cd` |
| [[Tools/Eza]] | Modern `ls` |
| [[Tools/FZF]] | Fuzzy finder |

## History & Search

| Tool | Purpose |
|------|---------|
| [[Tools/atuin]] | Shell history (replaces Ctrl+R) |
| [[Tools/Atuin/Config]] | `config.toml` reference |

## Git & DevOps

| Tool | Purpose |
|------|---------|
| [[Tools/Lazygit]] | Git TUI |
| [[Tools/Lazydocker]] | Docker TUI |
| [[Tools/Worktrunk]] | Git worktree manager |
| [[Tools/GitHub-CLI]] | `gh` — PRs, issues, CI |
| [[Tools/Docker]] | Containers + tooling |
| [[Tools/AWS-Workflow]] | aws-cli, aws-vault, Packer, OpenTofu |

## AI

| Tool | Purpose |
|------|---------|
| [[Tools/Copilot-Neovim]] | Inline completions + chat |
| [[Tools/MCP-Servers]] | Claude Code MCP skills |
| [[Tools/Local-AI]] | Ollama + codecompanion |

## Desktop / WM

| Tool | Purpose |
|------|---------|
| [[Tools/Hyprland]] | Wayland compositor |

## Development

| Tool | Purpose |
|------|---------|
| [[Tools/WordPress-Dev]] | Local WP stack |
| [[Tools/KVM-QEMU]] | Full VMs |
| [[Tools/Multipass]] | Quick Ubuntu VMs |
| [[Tools/JS-Dev]] | pnpm, bun, mise, LazyVim TS |
| [[Tools/just]] | Task runner |
| [[Tools/lazysql]] | Terminal SQL TUI |
| [[Tools/mise]] | Polyglot version manager |

## CLI Utilities

| Tool | Purpose |
|------|---------|
| [[Tools/Tealdeer]] | Fast tldr pages |
| [[Tools/xh]] | Modern HTTP client |
| [[Tools/navi]] | Interactive cheatsheets (Ctrl+G) |
| [[Tools/Antidote]] | Zsh plugin manager |
| [[Tools/act]] | Run GitHub Actions locally |
| [[Tools/ctop]] | Container resource monitor |
| [[Tools/cava]] | Terminal audio visualiser |

## Setup

- [[Setup/Getting Started]]
- [[Setup/Stow Structure]]

## Issues & Fixes

- [[Issues/Ghostty-Remote-TERM]] ⚠️ htop on remote servers
- [[Fixes/KDE-Monitor-Brightness]] — KDE overriding external monitor brightness

## Theme

Everything uses **Catppuccin Mocha** — Ghostty, tmux, Neovim, Yazi, Zellij, Hyprland, waybar, wofi, hyprlock.

