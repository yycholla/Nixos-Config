#!/usr/bin/env bash
if [[ $# -lt 1 ]] || [[ ! -d $1   ]]; then
	echo "Usage:
	$0 <Wallpaper dir>"
	exit 1
fi

# Edit below to control the images transition
export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION_STEP=2

# This controls (in seconds) when to switch to the next image
INTERVAL=300

while true; do
	find "$1" -type f \
		| while read -r img; do
			echo "$((RANDOM % 1000)):$img"
		done \
		| sort -n | cut -d':' -f2- \
		| while read -r img; do
      export SWWW_WALPAPER=$img
      wal -i -n "$img"
			swww img -o vnc "$img"
      swww clear-cache
      pkill waybar
      waybar &>/dev/null & disown
			sleep $INTERVAL
		done
done
