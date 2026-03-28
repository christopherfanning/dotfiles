---
name: dotfiles-stow-manager
description: Manages dotfiles using GNU Stow for symlink automation and package-based organization
---

# Dotfiles Management with GNU Stow

## When to Use This Skill
Use this skill when working with dotfiles repositories that use GNU Stow for symlink management, particularly for:
- Installing/uninstalling dotfile packages
- Organizing configuration files by application
- Managing symlinks across multiple machines
- Troubleshooting stow conflicts

## Core Stow Commands

### Installation
```bash
# Install a package (creates symlinks)
stow -d ~/dotfiles -t ~ package_name

# Install with verbose output
stow -v package_name

# Dry run (preview changes without making them)
stow -n -v package_name
```

### Uninstallation
```bash
# Remove symlinks for a package
stow -D package_name

# Remove with verbose output
stow -D -v package_name
```

### Restowing
```bash
# Refresh symlinks (useful after updates)
stow -R package_name

# Restow all packages
stow -R */
```

### Adopting Existing Files
```bash
# Move existing files into stow package and create symlinks
stow --adopt package_name

# IMPORTANT: Review changes with git diff before committing
# This overwrites files in your dotfiles repo with system files
```

## Directory Structure Best Practices

Dotfiles should be organized to mirror the home directory structure:

```
~/dotfiles/
  ├── .stow-local-ignore    # Files to exclude from stowing
  ├── Makefile              # Automation targets
  ├── README.md
  ├── zsh/
  │   ├── .zshrc
  │   └── .zsh/
  │       └── aliases.zsh
  ├── nvim/
  │   └── .config/
  │       └── nvim/
  │           └── init.lua
  ├── kitty/
  │   └── .config/
  │       └── kitty/
  │           └── kitty.conf
  └── git/
      └── .gitconfig
```

## Common Patterns

### Multi-Machine Support
```bash
# Create OS-specific packages
mkdir -p linux macos
mkdir -p work personal

# Conditional stowing in install script
if [[ "$OSTYPE" == "darwin"* ]]; then
    stow macos
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    stow linux
fi
```

### Stow Ignore File
Create `.stow-local-ignore` in the dotfiles root:
```
README\.md
Makefile
\.git
\.gitignore
bin
scripts
LICENSE
```

### Makefile Automation
```makefile
STOW := stow
DOTFILES := $(shell pwd)
PACKAGES := $(shell ls -d */ | grep -v '^\.git' | sed 's/\///')

.PHONY: install uninstall restow

install:
	@for package in $(PACKAGES); do \
		echo "Installing $$package..."; \
		$(STOW) -d $(DOTFILES) -t $(HOME) $$package; \
	done

uninstall:
	@for package in $(PACKAGES); do \
		echo "Uninstalling $$package..."; \
		$(STOW) -D -d $(DOTFILES) -t $(HOME) $$package; \
	done

restow:
	@for package in $(PACKAGES); do \
		echo "Restowing $$package..."; \
		$(STOW) -R -d $(DOTFILES) -t $(HOME) $$package; \
	done
```

## Troubleshooting

### Conflict Resolution
When stow reports conflicts:
1. Use `stow -n -v package` to see what would happen
2. Check if target file/directory already exists
3. Options:
   - Back up existing file and try again
   - Use `--adopt` to incorporate existing file into package
   - Remove conflicting file if safe to do so

### Broken Symlinks
```bash
# Find broken symlinks in home directory
find ~ -maxdepth 3 -type l ! -exec test -e {} \; -print

# Clean up broken symlinks from stow
stow -D old_package  # Remove package that no longer exists
```

### Directory Folding
Stow "folds" directories when possible (creates symlink to directory instead of individual files). To prevent this:
- Create `.stow` file in the directory
- Or ensure other non-stowed files exist in the target directory

## Best Practices

1. **Always dry-run first**: Use `-n` flag to preview changes
2. **Use version control**: Git tracks your dotfiles, stow creates symlinks
3. **Package by application**: One directory per tool/application
4. **Mirror home structure**: Make directory paths within packages match target paths
5. **Document dependencies**: Note required packages/tools in README
6. **Test on fresh system**: Verify installation works from scratch
7. **Ignore build artifacts**: Use .stow-local-ignore for non-config files

## Integration with Git

```bash
# Stow automatically ignores .git directories
cd ~/dotfiles
git init
git add .
git commit -m "Initial dotfiles"

# On new machine
git clone https://github.com/user/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow */  # Install all packages
```

## Advanced Usage

### Targeting Different Directories
```bash
# Stow to non-home location
stow -d ~/dotfiles -t ~/.config config_package

# Multiple targets
stow -t ~/.local/bin scripts
stow -t ~/.config configs
```

### Selective Restowing
```bash
# Only restow changed packages (in git hook)
git diff --name-only HEAD@{1} HEAD | cut -d/ -f1 | sort -u | xargs -I {} stow -R {}
```

## Related Tools

- **dotbot**: Alternative automation tool with YAML config
- **chezmoi**: Advanced manager with templating and encryption
- **rcm**: Thoughtbot's dotfiles manager
- **yadm**: Git-based dotfiles manager with encryption

## Resources

- Official manual: https://www.gnu.org/software/stow/manual/stow.html
- Community examples: https://dotfiles.github.io/
- Troubleshooting guide: `man stow` section on "Resource Files"
