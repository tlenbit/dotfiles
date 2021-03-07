#!/bin/bash

DIR=$HOME

function set_still_wallpaper() {
	# ps -ef | grep dwall | grep -v grep | awk '{print $2}' | xargs kill
	# dwall -s=$(ls /usr/share/dynamic-wallpaper/images | sort -R | head -1) &
	hsetroot -cover "$HOME/.wallpapers/$(ls $HOME/.wallpapers | sort -R | head -1)" # set random wallpaper from folder
}

function set_animated_wallpaper() {
	# Dependencies
	# - paperview

	if pgrep paperview; then
		killall paperview
	fi

	paperview "$HOME/.scenes/$(ls $HOME/.scenes | sort -R | head -1)" 10
}

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

# RUN SCREEN SETUP (the order matters)
run_polybar
run_picom
# run_conky

set_still_wallpaper
# set_animated_wallpaper
