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
