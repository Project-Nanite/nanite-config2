#!/bin/bash

# Build script for Nanite Branding Package
set -e

echo "Building Nanite Branding Package..."

# Set package directory
PACKAGE_DIR="nanite-branding"
PACKAGE_NAME="nanite-branding_1.0.0_all.deb"

# Check if we're in the right directory
if [ ! -d "$PACKAGE_DIR" ]; then
    echo "Error: Package directory not found!"
    exit 1
fi

# Build the package
echo "Creating .deb package..."
dpkg-deb --build "$PACKAGE_DIR"

# Check if build was successful
if [ -f "$PACKAGE_NAME" ]; then
    echo "Package built successfully: $PACKAGE_NAME"
    echo "Package size: $(du -h "$PACKAGE_NAME" | cut -f1)"
    
    # Show package contents
    echo -e "\nPackage contents:"
    dpkg-deb --contents "$PACKAGE_NAME"
    
    # Show package info
    echo -e "\nPackage information:"
    dpkg-deb --info "$PACKAGE_NAME"
    
    echo -e "\nPackage is ready for installation!"
    echo "To install: sudo dpkg -i $PACKAGE_NAME"
    echo "To fix dependencies: sudo apt-get install -f"
else
    echo "Error: Package build failed!"
    exit 1
fi
