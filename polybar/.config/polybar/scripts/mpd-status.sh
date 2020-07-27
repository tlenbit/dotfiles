#!/bin/sh
if ! mpc >/dev/null 2>&1; then
	echo ""
	exit 1
elif mpc status | grep -q playing; then
	echo "%{F#32ff7e}" 
	# echo "%{F#32ff7e} %{F#FFFFFF}$(mpc current -f '%time%')" # ncmpcpp --current-song '{%l}'
else
	echo "%{F#FFFFFF}"
	# How to differentiate a normal pause from an automatic triggered event?
	# ~/.config/i3/scripts/mpc-commands.sh queue_if_empty >/dev/null 2>&1
	# msg="%{F#FFFFFF} %{F#FFFFFF}$(mpc current)"
	# echo "%{F#FFFFFF} %{F#FFFFFF}$(mpc current -f "%artist% - %title%")"
	# echo "%{F#FFFFFF} %{F#FFFFFF}$(mpc current) ($(echo -e 'status\nclose' | nc localhost 6600 | awk -F: '/time/{print $3-$2}')s)"
fi

# Block until an event is emitted
mpc idle >/dev/null

# [module/script]
# type = custom/script
# exec = ~/mpc_zscroll.sh
# tail = true
# interval = 0
# https://github.com/polybar/polybar/issues/353
