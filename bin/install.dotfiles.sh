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

# Before stowing, back up any real (non-symlink) files that would conflict.
#
# SAFETY RULES — what we NEVER touch:
#   1. Symlinks — stow already owns them; touching them would break the config.
#   2. Anything whose real path resolves inside DOTFILES_DIR — these are already
#      stow-managed paths (e.g. ~/.config/nvim -> dotfiles/src/nvim/dot-config/nvim).
#      Renaming a file inside that dir would destroy the repo source.
#
# We only back up REAL files/dirs that are NOT already under stow management
# and that stow would refuse to overwrite.

_is_under_dotfiles() {
  # Returns 0 (true) if the resolved real path of $1 is inside DOTFILES_DIR.
  local target="$1"
  local real
  real=$(realpath "$target" 2>/dev/null) || return 1
  [[ "$real" == "$DOTFILES_DIR"* ]]
}

echo "  Checking for conflicts..."
for pkg in $(ls src/); do
  while IFS= read -r srcpath; do
    # Only look at leaf files — stow handles directory creation itself
    [[ -f "$srcpath" ]] || continue

    relpath="${srcpath#src/$pkg/}"
    # Convert dot- prefix convention to real dotfile names
    target_rel=$(echo "$relpath" | sed 's|/dot-|/.|g; s|^dot-|.|')
    target="$HOME/$target_rel"

    # Skip if target doesn't exist — nothing to back up
    [[ -e "$target" || -L "$target" ]] || continue

    # Skip if already a symlink — stow owns it, leave it alone
    [[ -L "$target" ]] && continue

    # Skip if it resolves into the dotfiles repo — we'd be clobbering our own source
    if _is_under_dotfiles "$target"; then
      echo "  SKIP (already stow-managed via parent symlink): $target"
      continue
    fi

    # Safe to back up — it's a real file/dir that stow doesn't own yet
    echo "  Backing up: $target → ${target}.bak"
    mv "$target" "${target}.bak"

  done < <(find "src/$pkg" -mindepth 1)
done

stow --dotfiles -d src -t ~ $(ls src/)
echo "  Stow complete."

# ── Atuin history bootstrap ───────────────────────────────────────────────
# Import existing shell history into atuin on first install.
# Safe to run multiple times — atuin deduplicates on import.
if command -v atuin &>/dev/null; then
  echo "==> Importing shell history into atuin..."
  mkdir -p "$HOME/.local/share/zsh"
  # Import zsh history (uses HISTFILE env or detects ~/.local/share/zsh/history)
  HISTFILE="$HOME/.local/share/zsh/history" atuin import zsh 2>/dev/null || true
  # Also pull in bash history if present
  [[ -f "$HOME/.bash_history" ]] && atuin import bash 2>/dev/null || true
  echo "  History imported. Ctrl+R in a new shell to search via atuin."
fi

echo ""
echo "✓ Done. Open tmux and press prefix+I to install plugins."
echo "  Open nvim — lazy.nvim will auto-install on first launch."
echo ""
echo "  Next: run bin/setup-mcp.sh to configure Claude Code MCP servers."
echo "  (Set GITHUB_TOKEN and BRAVE_API_KEY first for full coverage)"
