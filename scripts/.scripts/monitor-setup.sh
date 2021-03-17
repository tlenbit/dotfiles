#!/bin/bash

if xrandr -q | grep -q 'DP-1 connected'; then
	xrandr --output eDP-1 --off --output DP-1 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-2 --off
else
	xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off
fi