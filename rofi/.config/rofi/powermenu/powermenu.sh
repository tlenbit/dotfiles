#!/usr/bin/env bash

rofi_command="rofi -theme $HOME/.config/rofi/powermenu/five.rasi"

uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown=""
reboot=""
lock=""
suspend=""
logout=""

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
      systemctl poweroff
      ;;
    $reboot)
      systemctl reboot
      ;;
    $lock)
      slock
      ;;
    $suspend)
      mpc -q pause
      amixer set Master mute
      systemctl suspend
      ;;
    $logout)
      i3-msg exit
      ;;
esac
