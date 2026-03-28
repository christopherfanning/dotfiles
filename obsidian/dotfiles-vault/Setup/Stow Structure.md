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

### Dry run first — always a good idea

Use `-n` (no-op) with `-v` (verbose) to preview exactly what stow *would* do before touching anything:

```bash
# Preview everything — $(ls src/) expands to all package directories automatically
stow -nv --dotfiles -d src -t ~ $(ls src/)

# Preview a single package
stow -nv --dotfiles -d src -t ~ <package>
```

Stow prints each symlink it would create (and any conflicts) without making changes. If it exits cleanly, run the same command without `-n`.

### Apply

```bash
# Install everything — no need to list packages individually
stow --dotfiles -d src -t ~ $(ls src/)

# Install a single package
stow --dotfiles -d src -t ~ <package>
```

`$(ls src/)` simply expands to every directory inside `src/`. New packages you add are automatically included — nothing else to update.

### Other operations

```bash
# Remove a package (deletes symlinks, leaves source files intact)
stow -D --dotfiles -d src -t ~ <package>

# Re-stow (remove + re-add, useful after renaming files)
stow -R --dotfiles -d src -t ~ <package>

# Dry-run a removal
stow -Dnv --dotfiles -d src -t ~ <package>
```

### Conflict resolution

If stow reports a conflict (a real file already exists at the target):

```bash
# Option 1 — adopt the live file into the repo, then review the diff
stow --adopt --dotfiles -d src -t ~ <package>
git diff          # see what changed
git checkout .    # restore repo version if you want it back

# Option 2 — back up the conflicting file, then stow normally
mv ~/.zshrc ~/.zshrc.bak
stow --dotfiles -d src -t ~ zsh
```

## Adding a New Config

1. Create `src/<tool>/`
2. Mirror the home directory path using `dot-` for hidden files/dirs
3. **Dry run**: `stow -nv --dotfiles -d src -t ~ <tool>`
4. If clean: `stow --dotfiles -d src -t ~ <tool>`
