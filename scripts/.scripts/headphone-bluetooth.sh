#!/bin/bash

HEADPHONE_MAC="00:08:E0:73:34:E6"
# TODO: Check if collides with another bt devices
# HEADPHONE_MAC=$(pacmd list-cards | grep bluez_card -C20 | grep 'device.string' | cut -d' ' -f 3)

function check_if_available() {
	bluetoothctl info "$HEADPHONE_MAC" | grep 'Connected: yes'
}

function get_battery_percentage() {
	percentage=$(python3 $HOME/.scripts/bluetooth_battery.py $HEADPHONE_MAC)

	echo "%{F#636e72} %{F-}$percentage"
}

"$@"