# Dockerfile - create this using your text editor
FROM nixos/nix:latest

# Install essential build dependencies
RUN nix-env -iA \
    nixpkgs.git \
    nixpkgs.curl \
    nixpkgs.sudo \
    nixpkgs.bash \
    nixpkgs.coreutils \
    nixpkgs.which \
    nixpkgs.makeWrapper

# Setup Nix configuration
RUN mkdir -p /etc/nix && \
    echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf

# Create necessary directories and set permissions
RUN mkdir -p /home/linuxbrew/.linuxbrew && \
    chmod -R 755 /home/linuxbrew && \
    chown -R root:root /home/linuxbrew
