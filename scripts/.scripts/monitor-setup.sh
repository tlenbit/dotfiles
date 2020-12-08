#!/bin/bash

function set_monitors() {
	#xrandr --output eDP-1 --off --output DP-1 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-2 --off
	if xrandr -q | grep 'HDMI-1 connected'; then
		#xrandr --output eDP-1 --off --output DP-1 --off --output HDMI-1 --mode 2560x1440 --pos 0x0 --rotate normal --output DP-2 --off
		xrandr --output eDP-1 --off --output DP-1 --off --output HDMI-1 --mode 1920x1200 --pos 0x0 --rotate normal --output DP-2 --off
		#xrandr --output eDP-1 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off
	else
		xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off
	fi

}

set_monitors