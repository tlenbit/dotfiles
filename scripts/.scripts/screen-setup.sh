#!/bin/bash

function run_polybar() {
	# Terminate already running bar instances
	killall -q polybar

	# Wait until the processes have been shut down
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

	# Launch Polybar, using default config location ~/.config/polybar/config
	# polybar -q top &
	polybar -q bottom &
}

function run_picom() {
	if ps -A | grep -q picom; then
		killall -q picom
	fi

	picom -b
}

function run_conky() {
	if ps -A | grep -q conky; then
		killall -q conky
	fi

	conky -q -d
}

function set_wallpaper() {
	WALLPAPER_DIR=$HOME/.wallpapers
	hsetroot -cover "$WALLPAPER_DIR/$(ls $WALLPAPER_DIR | sort -R | head -1)" # set random wallpaper from folder
}

run_polybar
run_picom
set_wallpaper
# run_conky
