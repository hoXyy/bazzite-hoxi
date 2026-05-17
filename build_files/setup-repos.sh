#!/bin/bash

set -ouex pipefail

echo "=== SETTING UP REPOS ==="

# Disable terra-mesa repo to work around bootc-image-builder GPG file:// bug
if [ -f /etc/yum.repos.d/terra-mesa.repo ]; then
    sed -i 's/^enabled=1/enabled=0/' /etc/yum.repos.d/terra-mesa.repo
fi

if [ -f /etc/yum.repos.d/terra.repo ]; then
    # Disable metalink in favor of baseurl for reliability;
    # disable repo_gpgcheck to avoid key fetch failures at build time
    sed -i \
        -e 's/^metalink=/#metalink=/' \
        -e 's/^#baseurl=/baseurl=/' \
        -e 's/^repo_gpgcheck=.*/repo_gpgcheck=0/' \
        /etc/yum.repos.d/terra.repo
fi

# Add VSCode repo
dnf5 config-manager addrepo --set=baseurl="https://packages.microsoft.com/yumrepos/vscode" --id="vscode"
dnf5 config-manager setopt vscode.enabled=0
# FIXME: gpgcheck is broken for vscode due to it using `asc` for checking
# seems to be broken on newer rpm security policies.
dnf5 config-manager setopt vscode.gpgcheck=0

# Add Docker repo
dnf config-manager addrepo --from-repofile="https://download.docker.com/linux/fedora/docker-ce.repo"
dnf5 config-manager setopt docker-ce-stable.enabled=0

# Enable Nerd Fonts COPR
dnf5 -y copr enable che/nerd-fonts