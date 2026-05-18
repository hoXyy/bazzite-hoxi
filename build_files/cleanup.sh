#!/bin/bash

set -ouex pipefail

echo "=== CLEANUP ==="

# Clean up /boot left by grub postinstall scripts
rm -rf /boot/*

# Clean up bootc lint warnings
rm -rf /var/lib/dnf
rm -rf /run/dnf

# Clean temp files
rm -rf /tmp/*

# Disable COPRs
dnf5 -y copr disable che/nerd-fonts
dnf5 -y copr disable tarulia/obs-studio-plugins

# Clean package manager cache
dnf5 clean all