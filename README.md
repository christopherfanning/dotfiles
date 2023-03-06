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


