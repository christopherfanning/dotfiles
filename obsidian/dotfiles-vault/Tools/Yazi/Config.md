# Yazi — Config Reference

> `yazi.toml` options explained. File: `src/yazi/dot-config/yazi/yazi.toml`

## Manager

| Option | Value | Effect |
|--------|-------|--------|
| `ratio` | `[1, 2, 4]` | Column width ratio: parent : current : preview |
| `sort_by` | `alphabetical` | Sort files by name |
| `sort_sensitive` | `true` | Case-sensitive sort (uppercase before lowercase) |
| `sort_reverse` | `false` | Ascending order |
| `sort_dir_first` | `true` | Directories listed before files |
| `show_hidden` | `false` | Hidden files off by default — toggle with `.` |
| `show_symlink` | `true` | Show symlink targets in status bar |

## Preview

| Option | Value | Effect |
|--------|-------|--------|
| `tab_size` | `2` | Tabs render as 2 spaces in previews |
| `max_width` | `600` | Max preview image width (px) |
| `max_height` | `900` | Max preview image height (px) |
| `wrap` | `no` | Don't wrap long text lines in preview |

## Openers

| Rule | Opens with |
|------|-----------|
| `text/*`, `application/json`, `*/xml` | Neovim (blocking) or `xdg-open` |
| `image/*`, `video/*`, `audio/*`, `application/pdf` | `xdg-open` |
| `*` (fallback) | `xdg-open` |

The `edit` opener uses `block = true` — Yazi waits for Neovim to close before resuming.

## Tasks

| Option | Value | Effect |
|--------|-------|--------|
| `micro_workers` | `10` | Concurrent small tasks (rename, etc.) |
| `macro_workers` | `25` | Concurrent large tasks (copy, move) |
| `image_alloc` | `512 MB` | Max memory for image decode |

## Shell wrapper (`yy`)

Defined in `.zshrc` — `yy` launches Yazi and `cd`s to the last directory on exit:

```zsh
yy   # navigate, then q → shell follows you there
```

Alias `y` opens plain Yazi (no cwd tracking).
