#! /bin/sh

# Use like this
# ./brightness up
# ./brightness down

ICON_DIR=$HOME/.config/i3/scripts/icons

function get_current_brightness {
	light -G
}

function send_notification {
	level=`get_current_brightness`
	#icon_name=$ICON_DIR/brightness-lcd.svg

	notify-send -u low -i "gpm-brightness-lcd" "$level%" -t 700 -h string:x-canonical-private-synchronous:brightness_level
	# notify-send -u low "$level%" -i "$icon_name" -t 700 -h string:x-canonical-private-synchronous:brightness_level
}

case $1 in
	up )
		light -A 2
		send_notification
		;;
	down )
		light -U 1
		send_notification
		;;
	high )
		light -A 50
		send_notification
		;;
	low )
		light -U 50
		send_notification
		;;

esac

exit 0