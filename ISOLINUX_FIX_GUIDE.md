# ISOLINUX Boot Fix Guide

If you want to use ISOLINUX instead of GRUB, follow these steps:

## 1. Update Binary Configuration
In `config/binary`, change:
```
LB_BOOTLOADER_BIOS="isolinux"
LB_BOOTLOADERS="isolinux"
```

## 2. Install Required ISOLINUX Files
The following files need to be copied to `config/bootloaders/isolinux/`:

### From syslinux package:
- `isolinux.bin` 
- `menu.c32`
- `vesamenu.c32`
- `ldlinux.c32`
- `libcom32.c32`
- `libutil.c32`

### Installation Commands:
```bash
# Install syslinux package
sudo apt install syslinux-utils

# Copy required files
cp /usr/lib/syslinux/modules/bios/isolinux.bin config/bootloaders/isolinux/
cp /usr/lib/syslinux/modules/bios/menu.c32 config/bootloaders/isolinux/
cp /usr/lib/syslinux/modules/bios/vesamenu.c32 config/bootloaders/isolinux/
cp /usr/lib/syslinux/modules/bios/ldlinux.c32 config/bootloaders/isolinux/
cp /usr/lib/syslinux/modules/bios/libcom32.c32 config/bootloaders/isolinux/
cp /usr/lib/syslinux/modules/bios/libutil.c32 config/bootloaders/isolinux/
```

## 3. Create Missing Configuration Files
Create `config/bootloaders/isolinux/advanced.cfg` and `config/bootloaders/isolinux/utilities.cfg`

## 4. Fix isolinux.cfg
Add UI directive at the top:
```
UI vesamenu.c32
```

## Note: GRUB is Recommended
GRUB provides better UEFI support and is more reliable for modern systems.
