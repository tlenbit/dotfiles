ICON_DIR=$HOME/.config/i3/scripts/icons

function display_current_info() {
	MUSIC_DIR="/media/roygbiv/music"
	COVER="/tmp/cover.png"
	UNKNOWN_COVER="$HOME/.config/i3/scripts/cover.png"
	COVER_SIZE=150

	function fallback_find_cover {
	    album="${file%/*}"
	    album_cover="$(find "$album" -type d -exec find {} -maxdepth 1 -type f -iregex ".*\(cover?s\|folder?s\|artwork?s\|front?s\|scan?s\).*[.]\(jpe?g\|png\|gif\|bmp\)" \;)"
	    if [ "$album_cover" == "" ]; then
	        album_cover="$(find "$album" -type d -exec find {} -maxdepth 1 -type f -iregex ".*[.]\(jpe?g\|png\|gif\|bmp\)" \;)"
	    fi
	    if [ "$album_cover" == "" ]; then
	        album_cover="$(find "$album/.." -type d -exec find {} -maxdepth 1 -type f -iregex ".*\(cover?s\|folder?s\|artwork?s\|front?s\|scan?s\|booklet\).*?1[.]\(jpe?g\|png\|gif\|bmp\)" \;)"
	    fi
	    album_cover="$(echo -n "$album_cover" | head -n1)"
	}

	# {
	file="$MUSIC_DIR/$(mpc --format %file% current)"

	ffmpeg -loglevel 0 -y -i "$file" -vf "scale=$COVER_SIZE:-1" "$COVER"
	HAS_COVER=$?

	if [ $HAS_COVER != 0 ]; then
	COVER=$UNKNOWN_COVER
	fi

	notify-send -u low "$(mpc --format '%title%\n%artist%\n%album%' current)" -h string:x-canonical-private-synchronous:mpd-info -i "$COVER" > /dev/null 2>&1
	NOTIFICATION_SENT=$?

	if [ $NOTIFICATION_SENT != 0 ]; then
		notify-send -u low "$(mpc current)" -h string:x-canonical-private-synchronous:mpd-info -i "$COVER"
	fi
}

function play() {
	case $1 in
		prev)
			mpc_cmd="prev"
			;;
		next)
			mpc_cmd="next"
			search=$(mpc queued)

			# Dependencies
			# 	ashuffle
			# 	mpc

			# if current payliust queue reached the end
			if [ -z "$search" ]; then
				# add new random tracks to the playlist
				echo "YES"
				ashuffle --only 10
			fi
			;;
	esac

	mpc $mpc_cmd
	display_current_info
}

function seekthrough() {
	case $1 in
		backward)
				sign="-"
				icon_name="$ICON_DIR/media-skip-backward-symbolic.svg"
				;;
		forward)
				sign="+"
				icon_name="$ICON_DIR/media-skip-forward-symbolic.svg"
				;;
	esac

	mpc seekthrough "${sign}00:00:05"
	track_time="$(mpc status | grep "%)" | awk '{ print $3 }' | awk -F/ '{ print $1 }')/$(mpc --format %time% current)"
	notify-send -u low "$track_time" -i "$icon_name" -t 700 -h string:x-canonical-private-synchronous:mpc-seeking
}

"$@"
exit