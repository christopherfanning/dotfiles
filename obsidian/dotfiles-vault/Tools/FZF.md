# FZF

> A general-purpose command-line fuzzy finder, written in Go.

## Why FZF

- **Universal**: Works with any list — files, history, processes, git branches, etc.
- **Fast**: Handles millions of lines without lag
- **Composable**: Pipe anything into it; get a selection back
- **Shell integration**: `Ctrl-R` history search, `Ctrl-T` file picker, `Alt-C` cd

## Shell Keybindings (enabled in `.zshrc`)

| Key | Action |
|-----|--------|
| `Ctrl-R` | Fuzzy search shell history |
| `Ctrl-T` | Fuzzy insert file path at cursor |
| `Alt-C` | Fuzzy `cd` into a directory |

Sourced from the system fzf package:

```zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
```

## fzf-tab

The `Aloxaf/fzf-tab` zsh plugin replaces the default tab-completion menu with an fzf picker — every `<Tab>` becomes a fuzzy search.
