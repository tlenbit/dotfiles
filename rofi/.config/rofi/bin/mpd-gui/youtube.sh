#!/bin/bash

echo -en "\0prompt\x1fYoutube\n"
echo -en "\0message\x1fResults for: \"Motel y te vas\"\n"

input="$@"
return_code="$ROFI_RETV"
#exit_code="$?"

echo "$return_code -- $input" >> ./debug.log

case $return_code in
  10)
    echo "removign" >> ./debug.log
    ;;
  0)
    echo "first time" >> ./debug.log
    current_music_dir=$(mpc current -f "%file%" | awk '{ print $1 }' FS="/")
    mpc ls "$current_music_dir"| awk '{ print $2 }' FS="/" | awk '{print $0 "\0icon\x1fentry-new"}'
    ;;
  *)
    current_music_dir=$(mpc current -f "%file%" | awk '{ print $1 }' FS="/")
    echo -e "$current_music_dir/$input" | mpc insert
    notify-send  -i "dialog-information" "Tracks added: $input"
    exit 0
    ;;
esac
