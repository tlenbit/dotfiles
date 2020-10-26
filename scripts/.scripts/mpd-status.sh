#!/bin/sh

# ∞ 

if ! mpc >/dev/null 2>&1; then
	echo ""
	exit 1
else
	if mpc status | grep -q playing; then
		color_icon="#ffca3b"
	else
		color_icon="#fff"
	fi

	if mpc status | grep -q "repeat: on"; then
		repeat_icon="%{F#fff} "
	fi	

	if pgrep -f "ashuffle -f -" > /dev/null; then # if it's in album loop mode
		loop_on_album_icon="%{F#fff}"
	fi


	label="%{F$color_icon}$repeat_icon $loop_on_album_icon"

	echo $label
fi

# Block until an event is emitted
mpc idle >/dev/null
