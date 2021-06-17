#!/bin/bash

# TODO: change behaviour of closing program when selecting. Instead perform action and return to invoked

echo -en "\0prompt\x1fTracks\n"
echo -en "\0message\x1fTracks: 20304\n"

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
    mpc listall | awk '{print $0 "\0icon\x1fentry-new"}' | awk '{print $0 "\0icon\x1fentry-new"}'
    ;;
  *)
    echo -e "$input" | mpc insert
    notify-send  -i "dialog-information" "Tracks added: $input"
    exit 0
    ;;
esac
