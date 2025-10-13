# Use Debian as base
FROM debian:latest

# Install useful tools
RUN apt-get update && apt-get install -y \
    bash \
    sudo \
    vim \
    git \
    live-build \
    debootstrap \
    syslinux \
    squashfs-tools \
    xorriso \
    isolinux \
    mtools -y
 
# Set working directory
WORKDIR /home/Nanite-configs
