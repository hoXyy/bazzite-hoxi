#!/bin/bash

set -ouex pipefail

echo "=== CLEANUP ==="

# Clean up /boot left by grub postinstall scripts
rm -rf /boot/*

# Clean up bootc lint warnings
rm -rf /var/lib/dnf
rm -rf /run/dnf