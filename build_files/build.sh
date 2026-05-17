#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1
# Disable terra-mesa repo to work around bootc-image-builder GPG file:// bug
if [ -f /etc/yum.repos.d/terra-mesa.repo ]; then
    sed -i 's/^enabled=1/enabled=0/' /etc/yum.repos.d/terra-mesa.repo
fi

# this installs a package from fedora repos
# dnf5 install -y tmux 

# Install a specific version of GRUB with the OOM fix
# It was rolled back due to issues with themes, but I don't use any so I don't care - I just want my OS to boot
# More info here: https://bugzilla.redhat.com/show_bug.cgi?id=2263643
dnf5 install -y koji
koji download-build --arch=x86_64 --arch=noarch grub2-2.12-55.fc44
dnf5 install -y ./*.rpm --allow-downgrade
dnf5 remove -y koji

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

# systemctl enable podman.socket
