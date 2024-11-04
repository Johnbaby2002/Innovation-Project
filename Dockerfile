# Dockerfile - create this using your text editor
FROM nixos/nix:latest

# Install essential build dependencies first
RUN nix-env -iA \
    nixpkgs.git \
    nixpkgs.curl \
    nixpkgs.sudo \
    nixpkgs.bash \
    nixpkgs.coreutils \
    nixpkgs.which

# Setup Nix configuration
RUN mkdir -p /etc/nix && \
    echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf

# Create a non-root user for Homebrew
RUN useradd -m -s /bin/bash linuxbrew && \
    echo "linuxbrew ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the non-root user
USER linuxbrew
WORKDIR /home/linuxbrew
