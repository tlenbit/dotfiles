#!/usr/bin/env bash

ICON_DIR=$HOME/.config/i3/scripts/icons

if [ "$(systemctl is-active bluetooth.service)" = "active" ]; then
	sudo systemctl stop bluetooth.service
	notify-send -u low -t 700 -i "bluetooth-disabled" "Bluetooth deactivated" -h string:x-canonical-private-synchronous:status_bluetooth
else
	sudo systemctl start bluetooth.service
	notify-send -u low -t 700 -i "bluetooth-active" "Bluetooth activated" -h string:x-canonical-private-synchronous:status_bluetooth
fi

exit 0