#!/bin/bash

# TODO: display music info when this script is invoked

if [ -z "$(pgrep mpd)" ]; then
  notify-send -u low "MPD is not running" -i "dialog-information"
  exit 0
fi

modes="playlist:/home/jc/.config/rofi/bin/mpd-gui/playlist.sh,"
modes+="albums:/home/jc/.config/rofi/bin/mpd-gui/albums.sh,"
modes+="tracks:/home/jc/.config/rofi/bin/mpd-gui/tracks.sh,"
# modes+="youtube:/home/jc/.config/rofi/bin/mpd-gui/youtube.sh,"
modes+="current:/home/jc/.config/rofi/bin/mpd-gui/current.sh"

FMT_PLAYLIST="[[%artist% - ]%title% (%time%)]|[%file% (%time%)]"
current=$(mpc current -f  "$FMT_PLAYLIST")
row_nr=$(mpc playlist -f  "$FMT_PLAYLIST" | awk '{print NR-1 "\t"  $0}' | grep -Fwm1 "$current" | cut -d$'\t' -f1)
len_rows=$(mpc playlist | wc -l)
inverse_row_nr="$(($len_rows - $row_nr - 1))"

rofi -modi "$modes" \
  -show playlist \
  -multi-select  \
  -width "20%" \
  -selected-row $inverse_row_nr \
  -lines 2 \
  -theme-str 'mainbox { children: [inputbar, sidebar, listview, message]; } listview { lines: 15; }'
