#!/usr/bin/env bash

# Init wallpaper damon
swww-daemon &
# Set Wallpaper
~/Nixos-Config/dotfiles/hypr/swww/randomize.sh ~/Wallpapers/ &
# Network manager (Install by adding pkgs.networkmanagerapplet to packages)
# nm-applet --indicator &
systemctl --user enable --now waybar.service &
# find bar app
waybar &
