# Keybinds Reference

> Quick reference for every tool in the stack. All vim-style navigation is consistent: `hjkl` to move, leader-driven in Neovim.

---

## tmux — prefix: `Ctrl+Space`

### Sessions
| Key | Action |
|-----|--------|
| `prefix + o` | fzf session manager (sessionx) |
| `prefix + $` | Rename session |
| `prefix + d` | Detach from session |
| `prefix + Ctrl-s` | Save session (resurrect) |
| `prefix + Ctrl-r` | Restore session (resurrect) |

### Windows
| Key | Action |
|-----|--------|
| `prefix + c` | New window (in current path) |
| `prefix + ,` | Rename window |
| `prefix + &` | Kill window |
| `prefix + 1–9` | Switch to window N |
| `prefix + n / p` | Next / previous window |

### Panes
| Key | Action |
|-----|--------|
| `prefix + \|` | Split horizontal (current path) |
| `prefix + -` | Split vertical (current path) |
| `prefix + h/j/k/l` | Navigate panes (vim-style) |
| `prefix + H/J/K/L` | Resize pane (repeatable) |
| `prefix + x` | Kill pane |
| `prefix + z` | Zoom pane toggle |
| `Ctrl+h/j/k/l` | Navigate panes **and** Neovim splits (vim-tmux-navigator) |

### Copy mode
| Key | Action |
|-----|--------|
| `prefix + [` | Enter copy mode |
| `v` | Begin selection |
| `Ctrl+v` | Rectangle selection toggle |
| `y` | Copy selection |
| `q` | Exit copy mode |

### Plugins
| Key | Action |
|-----|--------|
| `prefix + Space` | thumbs hint-mode (click to copy any text on screen) |
| `prefix + u` | fzf-url (open URLs from visible output) |
| `prefix + I` | Install plugins (TPM) |
| `prefix + U` | Update plugins (TPM) |

---

## Neovim / LazyVim — leader: `Space`

> Full LazyVim keymap reference: https://www.lazyvim.org/keymaps

### Navigation
| Key | Action |
|-----|--------|
| `Space + Space` | Find files (Telescope/Snacks) |
| `Space + /` | Grep in project |
| `Space + e` | File explorer (neo-tree) |
| `Space + b` | Buffers |
| `Space + f + r` | Recent files |
| `Ctrl+h/j/k/l` | Navigate splits (vim-tmux-navigator) |

### Code
| Key | Action |
|-----|--------|
| `g + d` | Go to definition |
| `g + r` | Go to references |
| `g + i` | Go to implementation |
| `K` | Hover docs |
| `Space + c + a` | Code action |
| `Space + c + r` | Rename symbol |
| `[d / ]d` | Previous / next diagnostic |

### Git (fugitive / gitsigns)
| Key | Action |
|-----|--------|
| `Space + g + g` | Lazygit (full TUI) |
| `Space + g + s` | Git status |
| `Space + g + b` | Git blame line |
| `] + h / [ + h` | Next / prev hunk |
| `Space + g + h + s` | Stage hunk |
| `Space + g + h + r` | Reset hunk |

### Harpoon
| Key | Action |
|-----|--------|
| `Space + h + a` | Add file to harpoon |
| `Space + h + h` | Harpoon quick menu |
| `Space + 1–4` | Jump to harpoon mark 1–4 |

### Copilot
| Key | Action |
|-----|--------|
| `Tab` | Accept suggestion |
| `Alt+]` | Next suggestion |
| `Alt+[` | Previous suggestion |
| `Space + a + c` | Open Copilot Chat |

---

## Zsh shell

### History search
| Key | Action |
|-----|--------|
| `Ctrl+R` | Atuin fzf history search (full TUI, tmux popup) |
| `↑ / ↓` | history-substring-search (prefix match) |
| `k / j` | Same as ↑/↓ in vi normal mode |

### Navigation
| Key | Action |
|-----|--------|
| `Ctrl+G` | navi interactive cheatsheet |
| `Ctrl+T` | fzf file picker |
| `Alt+C` | fzf cd into directory |
| `z <query>` | zoxide jump to frecent directory |
| `zi` | zoxide interactive jump (fzf) |
| `yy` | Open yazi; cd to directory on exit |

### Vi mode (zsh-vi-mode)
| Key | Action |
|-----|--------|
| `Esc` | Enter normal mode |
| `v` (normal) | Edit command in `$EDITOR` |
| `hjkl` (normal) | Move cursor |
| `w / b / e` | Word navigation |

