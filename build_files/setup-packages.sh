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

# Install packages
dnf5 install -y \
    btop \
    source-foundry-hack-fonts \
    jetbrains-mono-fonts-all \
    powerline-fonts \
    rsms-inter-vf-fonts \
    zsh

if [ -f /etc/yum.repos.d/terra.repo ]; then
dnf5 install --from-repo=terra --setopt=install_weak_deps=False -y \
    ghostty \
    ghostty-zsh-completion \
    ghostty-terminfo \
    ghostty-shell-integration
fi

