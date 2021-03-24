#!/usr/bin/env bash

custom_theme="#prompt { padding: 0.2% 0.5% 0% -0.5%; enabled: true; }"

rofi \
	-show file-browser-extended \
	-modi file-browser-extended \
	-width "350px" \
	-theme-str "$custom_theme"
