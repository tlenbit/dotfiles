#!/bin/bash

SHARE_DIR="$HOME/Documents/share"

function move_file() {
	selected_file="$1"
	mv -f "$selected_file" "$SHARE_DIR"
	notify-send -u low " File $selected_file was moved to share"
}

function link_file() {
	selected_file="$1"
	ln -fs "$selected_file" "$SHARE_DIR"
	notify-send -u low " File $selected_file was linked to share"
}

"$@"
exit 0
