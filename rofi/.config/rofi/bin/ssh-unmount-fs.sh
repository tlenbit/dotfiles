#!/usr/bin/env bash

mounted_dir=$(ls $HOME/.mnt | rofi -dmenu -i -p "Umount Host" -width 15 -lines 15 -matching regex)

if [[ -z "${mounted_dir}" ]]; then
  exit 0
fi

mounted_user=$(ls "$HOME/.mnt/$mounted_dir" | rofi -dmenu -i -p "Umount Dir" -width 15 -lines 15 -matching regex)

if [[ -z "${mounted_user}" ]]; then
  exit 0
fi

mount_dir="$HOME/.mnt/$mounted_dir/$mounted_user"

if umount $mount_dir; then
  sleep 0.1
  rm -rf $mount_dir
  notify-send -u -i "drive-optical" low "$mounted_dir successfully umounted"

  # If there's no other user connections, delete the host folder
  mounted_user=$(ls "$HOME/.mnt/$mounted_dir")

  if [[ -z "${mounted_user}" ]]; then
    rm -rf "$HOME/.mnt/$mounted_dir"    
  fi

  exit 0
fi

notify-send -u low -i "dialog-error" "Error umounting $mounted_dir"