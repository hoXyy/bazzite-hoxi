#!/bin/bash

set -ouex pipefail

echo "=== SETTING UP PACKAGES ==="

# Install a specific version of GRUB with the OOM fix
# It was rolled back due to issues with themes, but I don't use any so I don't care - I just want my OS to boot
# More info here: https://bugzilla.redhat.com/show_bug.cgi?id=2263643
dnf5 install -y koji
koji download-build --arch=x86_64 --arch=noarch grub2-2.12-55.fc44
dnf5 install -y ./*.rpm --allow-downgrade
dnf5 remove -y koji
rm ./*.rpm

# Install VSCode
dnf5 install --nogpgcheck --enable-repo="vscode" -y \
    code

# Install Docker
dnf5 install -y --enable-repo="docker-ce-stable" \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

# Install fonts
dnf5 install -y \
    source-foundry-hack-fonts \
    jetbrains-mono-fonts-all \
    powerline-fonts \
    rsms-inter-vf-fonts \
    jetbrains-mono-fonts \
    nerd-fonts \
    google-roboto-fonts \
    google-roboto-mono-fonts \
    google-roboto-slab-fonts

# Install OBS and plugins
dnf5 install -y \
    obs-studio \
    obs-studio-plugin-vkcapture \
    obs-studio-plugin-pwvideo \
    obs-studio-plugin-pipewire-audio-capture \
    obs-studio-plugin-wayland-hotkeys \
    obs-studio-plugin-text-pthread \
    obs-studio-plugin-tuna

# Install other packages
dnf5 install -y \
    btop \
    zsh \
    fzf \
    aria2 \
    neovim \
    openrgb \
    firefox

# Install packages from Terra
if [ -f /etc/yum.repos.d/terra.repo ]; then
    dnf5 install --from-repo=terra --setopt=install_weak_deps=False -y \
        ghostty \
        ghostty-zsh-completion \
        ghostty-terminfo \
        ghostty-shell-integration

    if [ "$VARIANT" = "gnome" ]; then
        dnf5 install --from-repo=terra --setopt=install_weak_deps=False -y \
        ghostty-nautilus
    fi
fi

