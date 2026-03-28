# navi — Interactive Cheatsheet Browser

> Browse and execute commands from community cheatsheets with an interactive fzf-powered TUI.

## Why navi

- Type a keyword, navi shows matching commands with descriptions
- Fill in variables interactively (no more copy-pasting and editing placeholders)
- Can import community cheat repos (tldr, cheat.sh, your own)
- `Ctrl+G` in the shell opens it inline mid-command

## Usage

```bash
navi          # open interactive browser
navi --query "docker"    # pre-filter
navi --cheatsh           # use cheat.sh as backend
```

## Shell widget (Ctrl+G)

Enabled in `.zshrc` via `eval "$(navi widget zsh)"`.  
Press `Ctrl+G` at any time to open navi and insert the selected command at the cursor.

## Add community repos

```bash
navi repo add denisidoro/cheats
navi repo add denisidoro/dotfiles
```

## Write your own cheats

Create `~/.local/share/navi/cheats/personal.cheat`:

```
% git, personal

# Undo last commit (keep changes staged)
git reset --soft HEAD~1

# Interactive rebase last N commits
git rebase -i HEAD~<n>
```
