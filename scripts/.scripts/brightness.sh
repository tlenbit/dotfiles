#! /bin/sh

# Use like this
# ./brightness up
# ./brightness down

function send_notification {
	level=$(light -G)
	level=$(printf "%.0f%%" $level)
	notify-send -u low \
		-i "gpm-brightness-lcd" "$level" \
		-t 700 \
		-h string:x-canonical-private-synchronous:brightness_level
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