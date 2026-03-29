# Copilot Instructions — dotfiles

## What this repo is

Personal dotfiles for an Arch Linux developer workstation, managed with **GNU Stow**.
Config files live under `src/` and are symlinked to `~` on deployment.
`bin/` contains bootstrap scripts. `obsidian/` contains documentation.

---

## Stow conventions — the most important thing to understand

Every config lives under `src/<package>/` using the `dot-` prefix convention:

| Repo path | Symlinked to |
|-----------|-------------|
| `src/zsh/dot-zshrc` | `~/.zshrc` |
| `src/nvim/dot-config/nvim/init.lua` | `~/.config/nvim/init.lua` |
| `src/hyprland/dot-config/hypr/hyprland.conf` | `~/.config/hypr/hyprland.conf` |

Rules:
- **`dot-` prefix** maps to a leading `.` in the symlink name (Stow `--dotfiles` flag)
- **Mirror the path** from `~` downward inside the package directory
- **One package per tool** — never mix tools in the same `src/` subdirectory
- **Never use `ln -s`** — always use stow

Stow commands always run from the repo root with `-d src -t ~`:

```bash
# Dry run all packages (always do this first)
stow -nv --dotfiles -d src -t ~ $(ls src/)

# Apply all packages
stow --dotfiles -d src -t ~ $(ls src/)

# Single package
stow --dotfiles -d src -t ~ zsh

# Remove a package's symlinks
stow -D --dotfiles -d src -t ~ zsh
```

When stow reports conflicts, the `install.dotfiles.sh` script backs up conflicting real files as `<file>.bak` before stowing.

---

## Bootstrap flow

On a fresh machine:

1. `bash bin/arch-install.sh` — installs all packages (pacman + yay AUR)
2. `bash bin/install.dotfiles.sh` — installs antidote/TPM/NVM, stows all packages
3. `bash bin/setup-mcp.sh` — configures Claude Code MCP servers (set `GITHUB_TOKEN` + `BRAVE_API_KEY` first)

`install.dotfiles.sh` uses `cd "$(dirname "${BASH_SOURCE[0]}")/.."` to anchor itself to the repo root — always safe to call from any directory.

---

## Key conventions

### Package naming
- `src/shell/` — aliases only (sourced by `.zshrc`), not a tool config
- `src/zsh/` — zsh config files (`.zshrc`, `.zshenv`, `.zsh_plugins.txt`)
- `src/fonts/` — font directory (TTF/OTF files are gitignored, installed via pacman)

### Theme
Everything uses **Catppuccin Mocha**. When adding a new tool, look for a Catppuccin Mocha theme/plugin first.

### Aliases
All aliases live in `src/shell/dot-config/shell/aliases.sh`. Never add aliases directly to `.zshrc`. The file is sourced in `.zshrc` via:
```zsh
[[ -f "$HOME/.config/shell/aliases.sh" ]] && source "$HOME/.config/shell/aliases.sh"
```

### Zsh plugins
Plugin list is in `src/zsh/dot-zsh_plugins.txt` (antidote format). Antidote loads from either `/usr/share/zsh-antidote/antidote.zsh` (Arch package) or `~/.antidote/antidote.zsh` (git clone) — `.zshrc` checks both.

### EDITOR
Set in `src/zsh/dot-zshenv` (not `.zshrc`) so it applies to all zsh contexts including non-interactive (git commit, crontab, etc.).

### nvim
LazyVim install. Extras are controlled by `src/nvim/dot-config/nvim/lazyvim.json`. Custom plugins go in `src/nvim/dot-config/nvim/lua/plugins/`. `lazy-lock.json` is gitignored (machine-specific).

### tmux
TPM manages plugins. Plugin directories at `src/tmux/dot-config/tmux/plugins/` are gitignored — TPM installs them at runtime. Install plugins in a running tmux: `prefix + I`.

### Commit messages
Follow conventional commits: `feat:`, `fix:`, `chore:`, `docs:`. Always include the trailer:
```
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
```

---

## Gitignore gotchas

- `src/tmux/dot-config/tmux/plugins/` — TPM writes here at runtime, gitignored
- `src/nvim/dot-config/nvim/lazy-lock.json` — machine-specific, gitignored
- `src/fonts/fonts/*.ttf` / `*.otf` — binaries, gitignored (use `ttf-meslo-nerd` via pacman)
- `~/` — literal tilde directory created if install script is run from wrong directory
- `*.log` — apps (tmux, hyprland, kitty) write logs into config dirs after stow

---

## Documentation

`obsidian/dotfiles-vault/` is an Obsidian vault with docs for every tool. `Home.md` is the index. When adding a new tool, create a matching doc in `obsidian/dotfiles-vault/Tools/` and add it to `Home.md`.
Known-issue fixes live in `obsidian/dotfiles-vault/Fixes/`.

---

## Known fixes

### KDE overriding external monitor brightness

**`src/kde/dot-config/powerdevilrc`** — stowed to `~/.config/powerdevilrc`

KDE's powerdevil uses DDC/CI to send brightness commands to connected monitors via HDMI/DP, overriding OSD settings. Fix: set `DimDisplay=false` and `UseProfileSpecificDisplayBrightness=false` in every `[*][Display]` section of `powerdevilrc`. After stowing, run:

```bash
systemctl --user restart plasma-powerdevil
```

Full details: `obsidian/dotfiles-vault/Fixes/KDE-Monitor-Brightness.md`
