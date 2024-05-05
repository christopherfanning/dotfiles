#!/bin/bash

echo "installing cfan dotfiles"

# mv ~/.zshrc ~/.zshrc.before.cfan.dotfiles
# mv ~/.zsh_plugins.txt ~/.zsh_plugins.txt.before.cfan.dotfiles



# Ask about the linking
# ln -s ~/dotfiles/src/zshrc ~/.zshrc
# ln -s ~/dotfiles/src/nvim ~/.config/
# ln -s ~/dotfiles/src/zsh_plugins.txt ~/.zsh_plugins.txt
# ln -s ~/dotfiles/src/tmux/tmux.conf ~/.tmux.conf
# ln -s ~/dotfiles/fonts ~/.fonts

# TODO 
# ln -s ~/dotfiles/src/tmux ~/.config/tmux
# ln -s ~dotfiles/src/nvim ~/.config/nvim
# Add kitty install ( or whatever terminal )
#

# Create directory for Jetbrains commandline tools.
mkdir ~/.local/share/JetBrains/Toolbox/apps
mkdir ~/.local/share/JetBrains/Toolbox/scripts


# sudo dnf install gcc g++ ranger wget curl neovim neofetch openssl netcat tmux fzf bat kitty tmux htop bpytop emacs

# sudo zypper ar http://dl.google.com/linux/chrome/rpm/stable/x86_64 Google-Chrome
# 
# wget https://dl.google.com/linux/linux_signing_key.pub
# sudo rpm --import linux_signing_key.pub

# sudo apt install gcc gpp ranger wget curl neovim neofetch openssl netcat tmux fzf bat kitty tmux htop btop emacs git dropbox kubectx zsh kio-gdrive google-chrome-stable zip nodejs docker xbanish kubernetes-client docker 

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Docker Install
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo apt install gcc zlib1g-dev gpp ranger highlight wget curl neofetch openssl netcat tmux fzf bat tmux htop emacs git zsh kio-gdrive zip nodejs docker xbanish docker docker-compose tree

sudo apt-get install build-essential most wireshark-qt ripgrep fd-find spellcheck

# Install neovim
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip neovim

# add to bashrc
# export PAGER=“most”


# Install Antidote
git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote

# Install TPM for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


# Install SDKMan
curl -s "https://get.sdkman.io" | bash

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install lazygit

# Install Packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim


# Install NVM
echo "install NVM"
echo "https://github.com/nvm-sh/nvm?tab=readme-ov-file#install--update-script"

echo "Then run:"
echo "  nvm install --lts"


# Install fix for gdrive ubuntu

# Reload fonts
fc-cache -f -v

sudo chsh --shell $(which zsh) $USER

# Git config
git config --global core.editor "nvim"
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --global color.ui auto



# test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
# test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc

