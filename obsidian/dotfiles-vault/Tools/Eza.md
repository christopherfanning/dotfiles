# Eza

> A modern replacement for `ls`, written in Rust.

## Why Eza (over ls / lsd / exa)

- **Icons**: Nerd Font icons per file type out of the box (`--icons`)
- **Git status**: Shows per-file git status inline (`--git`)
- **Tree view**: Built-in recursive tree (`--tree`) replacing `tree`
- **Active**: `exa` is unmaintained; `eza` is the maintained community fork

## Aliases

```zsh
alias ls='eza --icons --group-directories-first'
alias ll='eza -lh --icons --group-directories-first --git'
alias la='eza -lah --icons --group-directories-first --git'
alias lt='eza --tree --icons --group-directories-first --level=2'
alias lta='eza --tree --icons --group-directories-first -a --level=2'
alias l='eza -1 --icons'
```

## Requires

MesloLGS NF (or any Nerd Font) for icons to render correctly. Already included in `src/fonts/`.
