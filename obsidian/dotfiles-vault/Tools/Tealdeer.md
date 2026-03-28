# Tealdeer

> A fast `tldr` client written in Rust. Preferred over the Node-based `tldr` package.

## Why Tealdeer (over `tldr` npm / `tldr-pages`)

- **Fast**: Native binary — no Node.js startup cost, instant results
- **Offline**: Pages are cached locally after `tldr --update`
- **Same pages**: Uses the same community-maintained [tldr-pages](https://github.com/tldr-pages/tldr) content
- **No downsides**: Drop-in replacement; the binary is still called `tldr`

## Usage

```bash
tldr tar          # quick examples for tar
tldr git commit   # multi-word commands work too
tldr --update     # refresh the local cache
tldr --list       # list all available pages
```

## Install (Arch)

```bash
# Remove the conflicting 'tldr' package if present
sudo pacman -Rs tldr

# Install tealdeer (binary is still called tldr)
sudo pacman -S tealdeer
tldr --update             # fetch pages on first run
```

## Alias

```zsh
alias help='tldr'   # optional friendlier name
```
