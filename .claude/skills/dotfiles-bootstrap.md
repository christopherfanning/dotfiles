---
name: dotfiles-bootstrap
description: Automates fresh system setup with dotfiles installation, dependency management, and platform-specific configuration
---

# Dotfiles Bootstrap Script Development

## When to Use This Skill
Use this skill when creating or improving bootstrap/installation scripts for dotfiles repositories, particularly for:
- Setting up a new system from scratch
- Installing dependencies (package managers, tools, applications)
- Detecting and handling different operating systems
- Automating stow-based symlink creation
- Making installation idempotent (safe to re-run)

## Bootstrap Script Structure

### Minimal Bootstrap Template
```bash
#!/usr/bin/env bash

set -e  # Exit on error
set -u  # Exit on undefined variable

DOTFILES_DIR="${HOME}/dotfiles"
BACKUP_DIR="${HOME}/.dotfiles.backup"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() { echo -e "${GREEN}[INFO]${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
error() { echo -e "${RED}[ERROR]${NC} $*"; exit 1; }

# Detect OS
detect_os() {
    case "$OSTYPE" in
        darwin*)  OS="macos" ;;
        linux*)   OS="linux" ;;
        *)        error "Unsupported OS: $OSTYPE" ;;
    esac
    info "Detected OS: $OS"
}

# Check if command exists
has_command() {
    command -v "$1" >/dev/null 2>&1
}

# Install package manager
install_package_manager() {
    if [[ "$OS" == "macos" ]]; then
        if ! has_command brew; then
            info "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
    elif [[ "$OS" == "linux" ]]; then
        # Most Linux distros have apt/dnf/pacman pre-installed
        if has_command apt; then
            sudo apt update
        elif has_command dnf; then
            sudo dnf check-update
        fi
    fi
}

# Install GNU Stow
install_stow() {
    if has_command stow; then
        info "GNU Stow already installed"
        return
    fi

    info "Installing GNU Stow..."
    if [[ "$OS" == "macos" ]]; then
        brew install stow
    elif has_command apt; then
        sudo apt install -y stow
    elif has_command dnf; then
        sudo dnf install -y stow
    elif has_command pacman; then
        sudo pacman -S --noconfirm stow
    fi
}

# Backup existing dotfiles
backup_existing() {
    info "Backing up existing dotfiles to $BACKUP_DIR..."
    mkdir -p "$BACKUP_DIR"

    # List of common dotfiles to back up
    local files=(".bashrc" ".zshrc" ".vimrc" ".gitconfig")
    for file in "${files[@]}"; do
        if [[ -f "$HOME/$file" ]] && [[ ! -L "$HOME/$file" ]]; then
            mv "$HOME/$file" "$BACKUP_DIR/"
            info "Backed up $file"
        fi
    done
}

# Install dotfiles with stow
install_dotfiles() {
    info "Installing dotfiles with stow..."
    cd "$DOTFILES_DIR"

    # Get list of packages (directories)
    for package in */; do
        package=${package%/}  # Remove trailing slash

        # Skip non-package directories
        [[ "$package" == ".git" ]] && continue
        [[ "$package" == "scripts" ]] && continue

        info "Stowing $package..."
        stow -v "$package" 2>&1 | grep -v "BUG in find_stowed_path"
    done
}

# Main installation flow
main() {
    info "Starting dotfiles installation..."

    detect_os
    install_package_manager
    install_stow
    backup_existing
    install_dotfiles

    info "✓ Dotfiles installation complete!"
    info "Backup of old files: $BACKUP_DIR"
}

main "$@"
```

## Platform Detection Patterns

### OS Detection
```bash
# Detailed OS detection
get_os() {
    local os=""
    local dist=""

    if [[ "$OSTYPE" == "darwin"* ]]; then
        os="macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        os="linux"

        # Detect Linux distribution
        if [[ -f /etc/os-release ]]; then
            . /etc/os-release
            dist="$ID"
        elif [[ -f /etc/arch-release ]]; then
            dist="arch"
        elif [[ -f /etc/debian_version ]]; then
            dist="debian"
        fi
    fi

    echo "${os}:${dist}"
}

# Architecture detection
get_arch() {
    case "$(uname -m)" in
        x86_64)  echo "amd64" ;;
        aarch64) echo "arm64" ;;
        arm64)   echo "arm64" ;;
        *)       echo "unknown" ;;
    esac
}
```

### Hostname-Based Configuration
```bash
# Different configs for work vs personal
setup_machine_specific() {
    local hostname=$(hostname -s)

    case "$hostname" in
        work-*)
            stow work
            setup_work_tools
            ;;
        personal-*|home-*)
            stow personal
            ;;
        *)
            warn "Unknown hostname: $hostname"
            ;;
    esac
}
```

## Dependency Management

### Package Installation
```bash
# Install packages based on OS
install_packages() {
    local packages=(
        "git"
        "curl"
        "wget"
        "tmux"
        "neovim"
        "ripgrep"
        "fd"
        "fzf"
    )

    info "Installing packages..."

    if [[ "$OS" == "macos" ]]; then
        brew install "${packages[@]}"
    elif has_command apt; then
        sudo apt install -y "${packages[@]}"
    elif has_command dnf; then
        sudo dnf install -y "${packages[@]}"
    elif has_command pacman; then
        sudo pacman -S --noconfirm "${packages[@]}"
    fi
}

# Install from Brewfile (macOS)
install_from_brewfile() {
    if [[ "$OS" == "macos" ]] && [[ -f "$DOTFILES_DIR/Brewfile" ]]; then
        info "Installing from Brewfile..."
        brew bundle --file="$DOTFILES_DIR/Brewfile"
    fi
}
```

