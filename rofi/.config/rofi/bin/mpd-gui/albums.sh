#!/bin/bash

# TODO: append playlists at the end of the albums: eg. radio and such
# make the next launch select the last position

echo -en "\0prompt\x1fAlbums\n"
echo -en "\0message\x1fTotal: $(mpc stats | grep Albums | cut -d ' ' -f5)\n"

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
    mpc ls | awk '{print $0 "\0icon\x1fentry-new"}'
    ;;
  *)
    if [ -z "$input" ]; then exit; fi
    echo -e "$input" | mpc add
    notify-send  -i "dialog-information" "Albums added: $input"
    exit 0
    ;;
esac
