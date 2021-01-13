#!/usr/bin/env bash

word=$(cat /usr/share/dict/cracklib-small | rofi -dmenu -i -p "" -width 15 -lines 6 -matching regex)

if [ -z "$word" ]; then
	exit 0
fi
definition=`sdcv -n "$word"`

rofi -e "$definition" -fullscreen
