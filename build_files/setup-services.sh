#!/bin/bash

set -ouex pipefail

echo "=== SETTING UP SERVICES ==="

systemctl enable docker.socket
systemctl enable podman.socket
systemctl enable bazzite-groups-setup.service