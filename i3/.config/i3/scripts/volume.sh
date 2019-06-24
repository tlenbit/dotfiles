#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

ICON_DIR=$HOME/.config/i3/scripts/icons

function get_volume {
    amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer -D pulse get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
    volume=`get_volume`

    if [ "$volume" = "0" ]; then
        icon_name="$ICON_DIR/audio-volume-muted.svg"
    else if [  "$volume" -lt "10" ]; then
        icon_name="$ICON_DIR/audio-volume-low.svg"
    else if [ "$volume" -lt "30" ]; then
        icon_name="$ICON_DIR/audio-volume-low.svg"
    else if [ "$volume" -lt "70" ]; then
        icon_name="$ICON_DIR/audio-volume-medium.svg"
    else
        icon_name="$ICON_DIR/audio-volume-high.svg"
    fi
    fi
    fi
    fi

    # Send the notification
    notify-send -u low $volume -i "$icon_name" -t 700 -h int:value:"$volume" -h string:x-canonical-private-synchronous:volume_level
}

case $1 in
    up)
        # Set the volume on (if it was muted)
        amixer -D pulse set Master on > /dev/null
        # Up the volume (+ 5%)
        amixer -D pulse sset Master 5%+ > /dev/null
        send_notification
        ;;
    down)
        amixer -D pulse set Master on > /dev/null
        amixer -D pulse sset Master 5%- > /dev/null
        send_notification
        ;;
    mute)
        # Toggle mute
        amixer -D pulse set Master 1+ toggle > /dev/null
        if is_mute; then
            notify-send -u low "muted" -i "$ICON_DIR/audio-volume-muted.svg" -t 700 -h string:x-canonical-private-synchronous:volume_level
        else
            send_notification
        fi
        ;;
esac
