#!/bin/bash

# TODO: append playlists at the end of the albums: eg. radio and such 
# make the next launch select the last position

echo -en "\0prompt\x1fAlbums\n"
echo -en "\0message\x1fAlbums: 1020\n"

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
    mpc ls | awk '{print $0 "\0icon\x1fentry-new"}'
    ;;
  *)
    echo -e "$input" | mpc insert
    notify-send  -i "dialog-information" "Albums added: $input"
    exit 0
    ;;
esac
