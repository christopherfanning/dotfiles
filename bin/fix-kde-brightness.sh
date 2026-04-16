#!/bin/bash
# Fix KDE powerdevil overriding external monitor brightness via DDC/CI.
#
# KDE's powerdevil sends brightness commands to all connected displays
# over DDC/CI (HDMI/DP), overriding OSD settings on external monitors.
# This script disables that behaviour via two belt-and-suspenders approaches:
#
#   1. POWERDEVIL_NO_DDCUTIL=1  — stops all DDC/CI communication entirely
#   2. powerdevilrc settings    — disables dim + profile-specific brightness
#
# Safe for laptop screens: internal eDP panels don't support DDC/CI and
# use the kernel backlight interface (amdgpu_bl1, intel_backlight) instead.
#
# Run once after a fresh install. Re-run after KDE updates if brightness
# control misbehaves again.

set -e

echo "==> Applying KDE powerdevil brightness fix..."

# ── 1. systemd drop-in: disable DDC/CI entirely ───────────────────────────
mkdir -p ~/.config/systemd/user/plasma-powerdevil.service.d/

cat > ~/.config/systemd/user/plasma-powerdevil.service.d/no-ddcutil.conf << 'EOF'
[Service]
Environment=POWERDEVIL_NO_DDCUTIL=1
EOF

echo "  Written: ~/.config/systemd/user/plasma-powerdevil.service.d/no-ddcutil.conf"

# ── 2. powerdevilrc: disable dim + profile brightness for all power states ─
POWERDEVILRC="$HOME/.config/powerdevilrc"

# Use kwriteconfig5 if available (cleanly edits KConfig files without
# clobbering existing sections), otherwise fall back to a full overwrite.
if command -v kwriteconfig5 &>/dev/null; then
  for profile in AC Battery LowBattery; do
    kwriteconfig5 --file powerdevilrc --group "$profile" --group "Display" \
      --key DimDisplay false
    kwriteconfig5 --file powerdevilrc --group "$profile" --group "Display" \
      --key UseProfileSpecificDisplayBrightness false
  done
  echo "  Updated: $POWERDEVILRC (via kwriteconfig5)"
else
  # Fallback: write the whole file (safe on a fresh install, may lose other settings)
  cat > "$POWERDEVILRC" << 'EOF'
[AC][Display]
DimDisplay=false
UseProfileSpecificDisplayBrightness=false

[Battery][Display]
DimDisplay=false
UseProfileSpecificDisplayBrightness=false

[LowBattery][Display]
DimDisplay=false
UseProfileSpecificDisplayBrightness=false
EOF
  echo "  Written: $POWERDEVILRC (fallback full-write)"
fi

# ── 3. Reload systemd + restart powerdevil ────────────────────────────────
systemctl --user daemon-reload
if systemctl --user is-active plasma-powerdevil &>/dev/null; then
  systemctl --user restart plasma-powerdevil
  echo "  Restarted plasma-powerdevil"
else
  echo "  plasma-powerdevil not running — fix will take effect on next login"
fi

echo ""
echo "✓ Done. External monitor brightness will no longer be overridden by KDE."
