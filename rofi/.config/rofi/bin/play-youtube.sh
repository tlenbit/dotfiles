#!/usr/bin/env bash

if [ -z "$(pgrep mpd)" ]; then
  send_notification ""
  notify-send -u low "MPD is not running" -h string:x-canonical-private-synchronous:volume_level
  exit 0
fi

search=$(rofi -dmenu -p "" -width "20%")

if [ -z "$search" ]; then
  exit 0
fi

mpc insert $(youtube-dl --prefer-insecure -g -f140 ytsearch:"$search")
mpc next
mpc play