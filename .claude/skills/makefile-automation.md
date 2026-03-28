---
name: makefile-automation
description: Creates Makefile targets for automating dotfiles installation, updates, and maintenance tasks
---

# Makefile Automation for Dotfiles

## When to Use This Skill
Use this skill when creating or improving Makefiles for dotfiles repositories to:
- Provide simple commands for common operations (install, update, clean)
- Automate stow operations across multiple packages
- Handle platform-specific installation
- Run tests and validation
- Manage dependencies and prerequisites

## Basic Dotfiles Makefile Template

```makefile
# Dotfiles Makefile
.PHONY: help install uninstall restow update clean test

# Configuration
SHELL := /bin/bash
DOTFILES_DIR := $(shell pwd)
TARGET_DIR := $(HOME)
STOW := stow
STOW_FLAGS := -v

# Detect OS
UNAME := $(shell uname -s)
ifeq ($(UNAME),Darwin)
    OS := macos
else ifeq ($(UNAME),Linux)
    OS := linux
else
    OS := unknown
endif

# Package discovery
ALL_PACKAGES := $(shell find . -maxdepth 1 -type d -not -name '.*' -not -name 'scripts' -not -name 'bin' | sed 's|./||')
COMMON_PACKAGES := zsh git tmux nvim
OS_PACKAGES := $(wildcard $(OS)/*)

# Default target
help:
	@echo "Dotfiles Management"
	@echo ""
	@echo "Targets:"
	@echo "  install     - Install all dotfiles"
	@echo "  uninstall   - Remove all dotfiles"
	@echo "  restow      - Refresh all symlinks"
	@echo "  update      - Pull latest changes and restow"
	@echo "  clean       - Remove broken symlinks"
	@echo "  test        - Run validation tests"
	@echo ""
	@echo "OS detected: $(OS)"

# Install all packages
install: check-stow
	@echo "Installing dotfiles for $(OS)..."
	@for package in $(COMMON_PACKAGES); do \
		if [ -d "$$package" ]; then \
			echo "Installing $$package..."; \
			$(STOW) $(STOW_FLAGS) -d $(DOTFILES_DIR) -t $(TARGET_DIR) $$package; \
		fi; \
	done
	@if [ "$(OS)" != "unknown" ] && [ -d "$(OS)" ]; then \
		echo "Installing $(OS)-specific packages..."; \
		$(STOW) $(STOW_FLAGS) -d $(DOTFILES_DIR) -t $(TARGET_DIR) $(OS); \
	fi
	@echo "✓ Installation complete"

# Uninstall all packages
uninstall:
	@echo "Uninstalling dotfiles..."
	@for package in $(COMMON_PACKAGES); do \
		if [ -d "$$package" ]; then \
			echo "Uninstalling $$package..."; \
			$(STOW) -D $(STOW_FLAGS) -d $(DOTFILES_DIR) -t $(TARGET_DIR) $$package; \
		fi; \
	done
	@if [ "$(OS)" != "unknown" ] && [ -d "$(OS)" ]; then \
		$(STOW) -D $(STOW_FLAGS) -d $(DOTFILES_DIR) -t $(TARGET_DIR) $(OS); \
	fi
	@echo "✓ Uninstallation complete"

# Restow (refresh symlinks)
restow:
	@echo "Restowing dotfiles..."
	@for package in $(COMMON_PACKAGES); do \
		if [ -d "$$package" ]; then \
			echo "Restowing $$package..."; \
			$(STOW) -R $(STOW_FLAGS) -d $(DOTFILES_DIR) -t $(TARGET_DIR) $$package; \
		fi; \
	done
	@if [ "$(OS)" != "unknown" ] && [ -d "$(OS)" ]; then \
		$(STOW) -R $(STOW_FLAGS) -d $(DOTFILES_DIR) -t $(TARGET_DIR) $(OS); \
	fi
	@echo "✓ Restow complete"

# Update from git and restow
update:
	@echo "Updating dotfiles from git..."
	git pull --rebase
	@if [ -f .gitmodules ]; then \
		echo "Updating submodules..."; \
		git submodule update --init --recursive; \
	fi
	@$(MAKE) restow

# Check if stow is installed
check-stow:
	@command -v $(STOW) >/dev/null 2>&1 || { \
		echo "Error: GNU Stow is not installed"; \
		echo "Install with: brew install stow (macOS) or apt install stow (Linux)"; \
		exit 1; \
	}

# Clean broken symlinks
clean:
	@echo "Cleaning broken symlinks in $(TARGET_DIR)..."
	@find $(TARGET_DIR) -maxdepth 3 -type l ! -exec test -e {} \; -print -delete
	@echo "✓ Cleanup complete"

# Run tests
test:
	@echo "Running validation tests..."
	@echo "Checking for required commands..."
	@for cmd in git stow; do \
		command -v $$cmd >/dev/null 2>&1 || { echo "Missing: $$cmd"; exit 1; }; \
	done
	@echo "✓ All tests passed"
```

