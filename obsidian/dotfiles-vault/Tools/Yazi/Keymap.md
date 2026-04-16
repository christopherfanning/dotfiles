# Yazi — Keymap

> Custom keybinds on top of Yazi's vim-style defaults. File: `src/yazi/dot-config/yazi/keymap.toml`

## Default navigation (built-in, vim-style)

| Key | Action |
|-----|--------|
| `h` | Go to parent directory |
| `l` or `Enter` | Open / enter directory |
| `j / k` | Move down / up |
| `g g` | Jump to top |
| `G` | Jump to bottom |
| `Space` | Toggle selection |
| `y` | Yank (copy) |
| `d` | Cut |
| `p` | Paste |
| `r` | Rename |
| `.` | Toggle hidden files |
| `q` | Quit |

## Custom binds (from `keymap.toml`)

### Quick navigation (`g` prefix)

| Key | Destination |
|-----|------------|
| `g h` | `~` (home) |
| `g c` | `~/.config` |
| `g d` | `~/dotfiles` |
| `g C` | `~/code` |

### File operations

| Key | Action |
|-----|--------|
| `R` | Bulk rename — opens all selected filenames in `$EDITOR` (Neovim) |
| `e` | Open file with Neovim directly |

## Adding more binds

Edit `src/yazi/dot-config/yazi/keymap.toml`:

```toml
[manager]
keymap = [
  { on = ["g", "x"], run = "cd ~/your/path", desc = "Go to your path" },
]
```
