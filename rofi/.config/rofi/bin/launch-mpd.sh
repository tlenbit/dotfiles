#!/usr/bin/env bash

if pgrep mpd; then
  notify-send "MPD is already running"
  exit 0
fi

# dbconfig=$(echo -ne "Local\0icon\x1fdesktopconnected\nHDD\0icon\x1findicator-sensors-disk" | rofi -dmenu -p "" -width "10%" -i -theme-str "entry {placeholder: \"Choose database\";}")

# if [ -z "$dbconfig" ]; then
#   exit 0
# fi

# case "$dbconfig" in
#   Local)
#     config_file="$HOME/.config/mpd/mpd_local.conf"
#     ;;
#   HDD)
#     config_file="$HOME/.config/mpd/mpd.conf"
#     ;;
#   *)
#     exit 0
#     ;;
# esac

config_file="$HOME/.config/mpd/mpd.conf"

mpd "$config_file"
ashuffle </dev/null &>/dev/null &
notify-send "MPD started"