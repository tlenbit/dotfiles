#!/usr/bin/env bash

choice=$(echo -e "Lock\nLogout\nShutdown\nSuspend\nReboot" | rofi -dmenu -i -p '' -hide-scrollbar -width -10 -lines 5)
if [[ $choice == "Lock" ]]; then
    sleep .1 && $HOME/.config/i3/scripts/lock.sh
fi
if [[ $choice == "Logout" ]]; then
    i3-msg exit
fi
if [[ $choice == "Shutdown" ]]; then
    systemctl poweroff
fi
if [[ $choice == "Suspend" ]]; then
    systemctl suspend
fi
if [[ $choice == "Reboot" ]]; then
    systemctl reboot
fi
exit 0
