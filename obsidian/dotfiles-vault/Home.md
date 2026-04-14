# Dotfiles Vault

> Documentation for the `~/dotfiles` repo — why each tool was chosen, how it's configured, and known issues.

> 📋 **[[Keybinds]]** — full cross-tool keybind reference (tmux · Neovim · zsh · Hyprland · Yazi · Lazygit · atuin)

## Core Tools

| Tool | Purpose |
|------|---------|
| [[Tools/Ghostty]] | Terminal emulator |
| [[Tools/tmux]] | Terminal multiplexer |
| [[Tools/Neovim-LazyVim]] | Editor (LazyVim + Catppuccin) |
| [[Tools/Yazi]] | File manager |
| [[Tools/Lazygit]] | Git TUI |
| [[Tools/Lazydocker]] | Docker TUI |
| [[Tools/Eza]] | Modern `ls` |
| [[Tools/Zoxide]] | Smarter `cd` |
| [[Tools/FZF]] | Fuzzy finder |
| [[Tools/Antidote]] | Zsh plugin manager |
| [[Tools/atuin]] | Shell history sync (replaces Ctrl+R) |

## Desktop / WM

| Tool | Purpose |
|------|---------|
| [[Tools/Hyprland]] | Wayland compositor (vim keybinds, catppuccin) |

## AI

| Tool | Purpose |
|------|---------|
| [[Tools/Copilot-Neovim]] | Inline completions + chat in Neovim |
| [[Tools/MCP-Servers]] | Claude Code skills (filesystem, git, github, docker…) |
| [[Tools/Local-AI]] | Ollama local inference + codecompanion.nvim + mcphub.nvim |

## Development

| Tool | Purpose |
|------|---------|
| [[Tools/Docker]] | Containers + lazydocker + ctop + dive |
| [[Tools/WordPress-Dev]] | Local WP stack, wp-cli, docker-compose |
| [[Tools/AWS-Workflow]] | Packer AMIs, OpenTofu infra, aws-cli, aws-vault |
| [[Tools/KVM-QEMU]] | Full VM management (virt-manager) |
| [[Tools/Multipass]] | Quick Ubuntu cloud VMs (mirrors Lightsail) |
| [[Tools/JS-Dev]] | pnpm, bun, mise, LazyVim TS |
| [[Tools/GitHub-CLI]] | gh — PRs, issues, CI from the terminal |
| [[Tools/just]] | Task runner (modern Makefile replacement) |
| [[Tools/Worktrunk]] | Git worktree manager — parallel AI agents |
| [[Tools/lazysql]] | Terminal SQL TUI (MySQL/MariaDB/Postgres) |
| [[Tools/mise]] | Polyglot version manager (replaces nvm/sdkman) |

## CLI Utilities

| Tool | Purpose |
|------|---------|
| [[Tools/Tealdeer]] | Fast tldr pages (`help <command>`) |
| [[Tools/xh]] | Modern HTTP client (`http GET url`) |
| [[Tools/navi]] | Interactive cheatsheet browser (Ctrl+G) |
| [[Tools/act]] | Run GitHub Actions locally |
| [[Tools/ctop]] | Container resource monitor |
| [[Tools/cava]] | Terminal audio visualiser |

## Setup

- [[Setup/Getting Started]]
- [[Setup/Stow Structure]]

## Issues & Notes

- [[Issues/Ghostty-Remote-TERM]] ⚠️ htop on remote servers

## Fixes

- [[Fixes/KDE-Monitor-Brightness]] — KDE/powerdevil overriding external monitor brightness via DDC/CI

## Theme

Everything uses **Catppuccin Mocha** — Ghostty, tmux, Neovim, Yazi, Hyprland, waybar, wofi, hyprlock.

