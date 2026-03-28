# Ghostty — Remote Terminal Type Error

## Problem

When SSH-ing into a remote server and running `htop`, `man`, or other ncurses programs you see:

```
Error opening terminal: xterm-ghostty.
```

or

```
'xterm-ghostty': unknown terminal type.
```

This happens because Ghostty sets `TERM=xterm-ghostty` by default. Most remote servers don't have the `xterm-ghostty` entry in their terminfo database, so ncurses can't describe the terminal's capabilities.

## Fix (applied in dotfiles)

In `~/.config/ghostty/config`:

```
term = xterm-256color
```

This makes Ghostty advertise itself as `xterm-256color`, which every server already has in its terminfo database. You lose none of the functionality that matters in practice.

## Alternative: Copy terminfo to remote

If you *want* to keep `TERM=xterm-ghostty` locally (e.g. for full Ghostty-specific features), you can push the terminfo entry to the remote server:

```bash
infocmp -x | ssh user@remote-server -- 'mkdir -p ~/.terminfo && tic -x -'
```

Run this once per remote server. After that, `htop` and friends will work over SSH without changing your local `TERM`.

## Why `xterm-256color` is the right default for dotfiles

- Works on every Linux/macOS server out of the box
- Supports 256 colours and true colour (via `COLORTERM=truecolor`)
- No maintenance burden when SSHing to new machines
