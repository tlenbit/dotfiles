#!/bin/bash

# TODO: change behaviour of closing program when selecting. Instead perform action and return to invoked

echo -en "\0prompt\x1fSongs\n"
echo -en "\0message\x1fTotal: $(mpc stats | grep Songs | cut -d ' ' -f5)\n"

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
    mpc listall | awk '{print $0 "\0icon\x1fentry-new"}' | awk '{print $0 "\0icon\x1fentry-new"}'
    ;;
  *)
    if [ -z "$input" ]; then exit; fi
    echo -e "$input" | mpc add
    notify-send  -i "dialog-information" "Tracks added: $input"
    exit 0
    ;;
esac
