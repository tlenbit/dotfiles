#!/bin/bash

# TODO: display music info when this script is invoked

if [ -z "$(pgrep mpd)" ]; then
  notify-send -u low "MPD is not running" -i "dialog-information"
  exit 0
fi

modes="playlist:/home/jc/.config/rofi/bin/mpd-gui/playlist.sh,"
modes+="albums:/home/jc/.config/rofi/bin/mpd-gui/albums.sh,"
modes+="tracks:/home/jc/.config/rofi/bin/mpd-gui/tracks.sh,"
modes+="youtube:/home/jc/.config/rofi/bin/mpd-gui/youtube.sh," 
modes+="current:/home/jc/.config/rofi/bin/mpd-gui/current.sh" 

rofi -modi "$modes" \
  -show playlist \
  -multi-select  \
  -width "20%" \
  -select 2 \
  -lines 2 \
  -theme-str "mainbox { children: [inputbar, sidebar, listview, message]; } listview { lines: 15; }"
