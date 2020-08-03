#!/bin/bash

function define_word {
	word=`cat /usr/share/dict/cracklib-small | rofi -dmenu -i -p "word" -width 15 -lines 6 -matching regex`
	if [ -z "$word" ]; then
		exit 0
	fi

	definition=`sdcv -n "$word"`
	rofi -e "$definition" -fullscreen
}

function powermenu {
	choice=$(echo -e "Lock\nLogout\nShutdown\nSuspend\nReboot" | rofi -dmenu -i -p '>' -width 5)

	if [[ $choice == "Lock" ]]; then
		# $HOME/.config/i3/scripts/lock.sh
		slock
	fi
	if [[ $choice == "Logout" ]]; then
		i3-msg exit
	fi
	if [[ $choice == "Shutdown" ]]; then
		$HOME/.config/i3/scripts/tasks-stop.sh
		systemctl poweroff
	fi
	if [[ $choice == "Suspend" ]]; then
		systemctl suspend
	fi
	if [[ $choice == "Reboot" ]]; then
		systemctl reboot
	fi
}

function play_youtube() {
	if [ -z "$(pgrep mpd)" ]; then
		send_notification "MPD is not running"
		exit 0
	fi

	search=$(rofi -dmenu -p 'search' -width 20)

	if [ -z "$search" ]; then
		exit 0
	fi

	mpc insert $(youtube-dl --prefer-insecure -g -f140 ytsearch:"$search")
	mpc next
	mpc play
}

function zotero_collection() {
	ZOTERO_PATH="/media/6533-3962/zotero"
	ZOTERO_DB="$ZOTERO_PATH/zotero.sqlite"
	ZOTERO_STORAGE="$ZOTERO_PATH/storage"

	# TODO: nice format, case insensitive, icons, filter non-good-titles
	# get filename
	file_title=$(sqlite3 $ZOTERO_DB "select DISTINCT json_extract(data, '$.data.itemType'), json_extract(data, '$.data.title') from syncCache where json_extract(data, '$.data.itemType') not in ('attachment', 'note');" | awk -F"|" '{printf(" %s\0icon\x1fgnome-activity-journal\n", $2)}' | rofi -dmenu -i -p ">" -show-icons -width 30)

	# echo -en "Firefox\0icon\x1ffirefox\ngimpton\0icon\x1fgnome-activity-journal" | rofi -dmenu -show-icons
	# exit
	# open file
	file_title=$(echo $file_title)
	SQL_QUERY="select json_extract(data, '$.data.key'),json_extract(data, '$.data.title') from syncCache where json_extract(data, '$.data.parentItem') = (select json_extract(data, '$.data.key') from syncCache where json_extract(data, '$.data.title') = '${file_title}');"

	file_path=`sqlite3 $ZOTERO_DB "$SQL_QUERY" | awk -F"|" '{printf("%s/%s", $1, $2)}'`

	if [[ "$file_path" ]]; then
		nohup zathura "$ZOTERO_STORAGE/$file_path" &
	fi
}

function countdown() {
	time_minutes=`rofi -dmenu -p 'Time' -width 10`
	kill_current_timer

	time_seconds="$(($time_minutes*60))"

	echo "$$" > /tmp/timer_pid.tmp

  date1=$((`date +%s` + "$time_seconds"));
  while [ "$date1" -ge `date +%s` ]; do
  	time="$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)"
  	echo -ne "$time" > /tmp/timer_time.tmp
    sleep 0.1
  done

  rm /tmp/timer_time.tmp
  rm /tmp/timer_pid.tmp

  slock
}

"$@"
exit 0
