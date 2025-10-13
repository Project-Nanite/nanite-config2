#!/bin/bash

# Test script for Nanite Branding Package
echo "=== Nanite Branding Package Test ==="

# Check if package is installed
if dpkg -l | grep -q "nanite-branding"; then
    echo "✓ Package is installed"
else
    echo "✗ Package is not installed"
    exit 1
fi

# Check if files exist
echo -e "\n=== Checking Installed Files ==="

WALLPAPER="/usr/share/backgrounds/nanite/wallpaper.png"
LOGO="/usr/share/pixmaps/distributor-logo.png"
SKEL_CONFIG="/etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml"

if [ -f "$WALLPAPER" ]; then
    echo "✓ Wallpaper exists: $WALLPAPER"
    echo "  Size: $(du -h "$WALLPAPER" | cut -f1)"
else
    echo "✗ Wallpaper missing: $WALLPAPER"
fi

if [ -f "$LOGO" ]; then
    echo "✓ Logo exists: $LOGO"
    echo "  Size: $(du -h "$LOGO" | cut -f1)"
else
    echo "✗ Logo missing: $LOGO"
fi

if [ -f "$SKEL_CONFIG" ]; then
    echo "✓ Default user config exists: $SKEL_CONFIG"
else
    echo "✗ Default user config missing: $SKEL_CONFIG"
fi

# Check current user's wallpaper
echo -e "\n=== Current User Configuration ==="
if [ -n "$DISPLAY" ]; then
    CURRENT_WALLPAPER=$(xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace0/picture-uri 2>/dev/null || echo "Not set")
    echo "Current wallpaper: $CURRENT_WALLPAPER"
    
    if [[ "$CURRENT_WALLPAPER" == *"nanite"* ]]; then
        echo "✓ Wallpaper is set to Nanite branding"
    else
        echo "⚠ Wallpaper may not be set to Nanite branding"
        echo "  Try logging out and back in, or manually set it"
    fi
else
    echo "⚠ No display detected, cannot check current wallpaper"
fi

# Check package dependencies
echo -e "\n=== Package Dependencies ==="
DEPS=$(dpkg -s nanite-branding | grep "Depends" | cut -d: -f2 | tr -d ' ')
echo "Dependencies: $DEPS"

for dep in $DEPS; do
    if dpkg -l | grep -q "^ii.*$dep"; then
        echo "  ✓ $dep is installed"
    else
        echo "  ✗ $dep is missing"
    fi
done

echo -e "\n=== Test Complete ==="
echo "If all checks pass, your Nanite branding should be working!"
echo "For new users, the branding will be applied automatically."
echo "For existing users, you may need to log out and back in."
