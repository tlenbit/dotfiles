#!/usr/bin/env bash

theme="launcher"
dir="$HOME/.config/rofi/themes"

rofi \
	-no-lazy-grab \
	-show drun \
	-modi drun \
	-theme $dir/"$theme"