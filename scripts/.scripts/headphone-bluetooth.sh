#!/bin/bash

HEADPHONES_MAC=$(pacmd list-cards | grep bluez_card -C20 | grep 'device.string' | cut -d' ' -f 3 | tr -d '"')

function check_if_available() {
	bluetoothctl info $HEADPHONES_MAC | grep 'Connected: yes'
}

function get_battery_percentage() {
	percentage=$(python3 $HOME/.scripts/bluetooth_battery.py $HEADPHONES_MAC)

	echo "%{F#ffd86e} %{F-}$percentage"
}

"$@"