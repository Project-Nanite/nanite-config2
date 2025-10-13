# Nanite Branding Package Installation Guide

## Overview
This package automatically changes your Debian XFCE distribution logo and wallpaper to the Nanite branding.

## Package Contents
- **Custom Nanite Wallpaper**: A beautiful geometric bee design
- **Distribution Logo**: Nanite logo that replaces Debian branding
- **XFCE Configuration**: Automatic desktop setup for new and existing users

## Installation

### Method 1: Direct Installation
```bash
# Navigate to the packages directory
cd packages

# Install the package
sudo dpkg -i nanite-branding.deb

# Fix any dependency issues (if needed)
sudo apt-get install -f
```

### Method 2: Using apt (if available)
```bash
# If you have the package in a repository
sudo apt update
sudo apt install nanite-branding
```

## What Happens During Installation

1. **Backup**: Existing branding files are automatically backed up
2. **Logo Replacement**: Debian logos are replaced with Nanite branding
3. **Wallpaper Setup**: The geometric bee wallpaper is set as default
4. **User Configuration**: Both new and existing users get the new branding

## Post-Installation

### For New Users
- New user accounts will automatically get the Nanite branding
- Wallpaper and logo will be applied immediately

### For Existing Users
- Existing users may need to log out and log back in
- Or restart the XFCE desktop session
- The wallpaper should update automatically

## Verification

After installation, you should see:
- New wallpaper on your desktop
- Nanite branding in system dialogs
- Updated distribution information

## Troubleshooting

### Wallpaper Not Changed
```bash
# Force wallpaper update
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace0/picture-uri -s "file:///usr/share/backgrounds/nanite/wallpaper.png"
```

### Logo Not Updated
```bash
# Check if logo files exist
ls -la /usr/share/pixmaps/distributor-logo.png
ls -la /usr/share/plymouth/debian-logo.png
```

### Manual Wallpaper Change
1. Right-click on desktop
2. Select "Desktop Settings"
3. Choose "Background" tab
4. Select the Nanite wallpaper from `/usr/share/backgrounds/nanite/`

## Package Removal

To remove the package and restore Debian branding:
```bash
sudo apt remove nanite-branding
# or
sudo dpkg -r nanite-branding
```

## Package Information

- **Package Name**: nanite-branding
- **Version**: 1.0.0
- **Architecture**: all
- **Dependencies**: xfce4-settings, xfdesktop4
- **Size**: ~177 KB

## Support

For issues or questions:
- Check the package README at `/usr/share/nanite-branding/README`
- Review package logs: `dpkg -L nanite-branding`
- Contact the Nanite development team

## Files Installed

- `/usr/share/backgrounds/nanite/wallpaper.png` - Main wallpaper
- `/usr/share/pixmaps/distributor-logo.png` - Distribution logo
- `/etc/skel/.config/xfce4/...` - Default user configuration
- Various system branding replacements

## Security Note

This package requires root privileges to install as it modifies system-wide branding files. The package is designed to be safe and only modifies branding-related files.
