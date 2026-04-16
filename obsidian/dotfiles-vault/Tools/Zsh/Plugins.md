# Zsh — Plugin List

> Managed by Antidote. Source: `src/zsh/dot-zsh_plugins.txt`

Antidote reads this file and clones/sources each plugin on `antidote load`.

## Active plugins

| Plugin | What it does |
|--------|-------------|
| `zsh-users/zsh-completions` | Extra completions for hundreds of tools |
| `Aloxaf/fzf-tab` | Replaces default `<Tab>` menu with fzf popup (`kind:defer` = lazy load) |
| `sindresorhus/pure` | Minimal async prompt (loaded as fpath, P10k takes over) |
| `romkatv/powerlevel10k` | Full-featured prompt — git status, context, vi mode indicator |
| `mattmc3/zfunctions` | Autoloads functions from `~/.zfunctions/` |
| `zsh-users/zsh-autosuggestions` | Fish-style grey suggestions from history |
| `zdharma-continuum/fast-syntax-highlighting` | Syntax colours as you type (`kind:defer`) |
| `zsh-users/zsh-history-substring-search` | `↑/↓` searches history by prefix |
| `joshskidmore/zsh-fzf-history-search` | fzf `Ctrl+R` (overridden by atuin when present) |
| `jeffreytse/zsh-vi-mode` | Polished vi mode with text objects |

## `kind:` directives

| Directive | Meaning |
|-----------|---------|
| `kind:defer` | Load after prompt — keeps startup fast |
| `kind:fpath` | Add to `$fpath` only, don't source |

## Commented-out plugins

Several OMZ and zsh-utils plugins are commented out — they were evaluated but replaced by dedicated tools (atuin, fzf-tab, etc.).
