# Install all curated apps
bazzite-hoxi-install: bazzite-hoxi-install-flatpaks

# Install only Flatpaks
bazzite-hoxi-install-flatpaks:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "Installing Flatpaks..."
    xargs -a <(curl --retry 3 -sL https://raw.githubusercontent.com/hoXyy/bazzite-hoxi/main/repo_files/flatpaks) flatpak --system -y install
    echo "Flatpaks installation complete."