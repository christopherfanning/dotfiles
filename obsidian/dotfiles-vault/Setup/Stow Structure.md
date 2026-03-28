# Stow Structure

> How GNU Stow manages the dotfiles symlinks.

## The `dot-` Convention

Stow can't create hidden files (starting with `.`) directly. The `--dotfiles` flag tells Stow to translate `dot-` prefixes into `.` when creating symlinks:

```
src/zsh/dot-zshrc          →  ~/.zshrc
src/zsh/dot-zshenv         →  ~/.zshenv
src/nvim/dot-config/nvim/  →  ~/.config/nvim/
```

## Package Layout

```
src/
├── shell/          ~/.config/shell/aliases.sh
├── zsh/            ~/.zshrc, ~/.zshenv, ~/.zsh_plugins.txt
├── nvim/           ~/.config/nvim/
├── tmux/           ~/.config/tmux/tmux.conf
├── ghostty/        ~/.config/ghostty/config
├── yazi/           ~/.config/yazi/
├── kitty/          ~/.config/kitty/
├── ideavim/        ~/.ideavimrc
└── fonts/          ~/.local/share/fonts/
```

## Commands

```bash
# Install a package
stow --dotfiles -d src -t ~ <package>

# Remove a package
stow -D --dotfiles -d src -t ~ <package>

# Re-stow (after adding files)
stow -R --dotfiles -d src -t ~ <package>

# Install everything
stow --dotfiles -d src -t ~ shell zsh nvim tmux ghostty yazi kitty ideavim fonts
```

## Adding a New Config

1. Create `src/<tool>/`
2. Mirror the home directory path using `dot-` for hidden files/dirs
3. Run `stow --dotfiles -d src -t ~ <tool>`
