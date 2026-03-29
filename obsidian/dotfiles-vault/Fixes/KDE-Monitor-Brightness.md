# KDE Monitor Brightness Fix

## The Problem

KDE's power management daemon (**powerdevil**) uses **DDC/CI** (Display Data Channel Command Interface) to send brightness commands directly to connected monitors via HDMI/DisplayPort. This causes:

- External monitor brightness being reset every time you unlock the screen
- Monitor brightness changing when waking from suspend
- KDE overriding manual brightness adjustments made via the monitor's OSD buttons

## Does this affect laptop screen brightness?

**No.** Laptop backlight and external monitor DDC/CI are completely separate mechanisms:

| Display | Control method | Affected by fix? |
|---------|---------------|-----------------|
| Internal laptop screen (eDP) | Kernel driver (`amdgpu_bl1`) via `/sys/class/backlight/` | ❌ No |
| External monitor (HDMI/DP) | DDC/CI over I²C via `ddcutil` | ✅ Yes — this is what we disable |

Hardware confirmation (`ddcutil detect` on this machine):

```
Laptop display (eDP-1 / JDI GPD1001H):
  → "This is a laptop display. Laptop displays do not support DDC/CI."

External monitor (DP-2 / D1):
  → Full DDC/CI capable — this is what powerdevil was controlling
```

Fn+brightness keys and the KDE brightness slider continue to work normally on the laptop screen.

## The Fix — `POWERDEVIL_NO_DDCUTIL=1` (preferred)

A **systemd user service drop-in** tells powerdevil to skip DDC/CI entirely.

Managed by stow: `src/kde/dot-config/systemd/user/plasma-powerdevil.service.d/no-ddcutil.conf`

```ini
[Service]
Environment=POWERDEVIL_NO_DDCUTIL=1
```

To apply:

```bash
stow --dotfiles -d src -t ~ kde
systemctl --user daemon-reload
systemctl --user restart plasma-powerdevil.service

# Verify:
systemctl --user show plasma-powerdevil.service --property=Environment
# → Environment=POWERDEVIL_NO_DDCUTIL=1
```

## Belt-and-suspenders — `powerdevilrc` config

`src/kde/dot-config/powerdevilrc` also sets `DimDisplay=false` and `UseProfileSpecificDisplayBrightness=false` across all power profiles. Both are stowed together under the `kde` package.

## Why this happens

KDE's powerdevil was designed for laptop backlight control. On desktops (or docked laptops), it extends this to connected monitors via **ddcutil** — the protocol that lets software control monitor OSD settings over I²C. Most monitors support DDC/CI over HDMI/DP, so KDE happily overrides whatever the monitor has set.

## Related

- [[Hyprland]] — if you switch to Hyprland full-time, powerdevil is not running and this issue disappears entirely
