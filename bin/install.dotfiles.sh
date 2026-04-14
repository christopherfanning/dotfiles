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

# Back up real files AND directories that stow would conflict with or fold into.
# Stow folds into existing real directories (creating file-level symlinks) rather
# than replacing them with a directory symlink — we want the latter for clean installs.
# A directory is "package-owned" (should be a symlink) when no other package shares
# the same relative path. Shared dirs like dot-config/ are skipped.
echo "  Checking for conflicts..."
for pkg in $(ls src/); do
  while IFS= read -r srcpath; do
    relpath="${srcpath#src/$pkg/}"
    # Convert dot- prefix at each path component boundary (stow --dotfiles convention)
    target_rel=$(echo "$relpath" | sed 's|/dot-|/.|g; s|^dot-|.|')
    target="$HOME/$target_rel"

    [[ -L "$target" ]] && continue  # already a symlink, stow owns it

    if [[ -f "$target" ]]; then
      echo "    $target → ${target}.bak"
      mv "$target" "${target}.bak"
    elif [[ -d "$target" ]]; then
      # Only back up if this package solely owns this directory
      # (shared dirs like ~/.config/ are used by many packages — stow folds into them intentionally)
      is_shared=false
      for other in $(ls src/); do
        [[ "$other" == "$pkg" ]] && continue
        [[ -d "src/$other/$relpath" ]] && is_shared=true && break
      done
      if [[ "$is_shared" == "false" ]]; then
        echo "    $target/ → ${target}.bak/"
        mv "$target" "${target}.bak"
      fi
    fi
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
