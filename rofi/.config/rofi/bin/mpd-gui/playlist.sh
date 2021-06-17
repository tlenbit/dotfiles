#!/bin/bash

# TODO: use custom keys to remove tracks from current current playlist

echo -en "\0prompt\x1fPlaylist\n"
echo -en "\0message\x1f<span color='#636e72'></span><span color='#2ecc71'></span> <span>Autechre - Exai (20:11)</span>\n"

input="$@"
return_code="$ROFI_RETV"
#exit_code="$?"

echo "$return_code -- $input" >> /home/jc/downloads/debug.log

case $return_code in
  10)
    echo "removign" >> /home/jc/downloads/debug.log
    ;;
  0)
    echo "first time" >> /home/jc/downloads/debug.log
    mpc playlist -f  "[[%artist% - ]%title%]|[%file%]" | tac
    ;;
  *)
    playlist_numbered=$(mpc playlist -f  "[[%artist% - ]%title%]|[%file%]" | awk '{print NR "\t"  $0}')
    track_id=$(echo -e "$playlist_numbered" | grep -Fwm1 "$input" | cut -d$'\t' -f1)
    echo "track_id $track_id" >> /home/jc/downloads/debug.log
    mpc play "$track_id" &> /dev/null
    exit 0
    ;;
esac