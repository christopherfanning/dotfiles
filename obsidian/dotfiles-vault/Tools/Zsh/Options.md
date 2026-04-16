# Zsh — Options Reference

> `setopt` / `unsetopt` flags in `.zshrc`. These change how zsh behaves.

## Set options

| Option | Effect |
|--------|--------|
| `EXTENDED_HISTORY` | Each history entry includes timestamp and duration |
| `INC_APPEND_HISTORY_TIME` | Write to `HISTFILE` immediately after each command completes |
| `HIST_IGNORE_ALL_DUPS` | When a duplicate is added, remove the earlier copy |
| `HIST_SAVE_NO_DUPS` | Never write duplicate lines to the history file |
| `HIST_REDUCE_BLANKS` | Strip superfluous whitespace from history entries |
| `HIST_VERIFY` | Show `!` expansion before executing it |
| `extendedglob` | Enable `#`, `~`, `^` as glob operators |
| `notify` | Report background job status immediately |
| `NO_NOMATCH` | Unmatched globs pass through literally (bash default — fixes rsync remote paths) |

## Unset options

| Option | Why unset |
|--------|-----------|
| `beep` | Terminal bell is annoying |

## `WORDCHARS`

```zsh
WORDCHARS=${WORDCHARS//[\/]}
```

Removes `/` from word characters — `Ctrl+W` stops at directory separators instead of eating the whole path.

## Why `NO_NOMATCH`?

Without this, `rsync host:/path/prefix*` fails with "no matches found" because zsh tries to expand the glob locally. With `NO_NOMATCH`, unmatched globs pass through to the command, which is the correct behaviour for remote paths.

`NULL_GLOB` (removes unmatched globs) is **not** used — it's dangerous: `rm *.bak` with no matches becomes bare `rm`.
