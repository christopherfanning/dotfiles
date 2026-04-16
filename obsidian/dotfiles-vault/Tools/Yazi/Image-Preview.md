# Yazi — Image Preview in tmux

> Yazi supports inline image preview inside tmux using the kitty graphics protocol or sixel, passed through via tmux's passthrough feature.

## Requirements

### tmux config

```tmux
set -g allow-passthrough on
```

This is set in `tmux.conf`. It allows escape sequences (including image data) to pass through tmux to the terminal.

### Terminal

Ghostty supports the kitty graphics protocol natively — no extra setup needed.

### Yazi

No special config needed — Yazi auto-detects the graphics protocol.

## How it works

```
Yazi → kitty graphics protocol escape sequence
     → tmux passes through (allow-passthrough on)
     → Ghostty renders the image inline
```

Without `allow-passthrough`, tmux strips the escape sequences and images show as blank.

## Troubleshooting

**Images show as blank / not rendering:**
1. Check `allow-passthrough` is set: `tmux show -g allow-passthrough`
2. Reload config: `prefix + r`
3. Check Ghostty supports kitty protocol (it does)

**Images render outside the pane boundary:**
This is a known limitation of the passthrough approach — the terminal renders at the cursor position, and tmux's coordinate system doesn't clip it perfectly. It's a cosmetic issue that resolves on the next redraw.

## Outside tmux

Yazi images work without any config in Ghostty directly (no tmux needed). The `allow-passthrough` config is only needed when running Yazi inside a tmux pane.