---

## Hyprland — mod: `Super`

### Apps
| Key | Action |
|-----|--------|
| `Super + Return` | Terminal (Ghostty) |
| `Super + Space` | App launcher (wofi) |
| `Super + B` | Browser (Chrome) |
| `Super + F` | Yazi file manager |
| `Super + G` | Lazygit |
| `Super + Shift + D` | Lazydocker |
| `Super + period` | Clipboard history (cliphist) |

### Windows
| Key | Action |
|-----|--------|
| `Super + Shift + Q` | Close window |
| `Super + V` | Toggle floating |
| `Super + Z` | Toggle fullscreen |
| `Super + T` | Toggle split direction |
| `Super + P` | Toggle pseudo-tile |

### Focus & move (vim-style)
| Key | Action |
|-----|--------|
| `Super + h/j/k/l` | Move focus |
| `Super + Shift + h/j/k/l` | Move window |

### Workspaces
| Key | Action |
|-----|--------|
| `Super + 1–9` | Switch to workspace N |
| `Super + Shift + 1–9` | Move window to workspace N |
| `Super + S` | Toggle scratchpad |
| `Super + Shift + S` | Move to scratchpad |
| `Super + scroll` | Cycle workspaces |

### System
| Key | Action |
|-----|--------|
| `Super + Shift + X` | Lock screen (hyprlock) |
| `Super + M` | Exit Hyprland |
| `Print` | Full screenshot (grim) |
| `Shift + Print` | Region screenshot (slurp) |
| `Ctrl + Print` | Region screenshot → clipboard |

---

## Yazi — file manager

> Default navigation is full vim-style (`hjkl`, `/` to search, etc.)

### Custom bindings
| Key | Action |
|-----|--------|
| `g h` | Go to `~` |
| `g c` | Go to `~/.config` |
| `g d` | Go to `~/dotfiles` |
| `g C` | Go to `~/code` |
| `e` | Open with Neovim |
| `R` | Bulk rename in `$EDITOR` |

### Built-in
| Key | Action |
|-----|--------|
| `h/j/k/l` | Navigate |
| `Enter` | Open file |
| `Space` | Toggle select |
| `y` | Yank (copy) |
| `d` | Cut |
| `p` | Paste |
| `x` | Delete to trash |
| `r` | Rename |
| `/` | Search by name |
| `z` | Jump (zoxide) |
| `Z` | Jump interactive (zoxide + fzf) |
| `~` | Open shell in cwd |

---

## Lazygit

> Space to stage, Enter to drill in. Full vim navigation throughout.

| Key | Action |
|-----|--------|
| `1–5` | Switch panels (Status/Files/Branches/Commits/Stash) |
| `Space` | Stage / unstage file or hunk |
| `c` | Commit |
| `C` | Commit with editor |
| `P` | Push |
| `p` | Pull |
| `b` | Branch menu |
| `d` | Diff file |
| `e` | Edit file in `$EDITOR` |
| `z` | Undo last git action |
| `Ctrl+R` | Switch repo |
| `?` | Help (full keymap) |

---

## atuin — history search (`Ctrl+R`)

| Key | Action |
|-----|--------|
| `Ctrl+R` | Open search TUI |
| `Enter` | Execute selected command |
| `Tab` | Copy to prompt for editing |
| `Ctrl+D` | Delete entry |
| `Ctrl+R` (in TUI) | Cycle filter mode (global → host → session) |
| `Esc` | Exit / return original |

---

## Worktrunk — git worktrees (`wt`)

| Command | Action |
|---------|--------|
| `wt switch feat` | Switch to worktree for branch `feat` |
| `wt switch` | Interactive picker (fzf — live diff/log preview) |
| `wt switch -c feat` | Create branch + worktree, switch |
| `wt switch -c -x claude feat` | Create worktree, launch claude in it |
| `wt switch pr:123` | Check out PR #123 in its own worktree |
| `wt list` | Dashboard: all worktrees + status |
| `wt list --full` | Add CI status + AI summaries |
| `wt merge main` | Squash → rebase → merge → clean up |
| `wt remove` | Remove current worktree + branch |
| `wt step commit` | Stage all, generate LLM commit msg, commit |
| `wt hook <type>` | Run a hook manually |

