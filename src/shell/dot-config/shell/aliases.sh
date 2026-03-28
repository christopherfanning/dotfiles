# ──────────────────────────────────────────────
# Shell Aliases
# Sourced from ~/.zshrc (and any other shell rc)
# ──────────────────────────────────────────────

# ── eza (modern ls) ───────────────────────────
alias ls='eza --icons --group-directories-first'
alias ll='eza -lh --icons --group-directories-first --git'
alias la='eza -lah --icons --group-directories-first --git'
alias lt='eza --tree --icons --group-directories-first --level=2'
alias lta='eza --tree --icons --group-directories-first -a --level=2'
alias l='eza -1 --icons'

# ── Neovim ────────────────────────────────────
alias vim='nvim'
alias vi='nvim'

# ── Lazy tools ────────────────────────────────
alias lg='lazygit'
alias ld='lazydocker'

# ── Yazi ──────────────────────────────────────
alias y='yazi'

# ── Navigation ────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ── Dotfiles shortcuts ────────────────────────
alias zrc='nvim ~/.zshrc'
alias zenv='nvim ~/.zshenv'
alias dotfiles='cd ~/dotfiles'
alias notes='cd ~/notes'
alias code='cd ~/code'

# ── Git shortcuts ─────────────────────────────
alias g='git'
alias gs='git status'
alias gd='git diff'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias glog='git log --oneline --graph --decorate'

# ── Tmux shortcuts ────────────────────────────
alias ta='tmux attach'
alias tls='tmux ls'
alias tn='tmux new-session -s'

# ── Misc ──────────────────────────────────────
alias icat='kitten icat'          # kitty image preview
alias idea='idea . &'             # open IntelliJ in background