## Advanced Patterns

### Selective Package Installation
```makefile
# Install specific package
install-%:
	@if [ -d "$*" ]; then \
		echo "Installing $*..."; \
		$(STOW) $(STOW_FLAGS) -d $(DOTFILES_DIR) -t $(TARGET_DIR) $*; \
	else \
		echo "Error: Package $* not found"; \
		exit 1; \
	fi

# Uninstall specific package
uninstall-%:
	@if [ -d "$*" ]; then \
		echo "Uninstalling $*..."; \
		$(STOW) -D $(STOW_FLAGS) -d $(DOTFILES_DIR) -t $(TARGET_DIR) $*; \
	else \
		echo "Warning: Package $* not found"; \
	fi

# Usage: make install-nvim, make uninstall-zsh
```

### Dependency Management
```makefile
# Package dependencies
nvim: install-nvim install-vim-plug
tmux: install-tmux install-tpm

# Install vim-plug
install-vim-plug:
	@if [ ! -f "$(HOME)/.local/share/nvim/site/autoload/plug.vim" ]; then \
		echo "Installing vim-plug..."; \
		curl -fLo $(HOME)/.local/share/nvim/site/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim; \
	fi

# Install TPM (Tmux Plugin Manager)
install-tpm:
	@if [ ! -d "$(HOME)/.tmux/plugins/tpm" ]; then \
		echo "Installing TPM..."; \
		git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm; \
	fi
```

### Platform-Specific Targets
```makefile
# macOS-specific installation
macos: check-brew
	brew bundle --file=Brewfile
	@$(MAKE) install

# Linux-specific installation
linux:
	@if command -v apt >/dev/null 2>&1; then \
		sudo apt update && sudo apt install -y $(shell cat packages.txt); \
	elif command -v dnf >/dev/null 2>&1; then \
		sudo dnf install -y $(shell cat packages.txt); \
	fi
	@$(MAKE) install

# Check if Homebrew is installed
check-brew:
	@command -v brew >/dev/null 2>&1 || { \
		echo "Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	}
```

### Dry Run Support
```makefile
# Variables for dry-run mode
DRY_RUN := false
ifeq ($(DRY_RUN),true)
    STOW_FLAGS += -n
endif

# Usage: make install DRY_RUN=true
dry-run:
	@$(MAKE) install DRY_RUN=true

# Or create dedicated target
preview:
	@echo "Preview of installation (dry-run):"
	@for package in $(COMMON_PACKAGES); do \
		if [ -d "$$package" ]; then \
			echo "--- Would install $$package ---"; \
			$(STOW) -n -v -d $(DOTFILES_DIR) -t $(TARGET_DIR) $$package 2>&1 | grep -v "BUG"; \
		fi; \
	done
```

### Backup and Restore
```makefile
BACKUP_DIR := $(HOME)/.dotfiles.backup

# Backup existing dotfiles
backup:
	@echo "Backing up existing dotfiles to $(BACKUP_DIR)..."
	@mkdir -p $(BACKUP_DIR)
	@for file in .bashrc .zshrc .vimrc .gitconfig; do \
		if [ -f "$(TARGET_DIR)/$$file" ] && [ ! -L "$(TARGET_DIR)/$$file" ]; then \
			cp "$(TARGET_DIR)/$$file" "$(BACKUP_DIR)/$$file.$(shell date +%Y%m%d_%H%M%S)"; \
			echo "Backed up $$file"; \
		fi; \
	done

# Restore from most recent backup
restore:
	@echo "Restoring dotfiles from $(BACKUP_DIR)..."
	@if [ -d "$(BACKUP_DIR)" ]; then \
		for backup in $(BACKUP_DIR)/*; do \
			original=$$(basename $$backup | sed 's/\.[0-9_]*$$//'); \
			cp "$$backup" "$(TARGET_DIR)/$$original"; \
			echo "Restored $$original"; \
		done; \
	else \
		echo "No backup found at $(BACKUP_DIR)"; \
	fi
```

