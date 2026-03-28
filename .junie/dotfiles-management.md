# Dotfiles Management with GNU Stow

## Summary
The repository uses GNU Stow to manage and restore dotfiles. It utilizes the Stow `--dotfiles` feature, which allows storing files and directories with a `dot-` prefix instead of a literal `.` in the package source.

## Rules
- **Package Structure**: Each tool or configuration should be organized into its own package directory (e.g., `zsh`, `nvim`, `tmux`, `kitty`, `ranger`, `ideavim`).
- **Use `dot-` Prefix**: Always use the `dot-` prefix instead of a literal `.` for dotfiles and dotdirectories in the package source.
  - Example: Rename `.zshrc` to `dot-zshrc`.
  - Example: Rename `.config/nvim` to `dot-config/nvim`.
- **Command to Restore**: Use `stow -t ~ --dotfiles <package_name>` to symlink configurations to the home directory.
- **Stow Target**: The target directory for Stow should always be the home directory (`~`).
- **Do Not Manually Symlink**: Avoid using `ln -s` manually; use `stow` to manage symlinks to ensure consistency and easy removal.
- **Removing a Configuration**: Use `stow -D -t ~ --dotfiles <package_name>` to remove the symlinks for a configuration.
- **Adding New Configurations**: When adding a new tool configuration:
  1. Create a new directory in the root named after the tool (e.g., `git`).
  2. Mimic the path relative to the home directory within that package, using `dot-` for any leading dots.
  3. Move the configuration file into the package directory.
  4. Run `stow -t ~ --dotfiles <package_name>`.
