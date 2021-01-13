#!/usr/bin/env bash

programs=""

# MPD
if [ -n "$(pgrep mpd)" ]; then
  programs="MPD\0icon\x1fmpd\n$programs"
fi

# Docker
if [ "$(sudo systemctl is-active docker.service)" == "active" ]; then
  programs="Docker\0icon\x1fkdocker\n$programs"
fi

# Timidity
if [ -n "$(pgrep timidity)" ]; then
  programs="Timidity\0icon\x1ftimidity\n$programs"
fi

# Webdav
if [ -n "$(pgrep webdav)" ]; then
  programs="Webdav\0icon\x1fterminal\n$programs"
fi

# Transmission
if pgrep transmission-da; then
  programs="Transmission\0icon\x1ftransmission\n$programs"
fi

# Countdown
if [ -n "$(cat /tmp/timer_pid.tmp)" ]; then
  programs="Countdown\0icon\x1fcom.github.parnold-x.timer\n$programs"
fi

choice=$(echo -en "$programs" | rofi -dmenu -i -p "" -hide-scrollbar -width "10%")

if [ -z "$choice" ];then
  exit
fi

case "$choice" in
  MPD)
    mpd --kill
    ;;
  Docker)
    sudo systemctl stop docker.service
    ;;
  Timidity)
    killall timidity
    ;;
  Webdav)
    killall webdav
    ;;
  Transmission)
    transmission_user=admin
    transmission-remote --auth "$transmission_user:$transmission_user" --exit
    ;;
  Countdown)
    kill -9 $(cat /tmp/timer_pid.tmp)
    rm /tmp/timer_*
    ;;
  *)
    exit 0
    ;;
esac

notify-send -u low "$choice stopped" -h string:x-canonical-private-synchronous:killed_app