# Yazi

> Blazing-fast terminal file manager written in Rust. Replaces Ranger.

## Why Yazi (over Ranger)

- **Performance**: Async architecture — previews render without blocking navigation
- **Modern previews**: Images, video thumbnails, PDFs, syntax-highlighted code out of the box
- **Vim keybindings**: Default navigation is `hjkl`, visual mode, etc.
- **Written in Rust**: Fast, low memory, no Python dependency

## Shell wrapper

The `yy` function in `.zshrc` changes your shell's working directory to wherever you quit Yazi — essential for actual workflow use:

```zsh
yy     # open yazi; cd to last location on exit
```

## Keybindings (custom additions)

| Key | Action |
|-----|--------|
| `gh` | Go to `~` |
| `gc` | Go to `~/.config` |
| `gd` | Go to `~/dotfiles` |
| `gC` | Go to `~/code` |
| `e` | Open in Neovim |
| `R` | Bulk rename in `$EDITOR` |

Default vim navigation (`hjkl`, `gg`, `G`, `v`, `y`, `p`, `d`) all work as expected.

## Theme

Catppuccin Mocha via `theme.toml`.
