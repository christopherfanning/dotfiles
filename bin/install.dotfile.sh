#!/bin/bash

echo "installing cfan dotfiles"

mv ~/.zshrc ~/.zshrc.before.cfan.dotfiles
mv ~/.zsh_plugins.txt ~/.zsh_plugins.txt.before.cfan.dotfiles

ln -s ~/dotfiles/src/zshrc ~/.zshrc
ln -s ~/dotfiles/src/zsh_plugins.txt ~/.zsh_plugins.txt 

sudo dnf install gcc g++ ranger wget curl neovim neofetch openssl netcat tmux fzf bat kitty tmux htop bpytop emacs


