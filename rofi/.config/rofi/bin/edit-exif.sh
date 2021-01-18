#!/usr/bin/env bash

selected_file="$1"
current_value=$(exiv2 -g "Exif.Image.ImageDescription" -Pv "$selected_file")
description=$(echo -ne "$current_value" | rofi -dmenu -i -p "" -width 30)

if [ -z "$description" ];then
  exit
fi

exiv2 -M"set Exif.Image.ImageDescription $description" "$selected_file"

notify-send -i "camera" -u low "Description for $1 updated to $description"