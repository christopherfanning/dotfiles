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
# xh=curl  procs=ps  just=make
echo "==> Installing modern CLI tools..."

# tealdeer conflicts with the 'tldr' package — remove it if present
if pacman -Qi tldr &>/dev/null; then
  echo "  Removing conflicting 'tldr' package..."
  sudo pacman -Rs --noconfirm tldr
fi

sudo pacman -S --noconfirm --needed \
  eza \
  bat \
  pnpm \
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
  neofetch \
  atuin \
  bandwhich \
  navi \
  cava

# ── Yazi & preview dependencies (per yazi-rs.github.io/docs/installation) ─
echo "==> Installing Yazi (file manager)..."
sudo pacman -S --noconfirm --needed \
  yazi \
  ffmpeg \
  7zip \
  poppler \
  resvg \
  imagemagick

# ── Git & GitHub tooling ──────────────────────────────────────────────────
echo "==> Installing git tools..."
sudo pacman -S --noconfirm --needed \
  lazygit \
  gh

# ── Hyprland (Wayland compositor) ────────────────────────────────────────
echo "==> Installing Hyprland + Wayland ecosystem..."
sudo pacman -S --noconfirm --needed \
  hyprland \
  hyprpaper \
  hypridle \
  hyprlock \
  waybar \
  wofi \
  dunst \
  grim \
  slurp \
  cliphist \
  brightnessctl \
  playerctl \
  pipewire \
  wireplumber \
  pavucontrol \
  xdg-desktop-portal-hyprland \
  qt5-wayland \
  qt6-wayland

# ── Virtualization (KVM/QEMU/libvirt) ────────────────────────────────────
echo "==> Installing virtualization stack..."
sudo pacman -S --noconfirm --needed \
  qemu-full \
  libvirt \
  virt-manager \
  dnsmasq \
  bridge-utils \
  iptables-nft

sudo systemctl enable --now libvirtd
sudo usermod -aG libvirt "$USER"
sudo usermod -aG kvm "$USER"
echo "  NOTE: Log out and back in for libvirt/kvm group membership to take effect."

# Multipass — quick disposable Ubuntu cloud VMs (mirrors Lightsail environment)
yay -S --noconfirm --needed multipass

# ── Docker ────────────────────────────────────────────────────────────────
echo "==> Installing Docker..."
sudo pacman -S --noconfirm --needed docker docker-compose
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"
echo "  NOTE: Log out and back in for docker group to take effect."

# ── AWS tooling ───────────────────────────────────────────────────────────
echo "==> Installing AWS tooling..."
yay -S --noconfirm --needed \
  aws-cli-v2 \
  packer-io \
  opentofu \
  aws-vault
# NOTE: 'packer-io' is the correct AUR package. 'packer' is a conflicting deprecated AUR helper.
# OpenTofu is a drop-in replacement for Terraform. Binary: 'tofu'. Same HCL syntax.

# ── WordPress tooling ─────────────────────────────────────────────────────
echo "==> Installing WordPress tooling..."
yay -S --noconfirm --needed wp-cli

# ── Lazy* TUI tools + AUR extras ─────────────────────────────────────────
echo "==> Installing TUI tools and AUR extras..."
yay -S --noconfirm --needed \
  lazydocker \
  dive \
  ctop \
  lazysql \
  act \
  mise

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
  flameshot \
  mpv \
  blender \
  gimp \
  inkscape \
  audacity \
  dbeaver

yay -S --noconfirm --needed \
  jetbrains-toolbox \
  google-chrome

# ── Zsh plugin manager ────────────────────────────────────────────────────
echo "==> Installing zsh-antidote..."
yay -S --noconfirm --needed zsh-antidote

echo ""
echo "✓ All packages installed."
echo "  IMPORTANT: Log out and back in so docker, libvirt, and kvm group membership takes effect."
echo "  For bun (JS runtime): mise use --global bun@latest"
echo "  Next: run bin/install.dotfiles.sh to symlink configs."
