#!/usr/bin/env bash

search=$(rofi -dmenu -p "" -width "20%" -theme-str "entry {placeholder: \"Search\";}")

if [ -z "$search" ]; then
  exit 0
fi

mode=$(echo -ne "Sound\0icon\x1fpithos-tray-icon\nVideo\0icon\x1frecord-desktop-indicator" | rofi -show-icons -dmenu -e -p "" -width "10%" -theme-str "entry {placeholder: \"Mode\";}")

if [ -z "$mode" ];then
  exit
fi

case "$mode" in
  Video)
    notify-send -i "record-desktop-indicator" "Opening \"$search\""
    mpv --ytdl-format=best ytdl://ytsearch:"$search"

    ;;
  Sound)
    if [ -z "$(pgrep mpd)" ]; then
      notify-send -u low "MPD is not running" -h string:x-canonical-private-synchronous:volume_level
      exit 0
    fi

    notify-send -i "pithos-tray-icon" "Opening \"$search\""
    mpc insert $(youtube-dl --prefer-insecure -g -f140 ytsearch:"$search")
    mpc next
    mpc play
    ;;
  *)
    exit 0
    ;;
esac