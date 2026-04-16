#!/bin/bash
# macOS — full development environment setup via Homebrew
# Run this on a fresh Mac before symlinking dotfiles.
#
# Usage: bash bin/mac-install.sh
#
# What it skips vs Arch:
#   - Hyprland/Wayland (Linux-only compositor)
#   - KVM/QEMU/libvirt  (use UTM or Multipass on Mac)
#   - pipewire/wireplumber (Core Audio handles this)
#   - KDE/powerdevil brightness fix (not applicable)
#   - xclip/wl-clipboard → pbcopy/pbpaste are native on macOS

set -e

# ── Homebrew ──────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add brew to PATH for Apple Silicon Macs
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

echo "==> Updating Homebrew..."
brew update

# ── Base tools ────────────────────────────────────────────────────────────
echo "==> Installing base tools..."
brew install git curl wget stow

# ── Shell & multiplexer ───────────────────────────────────────────────────
echo "==> Installing shell & multiplexer..."
brew install zsh tmux zellij

# ── Terminal emulator ─────────────────────────────────────────────────────
echo "==> Installing Ghostty..."
brew install --cask ghostty

# ── Editor ────────────────────────────────────────────────────────────────
echo "==> Installing Neovim..."
brew install neovim

# ── Modern CLI tools ──────────────────────────────────────────────────────
# eza=ls  bat=cat  rg=grep  fd=find  fzf=fuzzy  zoxide=cd  delta=git-diff
# dust=du  duf=df  btm=htop  tldr=tealdeer  glow=markdown  direnv=envrc
# xh=curl  procs=ps  just=make
echo "==> Installing modern CLI tools..."
brew install \
  eza \
  bat \
  ripgrep \
  fd \
  fzf \
  zoxide \
  git-delta \
  dust \
  duf \
  bottom \
  tealdeer \
  glow \
  direnv \
  jq \
  xh \
  procs \
  just \
  fastfetch \
  atuin \
  bandwhich \
  navi \
  cava

# ── Yazi & preview dependencies ───────────────────────────────────────────
echo "==> Installing Yazi (file manager)..."
brew install \
  yazi \
  ffmpeg \
  sevenzip \
  poppler \
  resvg \
  imagemagick

# ── Git & GitHub tooling ──────────────────────────────────────────────────
echo "==> Installing git tools..."
brew install \
  lazygit \
  gh

# worktrunk — not yet in homebrew core; install via cargo if available
if command -v cargo &>/dev/null; then
  echo "==> Installing worktrunk via cargo..."
  cargo install worktrunk
elif brew list worktrunk &>/dev/null 2>&1; then
  brew install worktrunk
else
  echo "  SKIP: worktrunk not available. Install Rust first: mise use --global rust@latest"
  echo "        Then: cargo install worktrunk"
fi

if command -v wt &>/dev/null; then
  wt config shell install
fi

# ── Docker ────────────────────────────────────────────────────────────────
echo "==> Installing Docker..."
brew install --cask docker
echo "  NOTE: Launch Docker.app once to complete installation."

# ── Virtualization ────────────────────────────────────────────────────────
echo "==> Installing virtualization tools..."
# UTM: full VM manager (QEMU-backed), free, native Apple Silicon support
brew install --cask utm
# Multipass: quick disposable Ubuntu cloud VMs (mirrors Lightsail environment)
brew install --cask multipass

# ── AWS tooling ───────────────────────────────────────────────────────────
echo "==> Installing AWS tooling..."
brew install \
  awscli \
  hashicorp/tap/packer \
  opentofu \
  aws-vault
# OpenTofu is a drop-in replacement for Terraform. Binary: 'tofu'. Same HCL syntax.

# ── WordPress tooling ─────────────────────────────────────────────────────
echo "==> Installing WordPress tooling..."
brew install wp-cli

# ── TUI tools ─────────────────────────────────────────────────────────────
echo "==> Installing TUI tools..."
brew install \
  lazydocker \
  dive \
  ctop \
  act \
  mise

# lazysql — not in homebrew core; install via go if available
if command -v go &>/dev/null; then
  go install github.com/jorgerojas26/lazysql@latest
else
  echo "  SKIP: lazysql requires Go. Install via mise: mise use --global go@latest"
fi

# ── System utilities ──────────────────────────────────────────────────────
echo "==> Installing system utilities..."
brew install \
  htop \
  btop \
  openssh \
  rsync \
  zip \
  unzip \
  gnupg

# ── pnpm ──────────────────────────────────────────────────────────────────
echo "==> Installing pnpm..."
brew install pnpm

# ── Fonts ─────────────────────────────────────────────────────────────────
echo "==> Installing fonts..."
brew install --cask \
  font-meslo-lg-nerd-font \
  font-noto-sans \
  font-noto-color-emoji

# ── GUI apps ──────────────────────────────────────────────────────────────
echo "==> Installing GUI apps..."
brew install --cask \
  obsidian \
  mpv \
  blender \
  gimp \
  inkscape \
  audacity \
  jetbrains-toolbox \
  google-chrome \
  dbeaver-community

# flameshot works on macOS but is less useful there; skipping in favour of native ⌘⇧4
# Use Cmd+Shift+4 / Cmd+Shift+5 for screenshots

# ── Zsh plugin manager ────────────────────────────────────────────────────
echo "==> Installing antidote (zsh plugin manager)..."
brew install antidote

# ── macOS-specific: set zsh as default shell ─────────────────────────────
BREW_ZSH="$(brew --prefix)/bin/zsh"
if [[ "$SHELL" != "$BREW_ZSH" ]]; then
  echo "==> Setting Homebrew zsh as default shell..."
  if ! grep -qF "$BREW_ZSH" /etc/shells; then
    echo "$BREW_ZSH" | sudo tee -a /etc/shells
  fi
  chsh -s "$BREW_ZSH"
  echo "  Shell changed to $BREW_ZSH — restart your terminal."
fi

# ── macOS-specific: Rosetta 2 (Apple Silicon only) ───────────────────────
if [[ "$(uname -m)" == "arm64" ]]; then
  if ! /usr/bin/pgrep -q oahd; then
    echo "==> Installing Rosetta 2 (required for some x86 binaries)..."
    softwareupdate --install-rosetta --agree-to-license
  fi
fi

echo ""
echo "✓ All packages installed."
echo ""
echo "  Next steps:"
echo "  1. Launch Docker.app to complete Docker installation"
echo "  2. Open Ghostty and set font to 'MesloLGS Nerd Font' in settings"
echo "  3. Run bin/install.dotfiles.sh to symlink configs"
echo "  4. For bun (JS runtime):  mise use --global bun@latest"
echo "  5. For Rust + worktrunk:  mise use --global rust@latest && cargo install worktrunk"
echo "  6. For lazysql:           mise use --global go@latest && go install github.com/jorgerojas26/lazysql@latest"
echo ""
echo "  macOS note: antidote installs to \$(brew --prefix)/opt/antidote/share/antidote/antidote.zsh"
echo "  The zshrc sources it from that path — no extra config needed."
