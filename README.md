<div align="center">

# 🐱 cfan dotfiles

**A batteries-included Arch Linux developer workstation**

*Hyprland · Neovim (LazyVim) · Ghostty · tmux · Catppuccin Mocha · managed with GNU Stow*

---

[![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)](https://archlinux.org)
[![Neovim](https://img.shields.io/badge/Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white)](https://neovim.io)
[![Hyprland](https://img.shields.io/badge/Hyprland-58E1AF?style=for-the-badge&logoColor=1e1e2e)](https://hyprland.org)
[![Ghostty](https://img.shields.io/badge/Ghostty-1e1e2e?style=for-the-badge&logoColor=cdd6f4)](https://ghostty.org)
[![tmux](https://img.shields.io/badge/tmux-1BB91F?style=for-the-badge&logo=tmux&logoColor=white)](https://github.com/tmux/tmux)
[![Zsh](https://img.shields.io/badge/Zsh-F15A24?style=for-the-badge&logoColor=white)](https://www.zsh.org)
[![Catppuccin](https://img.shields.io/badge/Catppuccin_Mocha-cba6f7?style=for-the-badge&logoColor=1e1e2e)](https://catppuccin.com)
[![GNU Stow](https://img.shields.io/badge/GNU_Stow-A22846?style=for-the-badge&logo=gnu&logoColor=white)](https://www.gnu.org/software/stow)

</div>

---

## 📸 Preview

> 💡 **Add screenshots here.** Capture your desktop, Neovim, tmux, and terminal with `grim -g "$(slurp)"` (Hyprland) or Flameshot, then drop the images into `assets/screenshots/` and update the paths below.

| Desktop (Hyprland) | Editor (Neovim + LazyVim) |
|---|---|
| *screenshot pending* | *screenshot pending* |

| Terminal (Ghostty + tmux) | File Manager (Yazi) |
|---|---|
| *screenshot pending* | *screenshot pending* |

---

## 🛠 Tools

### Shell

| Tool | Purpose |
|------|---------|
| [Zsh](https://www.zsh.org) | Shell |
| [Antidote](https://getantidote.github.io) | Plugin manager — loads from `/usr/share/zsh-antidote` (Arch pkg) or `~/.antidote` (git) |
| [Powerlevel10k](https://github.com/romkatv/powerlevel10k) | Fast, customizable prompt |
| [Pure](https://github.com/sindresorhus/pure) | Minimal async prompt (alternative) |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Fish-like inline suggestions |
| [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) | Command syntax highlighting |
| [fzf-tab](https://github.com/Aloxaf/fzf-tab) | Replace tab completion UI with fzf |
| [zsh-vi-mode](https://github.com/jeffreytse/zsh-vi-mode) | Vim keybindings in the shell |
| [zsh-fzf-history-search](https://github.com/joshskidmore/zsh-fzf-history-search) | fzf-powered Ctrl+R (overridden by atuin when installed) |

### Terminal & Multiplexer

| Tool | Purpose |
|------|---------|
| [Ghostty](https://ghostty.org) | Primary terminal emulator — GPU-accelerated, native Wayland |
| [tmux](https://github.com/tmux/tmux) | Terminal multiplexer — sessions, windows, panes |
| [Zellij](https://zellij.dev) | Terminal workspace — floating panes, built-in layouts (alternative to tmux) |

### Editor

| Tool | Purpose |
|------|---------|
| [Neovim](https://neovim.io) | Editor — configured via [LazyVim](https://lazyvim.github.io) |
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager (auto-installs on first launch) |
| [Catppuccin for Neovim](https://github.com/catppuccin/nvim) | Colorscheme |
| [CodeCompanion](https://github.com/olimorris/codecompanion.nvim) | AI assistant in Neovim (Ollama + Claude via MCP) |
| [GitHub Copilot](https://github.com/github/copilot.vim) | Inline AI completions |

### Desktop / WM

| Tool | Purpose |
|------|---------|
| [Hyprland](https://hyprland.org) | Wayland compositor — dynamic tiling WM |
| [Waybar](https://github.com/Alexays/Waybar) | Status bar |
| [Wofi](https://hg.sr.ht/~scoopta/wofi) | App launcher |
| [Hyprpaper](https://github.com/hyprwm/hyprpaper) | Wallpaper daemon |
| [Hypridle](https://github.com/hyprwm/hypridle) | Idle daemon |
| [Hyprlock](https://github.com/hyprwm/hyprlock) | Screen locker |
| [Dunst](https://dunst-project.org) | Notification daemon |

### File Management & Navigation

| Tool | Purpose |
|------|---------|
| [Yazi](https://yazi-rs.github.io) | Terminal file manager — image preview, previews via ffmpeg/poppler |
| [Zoxide](https://github.com/ajeetdsouza/zoxide) | Smarter `cd` — tracks frecency |
| [eza](https://github.com/eza-community/eza) | Modern `ls` — icons, git status |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder |
| [fd](https://github.com/sharkdp/fd) | Modern `find` |

### History & Search

| Tool | Purpose |
|------|---------|
| [atuin](https://atuin.sh) | Shell history — fuzzy search with sync (replaces Ctrl+R) |

### Git & DevOps

| Tool | Purpose |
|------|---------|
| [Lazygit](https://github.com/jesseduffield/lazygit) | Git TUI |
| [Lazydocker](https://github.com/jesseduffield/lazydocker) | Docker TUI |
| [Worktrunk](https://github.com/nickvdyck/worktrunk) | Git worktree manager — `wt switch <branch>` |
| [GitHub CLI](https://cli.github.com) | PRs, issues, CI from the terminal |
| [git-delta](https://github.com/dandavison/delta) | Better git diff output |
| [Docker](https://www.docker.com) | Containers + Compose |
| [aws-cli v2](https://aws.amazon.com/cli) + [aws-vault](https://github.com/99designs/aws-vault) | AWS access management |
| [OpenTofu](https://opentofu.org) | Infrastructure as code (Terraform drop-in) |
| [Packer](https://developer.hashicorp.com/packer) | Machine image builder |

### AI

| Tool | Purpose |
|------|---------|
| [GitHub Copilot](https://github.com/features/copilot) | Inline completions + chat (Neovim) |
| [Ollama](https://ollama.com) | Local LLM server (`localhost:11434`) |
| [Claude Code](https://claude.ai/code) + MCP servers | Agentic coding assistant — configured via `bin/setup-mcp.sh` |

### CLI Utilities

| Tool | Purpose |
|------|---------|
| [bat](https://github.com/sharkdp/bat) | `cat` with syntax highlighting and git integration |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Blazing-fast `grep` |
| [dust](https://github.com/bootandy/dust) | Intuitive `du` |
| [duf](https://github.com/muesli/duf) | Better `df` |
| [bottom](https://github.com/ClementTsang/bottom) | System monitor (`btm`) |
| [fastfetch](https://github.com/fastfetch-cli/fastfetch) | System info display |
| [bandwhich](https://github.com/imsnif/bandwhich) | Network utilization monitor |
| [xh](https://github.com/ducaale/xh) | Friendly HTTP client (HTTPie-like) |
| [procs](https://github.com/dalance/procs) | Modern `ps` |
| [just](https://github.com/casey/just) | Command runner (`make` alternative) |
| [navi](https://github.com/denisidoro/navi) | Interactive cheatsheets (Ctrl+G) |
| [tealdeer](https://github.com/dbrgn/tealdeer) | Fast `tldr` pages |
| [glow](https://github.com/charmbracelet/glow) | Markdown renderer in terminal |
| [direnv](https://direnv.net) | Per-directory env vars (auto-load `.envrc`) |
| [jq](https://stedolan.github.io/jq) | JSON processor |
| [cava](https://github.com/karlstav/cava) | Terminal audio visualizer |
| [atuin](https://atuin.sh) | Shell history sync and search |
| [mise](https://mise.jdx.dev) | Polyglot runtime version manager (node, bun, python, …) |
| [lazysql](https://github.com/jorgerojas26/lazysql) | Terminal SQL TUI |
| [act](https://github.com/nektos/act) | Run GitHub Actions locally |
| [ctop](https://github.com/bcicen/ctop) | Container resource monitor |

---

## 🚀 Quick Start

> Assumes a fresh Arch Linux install with internet access.

**Step 1 — Install all packages** (pacman + yay AUR)

```bash
bash bin/arch-install.sh
```

**Step 2 — Stow dotfiles** (symlinks configs, installs Antidote/TPM/NVM)

```bash
bash bin/install.dotfiles.sh
```

After this completes:
- Open tmux → press `prefix + I` to install TPM plugins
- Open Neovim → `lazy.nvim` auto-installs all plugins on first launch

**Step 3 — Configure AI tools** *(optional)*

```bash
export GITHUB_TOKEN=ghp_...
export BRAVE_API_KEY=...
bash bin/setup-mcp.sh
```

---

## 📁 Repository Structure

```
dotfiles/
├── bin/                        # Bootstrap scripts
│   ├── arch-install.sh         # Installs all pacman + AUR packages
│   ├── install.dotfiles.sh     # Stows all configs, installs Antidote/TPM/NVM
│   ├── setup-mcp.sh            # Configures Claude Code MCP servers
│   └── setup-local-ai.sh       # Pulls Ollama models
│
├── src/                        # Stow packages (one directory per tool)
│   ├── atuin/                  # Shell history config
│   ├── fonts/                  # Font directory
│   ├── ghostty/                # Terminal emulator config
│   ├── hyprland/               # Wayland compositor + hyprpaper/idle/lock
│   ├── ideavim/                # JetBrains IDE vim config
│   ├── kitty/                  # Kitty terminal (legacy)
│   ├── nvim/                   # Neovim (LazyVim)
│   ├── shell/                  # Shared aliases (sourced by .zshrc)
│   ├── tmux/                   # tmux config + Catppuccin theme
│   ├── waybar/                 # Wayland status bar
│   ├── wofi/                   # App launcher
│   ├── worktrunk/              # Git worktree manager config
│   ├── yazi/                   # File manager
│   ├── zellij/                 # Terminal workspace (tmux alternative)
│   └── zsh/                   # .zshrc, .zshenv, .zsh_plugins.txt
│
└── obsidian/dotfiles-vault/    # Obsidian docs for every tool
```

---

## 🔧 Stow Structure

Configs use the **`dot-` prefix** convention so the repo doesn't need hidden files at its root:

| Repo path | Symlinked to |
|-----------|-------------|
| `src/zsh/dot-zshrc` | `~/.zshrc` |
| `src/nvim/dot-config/nvim/init.lua` | `~/.config/nvim/init.lua` |
| `src/ghostty/dot-config/ghostty/config` | `~/.config/ghostty/config` |
| `src/hyprland/dot-config/hypr/hyprland.conf` | `~/.config/hypr/hyprland.conf` |

Stow commands always run from the repo root:

```bash
# Dry run (always do this first)
stow -nv --dotfiles -d src -t ~ $(ls src/)

# Apply all packages
stow --dotfiles -d src -t ~ $(ls src/)

# Single package
stow --dotfiles -d src -t ~ zsh

# Remove a package's symlinks
stow -D --dotfiles -d src -t ~ zsh
```

---

## 🌐 GitHub Repo Metadata

To set the repository description and topics (requires `gh auth login`):

```bash
gh repo edit \
  --description "Arch Linux dotfiles — Hyprland · Neovim (LazyVim) · Ghostty · tmux · Catppuccin Mocha · managed with GNU Stow" \
  --add-topic dotfiles \
  --add-topic arch-linux \
  --add-topic neovim \
  --add-topic lazyvim \
  --add-topic hyprland \
  --add-topic ghostty \
  --add-topic tmux \
  --add-topic catppuccin \
  --add-topic zsh \
  --add-topic stow \
  --add-topic wayland \
  --add-topic catppuccin-mocha
```

To add a social preview image, upload `assets/social-preview.svg` (included in this repo) at:
**GitHub → Settings → Social preview → Edit → Upload image**

---

## 🎨 Theme

Everything uses **[Catppuccin Mocha](https://catppuccin.com)** — Ghostty, tmux, Neovim, Yazi, Zellij, Hyprland, Waybar, Wofi, Hyprlock, and Lazygit all share the same palette.