### Testing and Validation
```makefile
# Comprehensive test suite
test: test-syntax test-links test-dependencies

# Test shell script syntax
test-syntax:
	@echo "Checking shell script syntax..."
	@find . -name '*.sh' -type f -exec bash -n {} \;
	@echo "✓ Syntax check passed"

# Verify symlinks are valid
test-links:
	@echo "Verifying symlinks..."
	@broken=0; \
	for package in $(COMMON_PACKAGES); do \
		if [ -d "$$package" ]; then \
			cd $$package && find . -type f | while read file; do \
				target="$(TARGET_DIR)/$${file#./}"; \
				if [ -L "$$target" ]; then \
					if [ ! -e "$$target" ]; then \
						echo "Broken symlink: $$target"; \
						broken=$$((broken + 1)); \
					fi; \
				fi; \
			done; \
			cd $(DOTFILES_DIR); \
		fi; \
	done; \
	if [ $$broken -gt 0 ]; then exit 1; fi
	@echo "✓ All symlinks valid"

# Check required dependencies
test-dependencies:
	@echo "Checking dependencies..."
	@for cmd in git stow curl; do \
		if ! command -v $$cmd >/dev/null 2>&1; then \
			echo "Missing dependency: $$cmd"; \
			exit 1; \
		fi; \
	done
	@echo "✓ All dependencies present"
```

### Git Integration
```makefile
# Commit and push changes
save:
	git add -A
	@read -p "Commit message: " msg; \
	git commit -m "$$msg"
	git push

# Pull and update
sync:
	git pull --rebase
	git submodule update --init --recursive
	@$(MAKE) restow

# Show status
status:
	@echo "Git status:"
	@git status -s
	@echo ""
	@echo "Installed packages:"
	@for package in $(COMMON_PACKAGES); do \
		if [ -d "$$package" ]; then \
			echo "  ✓ $$package"; \
		fi; \
	done
```

### Bootstrap Target
```makefile
# First-time setup
bootstrap: check-os install-dependencies install setup-shell
	@echo "✓ Bootstrap complete!"
	@echo "Please restart your shell"

# Detect OS and print info
check-os:
	@echo "Operating System: $(OS)"
	@echo "Shell: $(SHELL)"
	@echo "Home: $(TARGET_DIR)"
	@echo "Dotfiles: $(DOTFILES_DIR)"

# Install system dependencies
install-dependencies:
ifeq ($(OS),macos)
	@$(MAKE) check-brew
	brew install git stow curl wget
else ifeq ($(OS),linux)
	@if command -v apt >/dev/null 2>&1; then \
		sudo apt update && sudo apt install -y git stow curl wget; \
	fi
endif

# Change default shell
setup-shell:
	@if [ "$(SHELL)" != "/bin/zsh" ]; then \
		echo "Changing shell to zsh..."; \
		chsh -s /bin/zsh; \
	fi
```

## Variables and Configuration

### Customizable Variables
```makefile
# Allow user overrides
DOTFILES_DIR ?= $(shell pwd)
TARGET_DIR ?= $(HOME)
STOW ?= stow
BACKUP_DIR ?= $(HOME)/.dotfiles.backup

# Package lists (can be overridden)
COMMON_PACKAGES ?= zsh git tmux nvim
OPTIONAL_PACKAGES ?= kitty alacritty

# Flags
VERBOSE ?= false
ifeq ($(VERBOSE),true)
    STOW_FLAGS += -v
endif
```

### Auto-Generated Lists
```makefile
# Automatically find all packages
ALL_PACKAGES := $(shell find . -maxdepth 1 -type d \
    -not -name '.' \
    -not -name '.git' \
    -not -name 'scripts' \
    -not -name 'bin' \
    | sed 's|./||' | sort)

# Filter by OS
ifeq ($(OS),macos)
    OS_SPECIFIC := $(filter macos-%,$(ALL_PACKAGES))
else
    OS_SPECIFIC := $(filter linux-%,$(ALL_PACKAGES))
endif
```

## Best Practices

1. **Use `.PHONY`**: Declare all targets that don't create files
2. **Default help target**: First target shows usage information
3. **Check dependencies**: Verify required tools before running
4. **Silent by default**: Use `@` to hide commands, `-v` for verbose
5. **Error handling**: Exit with non-zero status on failures
6. **Idempotent targets**: Safe to run multiple times
7. **Document targets**: Add help text for user-facing commands
8. **Platform detection**: Handle macOS/Linux differences
9. **Dry-run support**: Allow preview before making changes
10. **Variables at top**: Make configuration easy to find and modify

## Common Targets Reference

```makefile
install         # Install all dotfiles
uninstall       # Remove all dotfiles
restow          # Refresh symlinks
update          # Pull from git and restow
clean           # Remove broken symlinks
backup          # Backup existing files
restore         # Restore from backup
test            # Run validation tests
bootstrap       # First-time setup
status          # Show current status
help            # Show usage information
```

## Resources

- GNU Make manual: https://www.gnu.org/software/make/manual/
- Example repos: numToStr/dotfiles, ahawker/dotfiles
- Make best practices: https://tech.davis-hansson.com/p/make/
