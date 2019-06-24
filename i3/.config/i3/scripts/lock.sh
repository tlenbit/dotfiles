#!/bin/bash
#
#  '||    //\   //'.  || /
#   ||   ||  | ||     ||x
#   ||_|  \\/   \\_/ .|| \
#
# Description:              A minimal lock script
# Dependencies:             imagemagick, i3lock-color
# Author:                   0x7b1 (gawlk fork)
# Contributors:             none

sleep 0.1

screenshot='/tmp/lock.png'

maim $screenshot
convert $screenshot -blur 0x8 $screenshot

i3lock \
  -i "$screenshot" \
  --datepos="tx+24:ty+25" \
  --clock \
  --insidecolor=00000000 --ringcolor=ffffffff --line-uses-inside \
  --keyhlcolor=d23c3dff --bshlcolor=d23c3dff --separatorcolor=00000000 \
  --insidevercolor=fecf4dff --insidewrongcolor=d23c3dff \
  --ringvercolor=ffffffff --ringwrongcolor=ffffffff --indpos="x+290:h-120" \
  --radius=20 --ring-width=3 --veriftext="" --wrongtext="" \
  --timecolor="ffffffff" --datecolor="ffffffff"

rm $screenshot