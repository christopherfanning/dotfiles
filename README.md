## Cfan dotfiles

TODO put links to the projects we're using here
TODO add screen or byobu or tmux config


# Features / What's here
- Conveniently places Zsh, Vim configs in one place 

# Use Case for this config
  - Readablility ( syntax highlighting )
  - Automation ( pulling and displaying data that would otherwise need to be queried )
    - autocompletion of command syntax
    - aliases 
    - pull common data ahead of time  
      - ( git, k8s, battery life, timezone, etc ) 
  - Features 
    - display images in terminal

## Zsh

- Antidote - Package management

### Plugins
- Powerlevel10k
- Vim mode
- Syntax highlighting
- Add kubernetes plugin


## neovim

```bash
sudo add-apt-repository ppa:neovim-ppa/stable

```

Packer - for package management

### Plugins
  - Telescope
  - Harpoon
  - nerdTree
  - treesitter 

### Other 
  - key bindings



# Installing

## Dependencies
  - cargo install tree-sitter-cli
  - install Packer
  - install emacs
  - install rust
  - TODO install zsh
  - TODO install antidote
  - TODO install tmux
  - TODO install tpm
  - TODO install nvim
  - TODO install netcat
  - TODO install curl
  - TODO install htop
  - TODO install nmap
  - TODO install az cli
  - TODO install k8s plugin
  - TODO install k9s
  - TODO install kubectx
  - TODO install kitty
  - TODO install nvm

  ```bash
  # Install Packer
  git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

 # Install Rust
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  
  cargo install tree-sitter-cli
  ```

## Other tools 
  - Ranger
  - k9s
  - az cli
  - htop
  - bpytop
  - emacs

  ```bash
  # Install all the things
  sudo apt install ranger netcat tmux curl wget git nmap curl neovim htop fzf

  # Install nvm 
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

  # Install kubectl
  #  Get PPA from kubernetes
  sudo apt-get install -y kubectl


  # Install Krew
  (
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
  )

  
  # Install k9s


  ```
   

## Script install
  - makes backup of files before it links to files in ~/dotfiles/src

  ```bash
  bin/install.dotfiles.sh
  ```

## Manual install 

```bash
ln -s ~/dotfiles/src/zshrc ~/.zshrc
ln -s ~/dotfiles/src/zsh_plugins.txt ~/.zsh_plugins.txt 

```


