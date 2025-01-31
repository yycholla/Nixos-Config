#!/usr/bin/env bash

# start headless Hyprland session
hyprctl output create headless vnc

# Init wayvnc
wayvnc 0.0.0.0 &


# Link wayvnc to headless session
wayvncctl output set "vnc"
