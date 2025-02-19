#!/usr/bin/env bash

# Init wallpaper damon
swww-daemon &
pypr &
# Set Wallpaper
~/Nixos-Config/dotfiles/hypr/swww/randomize.sh ~/Wallpapers/Hor/ &
~/Nixos-Config/dotfiles/hypr/swww/randomizev.sh ~/Wallpapers/Hor/ &
# Network manager (Install by adding pkgs.networkmanagerapplet to packages)
# nm-applet --indicator &
systemctl --user enable --now waybar.service &
# find bar app
waybar -l off &

if [ hyprctl monitors | grep -q "eDP-1"]; then
  echo "Not on desktop, skipping wayvnc-headless"
else
  echo "Starting wayvnc-headless"
  sunshine &
fi
