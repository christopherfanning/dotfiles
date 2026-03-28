#!/bin/bash
# Arch Linux — full development environment setup
# Run this on a fresh Arch install before symlinking dotfiles.

set -e

echo "==> Updating system..."
sudo pacman -Syu --noconfirm

echo "==> Installing base build tools..."
sudo pacman -S --noconfirm --needed base-devel git curl wget

# ── Yay (AUR helper) ──────────────────────────────────────────────────────
if ! command -v yay &>/dev/null; then
  echo "==> Installing yay..."
  git clone https://aur.archlinux.org/yay.git /tmp/yay-install
  (cd /tmp/yay-install && makepkg -si --noconfirm)
  rm -rf /tmp/yay-install
fi

# ── Shell & multiplexer ───────────────────────────────────────────────────
echo "==> Installing shell & multiplexer..."
sudo pacman -S --noconfirm --needed zsh stow tmux

# ── Terminal emulator ─────────────────────────────────────────────────────
echo "==> Installing Ghostty..."
sudo pacman -S --noconfirm --needed ghostty

# ── Editor ────────────────────────────────────────────────────────────────
echo "==> Installing Neovim..."
sudo pacman -S --noconfirm --needed neovim

# ── Modern CLI tools ──────────────────────────────────────────────────────
# eza=ls  bat=cat  rg=grep  fd=find  fzf=fuzzy  zoxide=cd  delta=git-diff
# dust=du  duf=df  btm=htop  tealdeer=tldr  glow=markdown  direnv=envrc
echo "==> Installing modern CLI tools..."

# tealdeer conflicts with the 'tldr' package — remove it if present
if pacman -Qi tldr &>/dev/null; then
  echo "  Removing conflicting 'tldr' package..."
  sudo pacman -Rs --noconfirm tldr
fi

sudo pacman -S --noconfirm --needed \
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
  jq

# ── Yazi & its preview dependencies ──────────────────────────────────────
echo "==> Installing Yazi (file manager)..."
sudo pacman -S --noconfirm --needed \
  yazi \
  ffmpegthumbnailer \
  unar \
  imagemagick \
  poppler

# ── Lazy* TUI tools ───────────────────────────────────────────────────────
echo "==> Installing lazygit & lazydocker..."
sudo pacman -S --noconfirm --needed lazygit
yay -S --noconfirm --needed lazydocker

# ── System utilities ──────────────────────────────────────────────────────
echo "==> Installing system tools..."
sudo pacman -S --noconfirm --needed \
  htop \
  btop \
  gnome-disk-utility \
  wl-clipboard \
  xclip \
  man-db \
  man-pages \
  openssh \
  rsync \
  zip \
  unzip

# ── Fonts ─────────────────────────────────────────────────────────────────
echo "==> Installing fonts..."
sudo pacman -S --noconfirm --needed \
  ttf-meslo-nerd \
  noto-fonts \
  noto-fonts-emoji

# ── GUI apps ──────────────────────────────────────────────────────────────
echo "==> Installing GUI apps..."
sudo pacman -S --noconfirm --needed \
  obsidian \
  blender \
  gimp \
  inkscape \
  audacity

yay -S --noconfirm --needed \
  jetbrains-toolbox \
  google-chrome

# ── Zsh plugin manager ────────────────────────────────────────────────────
echo "==> Installing zsh-antidote..."
yay -S --noconfirm --needed zsh-antidote

echo ""
echo "✓ All packages installed."
echo "  Next: run bin/install.dotfiles.sh to symlink configs."
