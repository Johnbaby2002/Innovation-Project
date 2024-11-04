# Dockerfile - create this using your text editor
FROM nixos/nix:latest

# Install essential build dependencies first
RUN nix-env -iA \
    nixpkgs.git \
    nixpkgs.curl \
    nixpkgs.sudo \
    nixpkgs.bash \
    nixpkgs.coreutils

# Setup Nix configuration
RUN mkdir -p /etc/nix && \
    echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf

# Setup working directory
WORKDIR /app

# Install devenv using nix profile
RUN . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh && \
    nix profile install --accept-flake-config github:cachix/devenv
