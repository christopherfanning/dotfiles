#!/bin/bash

# Always run from the dotfiles repo root regardless of where the script is called from
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$DOTFILES_DIR"

echo "Installing dotfiles from: $DOTFILES_DIR"

# ── JetBrains Toolbox directories ────────────────────────────────────────
mkdir -p ~/.local/share/JetBrains/Toolbox/apps
mkdir -p ~/.local/share/JetBrains/Toolbox/scripts

# ── Antidote (zsh plugin manager) ────────────────────────────────────────
# Skip git clone if installed via yay -S zsh-antidote (system package)
if [[ ! -f /usr/share/zsh-antidote/antidote.zsh && ! -d "${ZDOTDIR:-~}/.antidote" ]]; then
  echo "==> Installing Antidote (git clone)..."
  git clone --depth=1 https://github.com/mattmc3/antidote.git "${ZDOTDIR:-~}/.antidote"
fi

# ── TPM (tmux plugin manager) ─────────────────────────────────────────────
if [ ! -d ~/.tmux/plugins/tpm ]; then
  echo "==> Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# ── NVM ───────────────────────────────────────────────────────────────────
if [ ! -d "$HOME/.nvm" ]; then
  echo "==> Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  echo "  Run: nvm install --lts"
fi

# ── Reload fonts ──────────────────────────────────────────────────────────
fc-cache -f -v

# ── Default shell → zsh ───────────────────────────────────────────────────
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "==> Changing default shell to zsh..."
  sudo chsh --shell "$(which zsh)" "$USER"
fi

# ── Git globals ───────────────────────────────────────────────────────────
git config --global core.editor "nvim"
git config --global color.ui auto

# ── Stow all packages ─────────────────────────────────────────────────────
echo "==> Stowing dotfiles..."
# Dry run first to detect conflicts
CONFLICTS=$(stow -nv --dotfiles -d src -t ~ $(ls src/) 2>&1 | grep "cannot stow" | grep -oP '(?<=target )\S+')

if [[ -n "$CONFLICTS" ]]; then
  echo "  Backing up conflicting files..."
  for f in $CONFLICTS; do
    target="$HOME/$f"
    if [[ -f "$target" && ! -L "$target" ]]; then
      echo "    $target → ${target}.bak"
      mv "$target" "${target}.bak"
    fi
  done
fi

stow --dotfiles -d src -t ~ $(ls src/)
echo "  Stow complete."

echo ""
echo "✓ Done. Open tmux and press prefix+I to install plugins."
echo "  Open nvim — lazy.nvim will auto-install on first launch."
echo ""
echo "  Next: run bin/setup-mcp.sh to configure Claude Code MCP servers."
echo "  (Set GITHUB_TOKEN and BRAVE_API_KEY first for full coverage)"
