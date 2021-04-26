#!/bin/bash

function set_animated_wallpaper() {
  if pgrep paperview; then
    killall paperview
  fi

  paperview "$HOME/.scenes/$(ls $HOME/.scenes | sort -R | head -1)" 10
}

# ps -ef | grep dwall | grep -v grep | awk '{print $2}' | xargs kill
# dwall -s=$(ls /usr/share/dynamic-wallpaper/images | sort -R | head -1) &

WALLPAPER_DIR=$HOME/.wallpapers
hsetroot -cover "$WALLPAPER_DIR/$(ls $WALLPAPER_DIR | sort -R | head -1)" # set random wallpaper from folder
