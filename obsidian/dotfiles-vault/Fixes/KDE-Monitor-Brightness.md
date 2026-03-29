# KDE Monitor Brightness Fix

## The Problem

KDE's power management daemon (**powerdevil**) uses **DDC/CI** (Display Data Channel Command Interface) to send brightness commands directly to connected monitors via HDMI/DisplayPort. This causes:

- External monitor brightness being reset every time you unlock the screen
- Monitor brightness changing when waking from suspend
- KDE overriding manual brightness adjustments made via the monitor's OSD buttons
- Brightness flickering or snapping to a saved value on profile change

## The Fix — `POWERDEVIL_NO_DDCUTIL=1` (preferred)

The cleanest fix is a **systemd user service drop-in** that sets an environment variable telling powerdevil to skip DDC/CI entirely.

Managed by stow: `src/kde/dot-config/systemd/user/plasma-powerdevil.service.d/no-ddcutil.conf`

```ini
[Service]
Environment=POWERDEVIL_NO_DDCUTIL=1
```

This is more targeted than disabling dim/brightness config settings — it stops powerdevil from even attempting to talk to monitors over DDC/CI.

To apply after stowing:

```bash
systemctl --user daemon-reload
systemctl --user restart plasma-powerdevil.service

# Verify it's active:
systemctl --user show plasma-powerdevil.service --property=Environment
# → Environment=POWERDEVIL_NO_DDCUTIL=1
```

## Belt-and-suspenders — `powerdevilrc` config

`src/kde/dot-config/powerdevilrc` also sets `DimDisplay=false` and `UseProfileSpecificDisplayBrightness=false` across all power profiles as a secondary guard. Both files are stowed together under the `kde` package:

```bash
stow --dotfiles -d src -t ~ kde
```

## Why this happens

KDE's powerdevil has a "display brightness management" feature intended for laptop backlight control. On desktops (or docked laptops with external monitors), it extends this to connected monitors via **ddcutil** — the protocol that lets software control monitor OSD settings. Most monitors support DDC/CI over HDMI/DP, so KDE happily overrides whatever the monitor has set.

## Related

- [[Hyprland]] — if you switch to Hyprland full-time, powerdevil is not running and this issue disappears entirely


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
