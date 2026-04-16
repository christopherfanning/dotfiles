# Shell — Aliases

> All aliases defined in `~/.config/shell/aliases.sh`. File: `src/shell/dot-config/shell/aliases.sh`

Sourced from `.zshrc`:
```zsh
[[ -f "$HOME/.config/shell/aliases.sh" ]] && source "$HOME/.config/shell/aliases.sh"
```

---

## eza — modern `ls`

| Alias | Expands to | Shows |
|-------|-----------|-------|
| `ls` | `eza --icons --group-directories-first` | Basic list with icons |
| `ll` | `eza -lh --icons --group-directories-first --git` | Long + git status |
| `la` | `eza -lah --icons --group-directories-first --git` | Long + hidden + git |
| `lt` | `eza --tree --icons --level=2` | 2-level tree |
| `lta` | `eza --tree --icons -a --level=2` | 2-level tree + hidden |
| `l` | `eza -1 --icons` | One file per line |

## Neovim

| Alias | Expands to |
|-------|-----------|
| `vim` | `nvim` |
| `vi` | `nvim` |

## Lazy tools

| Alias | Expands to |
|-------|-----------|
| `lg` | `lazygit` |
| `ld` | `lazydocker` |
| `y` | `yazi` |

## Navigation

| Alias | Expands to |
|-------|-----------|
| `..` | `cd ..` |
| `...` | `cd ../..` |
| `....` | `cd ../../..` |

## Dotfiles shortcuts

| Alias | Action |
|-------|--------|
| `zrc` | Edit `~/.zshrc` in Neovim |
| `zenv` | Edit `~/.zshenv` in Neovim |
| `dotfiles` | `cd ~/dotfiles` |
| `notes` | `cd ~/notes` |
| `code` | `cd ~/code` |

## Git shortcuts

| Alias | Expands to |
|-------|-----------|
| `g` | `git` |
| `gs` | `git status` |
| `gd` | `git diff` |
| `gc` | `git commit` |
| `gp` | `git push` |
| `gl` | `git pull` |
| `glog` | `git log --oneline --graph --decorate` |

## tmux shortcuts

| Alias | Expands to |
|-------|-----------|
| `ta` | `tmux attach` |
| `tls` | `tmux ls` |
| `tn` | `tmux new-session -s` |

## Misc

| Alias | Expands to | Note |
|-------|-----------|------|
| `http` | `xh` | xh = modern curl (httpie syntax) |
| `icat` | `kitten icat` | Inline image in Kitty/Ghostty |
| `idea` | `idea . &` | Open IntelliJ in background |
| `help` | `tldr` | Tealdeer quick-reference |
| `neofetch` | `fastfetch` | neofetch is archived; fastfetch is its successor |
