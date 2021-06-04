#!/bin/bash

path="$@"
filename=$(ls $path | rofi -dmenu -p "File Name" -width 20px)

if [ -z "$filename" ]; then
  exit
fi

file="$path/$filename"

touch $file
subl -a $file
