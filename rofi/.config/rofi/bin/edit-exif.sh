#!/usr/bin/env bash

selected_file="$1"
description=`rofi -dmenu -i -p "" -width 30`

exiv2 -M"set Exif.Image.ImageDescription $description" "$selected_file"

notify-send -u low "Description for $1 updated to $description"