#!/usr/bin/env bash

pid=$(ps aux | sed 1d | rofi -dmenu -p "" -width "40%" | awk '{print $2}')

if [ "x$pid" != "x" ]
then
  echo $pid | xargs kill -${1:-9}
fi
