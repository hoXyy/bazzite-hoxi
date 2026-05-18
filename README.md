My own custom Bazzite image with changes like a specific version of GRUB that fixes an OOM issue when booting.

Mostly made for my own use, you can check my changes if you want to make your own image with this version of GRUB and some other changes of your own.

# Regarding the used GRUB version

This version was in Fedora 44's repos but was pulled due to other regressions that I don't care about.

More info about the issue here: https://bugzilla.redhat.com/show_bug.cgi?id=2263643

# Images

This repo builds 2 images, one with KDE and one with GNOME. Both are based on Bazzite's NVIDIA images.
I mostly use the KDE image, so no promises on how good the GNOME image is.