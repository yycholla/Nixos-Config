#!/usr/bin/env bash

# Init wallpaper damon
swww-daemon &
# Set Wallpaper
~/Nixos-Config/dotfiles/hypr/swww/randomize.sh ~/Wallpapers/ &
# Network manager (Install by adding pkgs.networkmanagerapplet to packages)
# nm-applet --indicator &
systemctl --user enable --now waybar.service &
# find bar app
waybar -l off &

if [ hyprctl monitors | grep -q "eDP-1"]; then
  echo "Not on desktop, skipping wayvnc-headless"
else
  echo "Starting wayvnc-headless"
  hyprctl output create headless vnc
  wayvnc 0.0.0.0 &
  wayvncctl output-set "vnc"
fi