### Idempotent Installation
```bash
# Safe to run multiple times
idempotent_install() {
    # Check if already installed
    if [[ -f "$HOME/.dotfiles_installed" ]]; then
        warn "Dotfiles already installed. Use --force to reinstall."
        [[ "$*" != *"--force"* ]] && return
    fi

    # Perform installation
    install_dotfiles

    # Mark as installed
    touch "$HOME/.dotfiles_installed"
    date > "$HOME/.dotfiles_installed"
}
```

## Interactive Installation

### User Prompts
```bash
# Ask before potentially destructive operations
confirm() {
    local prompt="$1"
    local response

    read -r -p "$prompt [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY]) return 0 ;;
        *) return 1 ;;
    esac
}

# Use in script
if confirm "Backup existing dotfiles?"; then
    backup_existing
fi

if confirm "Install system packages?"; then
    install_packages
fi
```

### Progress Indicators
```bash
# Spinner for long operations
spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'

    while ps -p "$pid" > /dev/null; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Usage
install_packages &
spinner $!
```

## Post-Installation Setup

### Shell Configuration
```bash
# Set default shell
set_default_shell() {
    local target_shell="/bin/zsh"

    if [[ "$SHELL" != "$target_shell" ]]; then
        info "Changing default shell to zsh..."
        if ! grep -q "$target_shell" /etc/shells; then
            error "zsh not found in /etc/shells"
        fi
        chsh -s "$target_shell"
        info "Shell changed. Please restart your terminal."
    fi
}
```

### Plugin Managers
```bash
# Install vim-plug for Neovim
install_vim_plug() {
    local plug_file="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"

    if [[ ! -f "$plug_file" ]]; then
        info "Installing vim-plug..."
        curl -fLo "$plug_file" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

        # Install plugins
        nvim --headless +PlugInstall +qall
    fi
}

# Install tmux plugin manager
install_tpm() {
    local tpm_dir="$HOME/.tmux/plugins/tpm"

    if [[ ! -d "$tpm_dir" ]]; then
        info "Installing TPM..."
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
    fi
}
```

## Error Handling

### Rollback on Failure
```bash
# Track operations for rollback
OPERATIONS=()

track_operation() {
    OPERATIONS+=("$1")
}

rollback() {
    error "Installation failed! Rolling back..."

    for op in "${OPERATIONS[@]}"; do
        case "$op" in
            "stow:*")
                local pkg="${op#stow:}"
                stow -D "$pkg" 2>/dev/null || true
                ;;
            "backup")
                # Restore backups
                cp -r "$BACKUP_DIR"/* "$HOME/" 2>/dev/null || true
                ;;
        esac
    done
}

# Set trap
trap rollback ERR
```

## Remote Installation

### One-Line Install
```bash
# Self-bootstrapping from GitHub
curl -fsSL https://raw.githubusercontent.com/user/dotfiles/master/bootstrap.sh | bash

# Or with wget
wget -qO- https://raw.githubusercontent.com/user/dotfiles/master/bootstrap.sh | bash
```

### Bootstrap with Clone
```bash
#!/usr/bin/env bash
# Self-contained bootstrap

REPO_URL="https://github.com/user/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

# Clone if not exists
if [[ ! -d "$DOTFILES_DIR" ]]; then
    echo "Cloning dotfiles..."
    git clone --recursive "$REPO_URL" "$DOTFILES_DIR"
fi

# Run installer
cd "$DOTFILES_DIR"
./install.sh
```

## Testing Bootstrap Scripts

### Docker Testing
```bash
# Test on fresh Ubuntu
docker run -it --rm ubuntu:latest bash -c "
    apt update && apt install -y git curl &&
    git clone https://github.com/user/dotfiles.git ~/dotfiles &&
    cd ~/dotfiles && ./bootstrap.sh
"

# Test on macOS (requires Docker Desktop)
docker run -it --rm sickcodes/docker-osx:latest
```

### Makefile Test Target
```makefile
.PHONY: test-bootstrap

test-bootstrap:
	@echo "Testing bootstrap in Docker..."
	docker run --rm -v $(PWD):/dotfiles ubuntu:latest \
		bash -c "cd /dotfiles && ./bootstrap.sh --dry-run"
```

## Best Practices

1. **Make it idempotent**: Safe to run multiple times without side effects
2. **Provide dry-run mode**: Let users preview what will happen
3. **Backup existing files**: Never destructively overwrite without backup
4. **Clear output**: Use colors and progress indicators
5. **Error handling**: Catch failures and provide helpful messages
6. **Platform detection**: Handle macOS, Linux, and distributions appropriately
7. **Documentation**: Comment complex sections, maintain README
8. **Test on fresh systems**: Regularly verify installation from scratch

## Common Flags

```bash
# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -f|--force)
            FORCE=true
            shift
            ;;
        -n|--dry-run)
            DRY_RUN=true
            shift
            ;;
        -v|--verbose)
            set -x  # Enable bash debugging
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            error "Unknown option: $1"
            ;;
    esac
done
```

## Resources

- Example repos: numToStr/dotfiles, kylelundstedt/dotfiles, pedrosanta/dotfiles
- Shell best practices: https://google.github.io/styleguide/shellguide.html
- Bash strict mode: http://redsymbol.net/articles/unofficial-bash-strict-mode/
