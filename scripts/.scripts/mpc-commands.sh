ICON_DIR=$HOME/.config/i3/scripts/icons

function display_current_info() {
	MUSIC_DIR="/media/6533-3962/music"
	# MUSIC_DIR="/media/roygbiv/music"
	COVER="/tmp/cover.png"
	UNKNOWN_COVER="$HOME/.scripts/resources/cover.png"
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

	file="$MUSIC_DIR/$(mpc --format %file% current)"

	ffmpeg -loglevel 0 -y -i "$file" -vf "scale=$COVER_SIZE:-1" "$COVER"
	HAS_COVER=$?

	echo "$HAS_COVER"
	if [ $HAS_COVER != 0 ]; then
		COVER=$UNKNOWN_COVER
	fi

	notify-send -u low "$(mpc --format '%title%\n%artist%\n%album%' current)" -h string:x-canonical-private-synchronous:mpd-info -i "$COVER" > /dev/null 2>&1
	NOTIFICATION_SENT=$?

	if [ $NOTIFICATION_SENT != 0 ]; then
		notify-send -u low "$(mpc current)" -h string:x-canonical-private-synchronous:mpd-info -i "$COVER"
	fi
}

function queue_if_empty() {
	# search=$(mpc queued)
	# Dependencies
	# 	ashuffle
	# 	mpc

	# if current payliust queue reached the end
	if [ -z "$(mpc queued)" ]; then
		# add new random tracks to the playlist
		ashuffle --only 10
	fi
}

function play() {
	case $1 in
		prev)
			mpc_cmd="prev"
			;;
		next)
			mpc_cmd="next"
			# queue_if_empty
			;;
	esac

	mpc $mpc_cmd
	display_current_info
}

function toggle_loop_on_album() {
	if pgrep -f "ashuffle -f -" > /dev/null; then # if it's in album loop mode
		# then turn it off to normal
		if pgrep ashuffle; then 
			killall ashuffle
		fi 

		ashuffle </dev/null &>/dev/null &
		notify-send -u low " MPD: Loop in album mode OFF" -t 500 -h string:x-canonical-private-synchronous:volume_level
	else
		# otherwise turn it on
		if pgrep ashuffle; then 
			killall ashuffle
		fi

		current_music_dir=$(mpc current -f "%file%" | awk '{ print $1 }' FS="/")
		# mpc searchplay filename "$(mpc playlist | tail -1)"
		mpc ls "$current_music_dir" | ashuffle -f - &>/dev/null &
		# mpc next
		notify-send -u low " MPD: Loop in album mode ON" -t 500 -h string:x-canonical-private-synchronous:volume_level
	fi
}

function toggle_repeat() {
	if mpc status | grep -q "repeat: on"; then
		mpc single off
		mpc repeat off
		notify-send -u low " MPD: Repeat mode OFF" -t 500 -h string:x-canonical-private-synchronous:volume_level
	else
		mpc single on
		mpc repeat on
		notify-send -u low " MPD: Repeat mode ON" -t 500 -h string:x-canonical-private-synchronous:volume_level
	fi		

}

# This function play next in the queue a random track of the same album is being reproduced
# TODO: prevent adding tracks that are already queued
function queue_random_track() {
	# current_album=$(mpc current --format "%album%")
	# current_artist=$(mpc current --format "%artist%")
	# random_track=$(mpc search album "$current_album" artist "$current_artist" | sort -R | head -1)
	
	current_music_dir=$(mpc current -f "%file%" | awk '{ print $1 }' FS="/")
	random_track=$(mpc ls "$current_music_dir" | sort -R | head -1)
	mpc insert "$random_track"

	# Append whole directory of the current album
	# mpc ls "$(mpc current -f "%file%" | awk '{ print $1 }' FS="/")" | mpc insert
}

function seekthrough() {
	case $1 in
		backward)
				sign="-"
				# icon_name="$ICON_DIR/media-skip-backward-symbolic.svg"
				icon_name=""
				;;
		forward)
				sign="+"
				# icon_name="$ICON_DIR/media-skip-forward-symbolic.svg"
				icon_name=""
				;;
	esac

	mpc seekthrough "${sign}00:00:05"
	track_time="$(mpc status | grep "%)" | awk '{ print $3 }' | awk -F/ '{ print $1 }')/$(mpc --format %time% current)"
	notify-send -u low "$icon_name $track_time" -t 700 -h string:x-canonical-private-synchronous:mpc-seeking
	# notify-send -u low "$track_time" -i "$icon_name" -t 700 -h string:x-canonical-private-synchronous:mpc-seeking
}

"$@"
exit
