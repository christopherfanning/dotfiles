# KDE Monitor Brightness Fix

## The Problem

KDE's power management daemon (**powerdevil**) uses **DDC/CI** (Display Data Channel Command Interface) to send brightness commands directly to connected monitors via HDMI/DisplayPort. This causes:

- External monitor brightness being reset every time you unlock the screen
- Monitor brightness changing when waking from suspend
- KDE overriding manual brightness adjustments made via the monitor's OSD buttons
- Brightness flickering or snapping to a saved value on profile change

This is particularly noticeable on monitors connected via DisplayPort where DDC/CI is fully active.

## The Fix

### 1. Config file (dotfiles-managed)

`src/kde/dot-config/powerdevilrc` — stowed to `~/.config/powerdevilrc`

Add `DimDisplay=false` and `UseProfileSpecificDisplayBrightness=false` to every `[*][Display]` section:

```ini
[AC][Display]
TurnOffDisplayIdleTimeoutSec=1800
DimDisplay=false
UseProfileSpecificDisplayBrightness=false

[Battery][Display]
DimDisplay=false
UseProfileSpecificDisplayBrightness=false

[LowBattery][Display]
DimDisplay=false
UseProfileSpecificDisplayBrightness=false
```

After stowing, restart powerdevil (or reboot):

```bash
systemctl --user restart plasma-powerdevil
```

### 2. GUI equivalent

**System Settings → Power Management → Energy Saving**

Under each profile tab (On AC Power, On Battery, On Low Battery):
- Uncheck **"Dim screen"**
- Optionally: uncheck **"Change screen brightness"** and remove any saved brightness value

This writes the same keys to `~/.config/powerdevilrc`.

## Why this happens

KDE's powerdevil has a "display brightness management" feature intended for laptop backlight control. On desktops (or when a laptop is docked with external monitors), it extends this to connected monitors via DDC/CI — the protocol that lets software control monitor OSD settings. Most external monitors support DDC/CI, so KDE happily overrides whatever the monitor has set.

## Stow this package

```bash
stow --dotfiles -d src -t ~ kde
```

> **Note:** Plasma reads `powerdevilrc` at session startup. You'll need to log out/in or restart the daemon for changes to take effect.

## Related

- [[Hyprland]] — if you switch to Hyprland full-time, powerdevil is not running and this issue disappears entirely
- KDE does not ship a per-monitor DDC/CI disable toggle; the only controls are the global `DimDisplay` and `UseProfileSpecificDisplayBrightness` flags
