#!/bin/bash

echo "Installing dotfiles..."

# ── JetBrains Toolbox directories ────────────────────────────────────────
mkdir -p ~/.local/share/JetBrains/Toolbox/apps
mkdir -p ~/.local/share/JetBrains/Toolbox/scripts

# ── Antidote (zsh plugin manager) ────────────────────────────────────────
if [ ! -d "${ZDOTDIR:-~}/.antidote" ]; then
  echo "==> Installing Antidote..."
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
# $(ls src/) expands to every package directory — no need to list them manually.
# Dry run first: stow -nv --dotfiles -d src -t ~ $(ls src/)
stow --dotfiles -d src -t ~ $(ls src/)

echo ""
echo "✓ Done. Open tmux and press prefix+I to install plugins."
echo "  Open nvim — lazy.nvim will auto-install on first launch."
echo ""
echo "  Next: run bin/setup-mcp.sh to configure Claude Code MCP servers."
echo "  (Set GITHUB_TOKEN and BRAVE_API_KEY first for full coverage)"
