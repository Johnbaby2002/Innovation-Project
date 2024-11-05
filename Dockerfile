# Dockerfile - create this using your text editor
FROM nixos/nix:latest

# Enable experimental features for better Nix experience
ENV NIX_CONFIG="experimental-features = nix-command flakes"

# Install system dependencies through Nix
RUN nix-env -iA \
    nixpkgs.curl \
    nixpkgs.git \
    nixpkgs.bash \
    nixpkgs.coreutils \
    nixpkgs.findutils \
    nixpkgs.gnumake \
    nixpkgs.gcc \
    nixpkgs.glibc \
    nixpkgs.sudo \
    nixpkgs.util-linux

# Create a non-root user
RUN useradd -m -s /bin/bash brewuser && \
    echo 'brewuser ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

# Switch to the non-root user
USER brewuser
WORKDIR /home/brewuser

# Set up necessary environment variables
ENV PATH="/home/brewuser/.linuxbrew/bin:${PATH}"
ENV HOMEBREW_PREFIX="/home/brewuser/.linuxbrew"
ENV HOMEBREW_CELLAR="/home/brewuser/.linuxbrew/Cellar"
ENV HOMEBREW_REPOSITORY="/home/brewuser/.linuxbrew/Homebrew"
ENV HOMEBREW_NO_AUTO_UPDATE=1

# Install Homebrew
RUN git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew \
    && mkdir ~/.linuxbrew/bin \
    && ln -s ~/.linuxbrew/Homebrew/bin/brew ~/.linuxbrew/bin \
    && eval $(~/.linuxbrew/bin/brew shellenv)

# Verify the installation
RUN brew --version

# Set default command
CMD ["/bin/bash"]
