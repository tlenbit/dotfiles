#!/bin/bash

function set_monitors() {
	# Monitor output
	if xrandr -q | grep 'HDMI-1 connected'; then
		#xrandr --output eDP-1 --off --output DP-1 --off --output HDMI-1 --mode 2560x1440 --pos 0x0 --rotate normal --output DP-2 --off
		xrandr --output eDP-1 --off --output DP-1 --off --output HDMI-1 --mode 1920x1200 --pos 0x0 --rotate normal --output DP-2 --off
	else
		xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off
	fi
}

function set_still_wallpaper() {
	# ps -ef | grep dwall | grep -v grep | awk '{print $2}' | xargs kill
	# dwall -s=$(ls /usr/share/dynamic-wallpaper/images | sort -R | head -1) &
	hsetroot -cover "$HOME/Pictures/wallpapers/$(ls $HOME/Pictures/wallpapers | sort -R | head -1)" # set random wallpaper from folder
}

function set_animated_wallpaper() {
	# Dependencies
	# - paperview

	if pgrep paperview; then
		killall paperview
	fi

	paperview "$HOME/Pictures/scenes/$(ls $HOME/Pictures/scenes | sort -R | head -1)" 10
}

function run_polybar() {
	# Terminate already running bar instances
	killall -q polybar

	# Wait until the processes have been shut down
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

	# Launch Polybar, using default config location ~/.config/polybar/config
	polybar -q top &
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

# RUN SCREEN SETUP (order matters)
set_monitors

run_polybar
run_picom
run_conky

set_still_wallpaper
# set_animated_wallpaper
