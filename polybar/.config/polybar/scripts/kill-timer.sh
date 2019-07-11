#! /usr/bin/bash

kill -9 $(cat /tmp/timer_pid.tmp) && rm /tmp/timer_* && notify-send -u low -i $HOME/.config/i3/scripts/icons/state-information.svg "Timer stopped"
