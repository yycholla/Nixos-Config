#!/usr/bin/env bash

# a rebuild script that commits on a successful build
set -e

# edit config
nvim ~/mysystem/configuration.nix

# cd config dir
pushd ~/mysystem

# early return if no changes were detected
if git diff --quiet '*.nix'; then
	echo "No changes detected, exiting."
	popd
	exit 0
fi

# Autoformat your nix files
alejandra . &>/dev/null \
	|| ( alejandra . ; echo "formatting failed" && exit 1)

# Show your changes
git diff -U0 '*.nix'

echo "NixOS Rebuilding..."

# Rebuild, output simplified errors, log tracebacks
sudo nixos-rebuild switch --flake ~/mysystem/#yycholla-nix &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)

# Get nixos generation metadata
current=$(nixos-rebuild list-generations | grep current)

#Commit all changes within the generation metadata
git commit -am "$current"

# back to where you were
popd

notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
