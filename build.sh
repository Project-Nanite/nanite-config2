#!/bin/bash

# Live-build Build Script
# This script runs lb config and lb build commands

set -e  # Exit on any error

echo "======================================="
echo "Live-build Build Script"
echo "======================================="
echo

# Function to print colored output
print_status() {
    echo -e "\033[1;34m[INFO]\033[0m $1"
}

print_success() {
    echo -e "\033[1;32m[SUCCESS]\033[0m $1"
}

print_error() {
    echo -e "\033[1;31m[ERROR]\033[0m $1"
}

# Check if lb command is available
if ! command -v lb &> /dev/null; then
    print_status "live-build (lb) command not found. Installing live-build package..."
    
    # Check if running as root or with sudo
    if [[ $EUID -ne 0 ]]; then
        print_status "Installing live-build with sudo..."
        if sudo apt update && sudo apt install -y live-build debootstrap curl wget xorriso syslinux squashfs-tools genisoimage; then
            print_success "live-build installed successfully!"
        else
            print_error "Failed to install live-build. Please run: sudo apt install live-build"
            exit 1
        fi
    else
        print_status "Installing live-build as root..."
        if apt update && apt install -y live-build; then
            print_success "live-build installed successfully!"
        else
            print_error "Failed to install live-build."
            exit 1
        fi
    fi
fi

# Start time
start_time=$(date +%s)

print_status "Starting live-build configuration..."
echo

# Run lb config
if lb config; then
    print_success "Configuration completed successfully!"
else
    print_error "Configuration failed!"
    exit 1
fi

echo
print_status "Starting live-build build process..."
echo

# Run lb build
if lb build; then
    print_success "Build completed successfully!"
else
    print_error "Build failed!"
    exit 1
fi

# End time and duration
end_time=$(date +%s)
duration=$((end_time - start_time))
minutes=$((duration / 60))
seconds=$((duration % 60))

echo
echo "======================================="
print_success "Build process completed!"
echo "Total time: ${minutes}m ${seconds}s"
echo "======================================="

# Show generated files
echo
print_status "Generated files:"
ls -lh *.iso *.img *.zsync 2>/dev/null || echo "No ISO/IMG files found"

echo
print_status "Build artifacts location: $(pwd)" 