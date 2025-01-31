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

if ["$HOSTNAME" = "yycholla-nixd"]; then
  echo "Starting wayvnc-headless"
  hyprctl output create headless vnc
  wayvnc 0.0.0.0 &
  wayvncctl output set "vnc"
else
  echo "Not on desktop, skipping wayvnc-headless"
fi
