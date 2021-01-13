#!/usr/bin/env bash

cat /usr/share/dict/cracklib-small | rofi \
	-dmenu -i \
	-p "" \
	-width 15 \
	-lines 6 | xargs -I{} xdg-open https://www.linguee.com/english-spanish/search\?source\=auto\&query\=\{\}