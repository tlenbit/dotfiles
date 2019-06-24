#!/usr/bin/env bash

choice=$(echo -e "Lock\nLogout\nShutdown\nSuspend\nReboot" | rofi -dmenu -i -p 'power' -width 5)

if [[ $choice == "Lock" ]]; then
	# $HOME/.config/i3/scripts/lock.sh
	slock
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