#!/bin/bash

echo "installing cfan dotfiles"

mv ~/.zshrc ~/.zshrc.before.cfan.dotfiles
mv ~/.zsh_plugins.txt ~/.zsh_plugins.txt.before.cfan.dotfiles



ln -s ~/dotfiles/src/zshrc ~/.zshrc
ln -s ~/dotfiles/src/zsh_plugins.txt ~/.zsh_plugins.txt
ln -s ~/dotfiles/src/tmux ~/.config/tmux




# sudo dnf install gcc g++ ranger wget curl neovim neofetch openssl netcat tmux fzf bat kitty tmux htop bpytop emacs

# sudo zypper ar http://dl.google.com/linux/chrome/rpm/stable/x86_64 Google-Chrome
# 
# wget https://dl.google.com/linux/linux_signing_key.pub
# sudo rpm --import linux_signing_key.pub

sudo zypper ref -f
sudo zypper install gcc gpp ranger wget curl neovim neofetch openssl netcat tmux fzf bat kitty tmux htop btop emacs git dropbox kubectx zsh kio-gdrive google-chrome-stable zip nodejs


# Install Antidote
git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote

# Install TPM for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install SDKMan
curl -s "https://get.sdkman.io" | bash



