#!/bin/sh

# ∞ 

if ! mpc >/dev/null 2>&1; then
	echo ""
	exit 1
else
	if mpc status | grep -q playing; then
		color_icon="#636e72"
	else
		color_icon="#ccc"
	fi

	if mpc status | grep -q "repeat: on"; then
		repeat_icon="%{F#ccc} ∞"
	fi	

	label="%{F$color_icon}$repeat_icon"

	echo $label
fi

# Block until an event is emitted
mpc idle >/dev/null
