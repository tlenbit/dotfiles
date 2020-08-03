#!/bin/bash

function whole_screen_to_clipboard() {
	maim -u | xclip -selection clipboard -t image/png
	notify-send " Screenshot in clipboard"
}

function whole_screen_to_file() {
	filename=$HOME/Pictures/screenshots/$(date +%F_%H%M%S).png
	maim -u $filename
	notify-send " Screenshot saved in $filename"
}

function whole_screen_styled_to_file() {
	filename=$HOME/Pictures/screenshots/$(date +%F_%H%M%S).png
	maim -u | convert - \( +clone -background black -shadow 80x20+0+15 \) +swap \
		-background none \
		-layers merge +repage $filename

	notify-send " Screenshot (styled) saved in $filename"
}

function section_screen_to_clipboard() {
	maim -su | xclip -selection clipboard -t image/png
	notify-send " Screenshot section in clipboard"
}

function section_screen_to_file() {
	filename=$HOME/Pictures/screenshots/$(date +%F_%H%M%S)_cropped.png
	maim -su $filename | xclip -selection clipboard -t image/png
	notify-send " Screenshot section saved in $filename"
}

function section_screen_styled_to_file() {
	filename=$HOME/Pictures/screenshots/$(date +%F_%H%M%S)_cropped.png
	maim -su | convert - \( +clone -background black -shadow 80x20+0+15 \) +swap \
		-background none \
		-layers merge +repage $filename

	notify-send " Screenshot section (styled) saved in $filename"
}

"$@"
exit 0
