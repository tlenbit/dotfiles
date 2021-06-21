#!/bin/bash

current=$(mpc current -f  "[[%artist% - ]%title% (%time%)]|[%file% (%time%)]")

if [[ -z "$current" ]]; then
  current="Nothing is currently playing"
else
  current=$(echo "$current" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g')
  current=${current:0:130}
fi

if mpc status | grep -q playing; then
  player_icon=""
else
  player_icon=""
fi

if mpc status | grep -q "repeat: on"; then
  repeat_icon=" "
fi

if pgrep -f "ashuffle -f -" > /dev/null; then # if it's in album loop mode
  loop_on_album_icon=" "
fi

label="<span color='#888'>$repeat_icon</span><span color='#888'>$loop_on_album_icon</span><span color='#2ecc71'>$player_icon</span> <span>$current</span>"

echo -en "\0prompt\x1fCurrent\n"
echo -en "\0message\x1f$label\n"

input="$@"
return_code="$ROFI_RETV"
#exit_code="$?"

echo "$return_code -- $input" >> ./debug.log

case $return_code in
  10)
    # echo "removign" >> ./debug.log
    ;;
  0)
    # echo "first time" >> ./debug.log
    current_music_dir=$(mpc current -f "%file%" | awk '{ print $1 }' FS="/")
    mpc ls "$current_music_dir"| awk '{ print $2 }' FS="/" | awk '{print $0 "\0icon\x1fentry-new"}'
    ;;
  *)
    current_music_dir=$(mpc current -f "%file%" | awk '{ print $1 }' FS="/")
    echo -e "$current_music_dir/$input" | mpc add
    notify-send  -i "dialog-information" "Tracks added: $input"
    exit 0
    ;;
esac
