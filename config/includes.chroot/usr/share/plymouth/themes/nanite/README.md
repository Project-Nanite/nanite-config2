# Nanite Plymouth Boot Animation

This is an animated Plymouth theme for Nanite Linux distribution using a 79-frame animation sequence.

## Files

- **nanite.plymouth** - Plymouth theme configuration
- **nanite.script** - Animation script (loops through 79 JPG frames)
- **ezgif-frame-001.jpg to ezgif-frame-079.jpg** - Animation frames
- **Old static assets** (optional, can be removed):
  - nanite-logo*.png
  - password-*.png
  - outline*.png

## Installation

### On Debian-based Systems:

1. Install the theme (automatically done by nanite-themes package):
   ```bash
   sudo cp -r share/plymouth/themes/nanite /usr/share/plymouth/themes/
   ```

2. Set as default Plymouth theme:
   ```bash
   sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/nanite/nanite.plymouth 100
   sudo update-alternatives --set default.plymouth /usr/share/plymouth/themes/nanite/nanite.plymouth
   ```

3. Update initramfs:
   ```bash
   sudo update-initramfs -u
   ```

### Testing:

Preview the theme without rebooting:
```bash
sudo plymouthd --debug --debug-file=/tmp/plymouth-debug.log
sudo plymouth --show-splash
# Press Ctrl+Alt+F1 to see it
# Then quit:
sudo plymouth quit
```

## Configuration

The animation loops continuously during boot. To change behavior:

1. **Speed**: Edit `nanite.script` line 9 - adjust `frameRate` value
2. **Tie to boot progress**: Uncomment line 62 in `nanite.script`
3. **Loop vs single play**: Modify `refreshCallback` function

## Frame Information

- Total Frames: 79
- Format: JPEG
- Naming: ezgif-frame-001.jpg to ezgif-frame-079.jpg
- Source: Converted from input.mp4

## Notes

- JPG frames are used for smaller size (vs PNG)
- Animation auto-loops during boot
- Password prompts appear as text overlay
- Black background (#000000)

