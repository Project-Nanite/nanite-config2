# Nanite Cyber Theme

A cyberpunk-inspired XFCE theme with modern design elements and neon accents.

## Features

- **Dark Cyberpunk Color Scheme**: Deep blacks with neon cyan (#00ffff) and blue (#00bfff) accents
- **Modern Typography**: Ubuntu Mono and Roboto Mono fonts for a techy feel
- **Glowing Effects**: Text shadows and box shadows with neon glow effects
- **Transparent Elements**: Semi-transparent panels and terminal backgrounds
- **Custom Window Decorations**: XFWM4 theme with cyberpunk styling
- **Themed Applications**: Terminal, panel, and menu customizations

## Color Palette

- **Primary Background**: #0a0a0a (Deep Black)
- **Secondary Background**: #1a1a1a (Dark Gray)
- **Accent Color**: #00ffff (Neon Cyan)
- **Secondary Accent**: #00bfff (Bright Blue)
- **Text Color**: #c9d1d9 (Light Gray)
- **Selection**: #00d4ff (Bright Cyan)
- **Error**: #ff4444 (Red)
- **Warning**: #ffcc00 (Yellow)
- **Success**: #00ff88 (Green)

## Components

### GTK Theme
- GTK3 and GTK4 support
- Dark theme with neon accents
- Custom button, entry, and menu styling
- Glowing hover effects

### Window Manager (XFWM4)
- Custom title bars with cyberpunk colors
- Transparent window effects
- Modern button layout (O|HMC)
- Shadow effects for depth

### Panel Configuration
- Dark transparent panel background
- Neon cyan border
- Custom Whisker menu with Nanite branding
- Optimized layout with separators

### Terminal Theme
- Semi-transparent background
- Neon cyan text and cursor
- Cyberpunk color palette
- Ubuntu Mono font for readability

## Installation

The theme is automatically installed during the live-build process via the hook script:
`config/hooks/live/0060-nanite-cyber-theme.hook.chroot`

## Manual Installation

1. Copy theme to system themes directory:
   ```bash
   sudo cp -r nanite-cyber /usr/share/themes/
   ```

2. Install required fonts:
   ```bash
   sudo apt install fonts-ubuntu fonts-roboto-mono fonts-noto-mono
   ```

3. Apply theme via XFCE Settings or manually copy configurations

## Customization

### Adding Custom Wallpapers
Place wallpapers in `/usr/share/backgrounds/` with cyberpunk themes:
- Matrix-style falling code
- Neon cityscapes
- Abstract geometric patterns
- Technology/circuit board designs

### Icon Theme Recommendation
- **Papirus-Dark**: Dark icons that complement the theme
- **Numix-Circle**: Circular icons with dark variants
- **Tela-dark**: Modern flat icons

### Font Alternatives
- **Fira Code**: Programming font with ligatures
- **Source Code Pro**: Adobe's monospace font
- **JetBrains Mono**: Modern programming font

## Theme Philosophy

The Nanite Cyber theme embodies the cyberpunk aesthetic while maintaining usability:

1. **Dark Foundation**: Reduces eye strain in low-light environments
2. **Neon Accents**: Provides visual hierarchy and futuristic feel
3. **Monospace Typography**: Reinforces the technical/programming aesthetic
4. **Transparency**: Adds depth and modernity
5. **Minimal Distractions**: Clean interface that stays out of the way

## Compatibility

- **XFCE 4.16+**: Full compatibility
- **GTK 3.24+**: Complete theme support
- **GTK 4.0+**: Modern application support
- **Applications**: Firefox, Thunar, Terminal, Settings, etc.

## Contributing

To enhance the theme:
1. Modify CSS files in `gtk-3.0/` or `gtk-4.0/`
2. Update XFWM4 theme in `xfwm4/themerc`
3. Adjust panel configuration in `panel/`
4. Test changes before committing

## Credits

Created for Nanite Linux distribution with inspiration from:
- Cyberpunk 2077 aesthetic
- Matrix digital rain
- Neon-lit cityscapes
- Modern flat design principles 