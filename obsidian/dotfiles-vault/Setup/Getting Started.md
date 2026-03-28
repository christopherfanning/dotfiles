# Getting Started

## Prerequisites

On Arch Linux, run `bin/arch-install.sh` first. On other distros, install the equivalent packages manually (see the commented apt/dnf commands in `bin/install.dotfiles.sh`).

## Install

```bash
git clone <your-dotfiles-repo> ~/dotfiles
cd ~/dotfiles
bin/install.dotfiles.sh
```

## What the installer does

1. Creates JetBrains Toolbox directory structure
2. Clones Antidote (zsh plugin manager) if not present
3. Installs TPM (tmux plugin manager) if not present
4. Stows all config packages into `~`
5. Changes default shell to zsh

## After install

- Open tmux → `prefix + I` to install TPM plugins
- Open nvim → plugins auto-install via lazy.nvim
- Run `p10k configure` to set up your Powerlevel10k prompt style

## Stow packages managed

`shell` `zsh` `nvim` `tmux` `ghostty` `yazi` `kitty` `ideavim` `fonts`
