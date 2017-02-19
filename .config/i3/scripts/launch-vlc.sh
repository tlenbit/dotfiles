#!/bin/sh
count=`ps aux | grep -c vlc`
if [ $count -eq 1 ]; then
    vlc
else
    i3-msg "[class=vlc] focus"
fi
