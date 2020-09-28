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

function toggl_tasks() {
	NOTES_FILE=$HOME/.notes

	notes=$(cat "${NOTES_FILE}")
	selected_task=$(echo -e "$notes" | rofi rofi -dmenu -i -width 30 -p TOGGL)

	if [[ -z "${selected_task}" ]]; then
		exit 0
	fi

	# FLAW: if the command takes longer then everything gets blocked. maybe add a timeout?
	list_projects=$(toggl projects)
	selected_project="$(echo -e "$list_projects" | rofi -dmenu -i -width 10 -p PROJECT)"
	selected_project_id=$(echo "$selected_project" | awk '{ print $1 }')
	selected_project_name=$(echo "$selected_project" | awk '{ print $2 }')

	if [[ -z "${selected_project_id}" ]]; then
		exit 0
	fi

	toggl start "$selected_task" -P "$selected_project_id"

	notify-send -u low " Toggl: [$selected_project_name] $selected_task"
}

function mount_ssh_fs() {
	list_hosts=`sed -rn 's/^\s*Host\s+(.*)\s*/\1/ip' $HOME/.ssh/config`

	# mounted_hosts=$(ls $HOME/Desktop/mnt)
	# list_available=`comm -23 <(echo "$list_hosts" | sort) <(echo "$mounted_hosts" | sort)`
	# hostname=`echo "$list_available" | rofi -dmenu -i -p "Mount Host" -width 15 -lines 15 -matching regex`

	hostname=`echo "$list_hosts" | rofi -dmenu -i -p "Mount Host" -width 15 -lines 15 -matching regex`

	if [ -z "$hostname" ];then
		notify-send -u low " Can't mount"
		exit
	fi

	if ! grep -q "$hostname" $HOME/.ssh/config; then
		notify-send -u low " No host match $hostname"
		exit
	fi

	user=`rofi -dmenu -i -p 'user' -hide-scrollbar -width -30`
	user_hostname="$user@$hostname"

	if [ -z "$user" ];then
		user_hostname="$hostname"
	fi

	# Test if the connection is possible
	ssh -o PreferredAuthentications=publickey "$user_hostname" "echo ''" 2>&1;
	if [ $? -ne 0 ]; then
		notify-send -u low " Can't connect to $user_hostname"
		exit
	fi

	# Create a directory for mounting
	mount_dir="$HOME/Desktop/mnt/$hostname/$user"
	mkdir -p $mount_dir

	sshfs "$user_hostname:/home/$user" $mount_dir
	notify-send -u low " $user_hostname successfully mounted!"
}

function umount_ssh_fs() {
	mounted_dir=$(ls $HOME/Desktop/mnt | rofi -dmenu -i -p "Umount Host" -width 15 -lines 15 -matching regex)

	if [[ -z "${mounted_dir}" ]]; then
		exit 0
	fi

	mounted_user=$(ls "$HOME/Desktop/mnt/$mounted_dir" | rofi -dmenu -i -p "Umount Dir" -width 15 -lines 15 -matching regex)

	if [[ -z "${mounted_user}" ]]; then
		exit 0
	fi

	mount_dir="$HOME/Desktop/mnt/$mounted_dir/$mounted_user"

	if umount $mount_dir; then
		sleep 0.1
		rm -rf $mount_dir
		notify-send -u low " $mounted_dir successfully umounted"

		# If there's no other user connections, delete the host folder
		mounted_user=$(ls "$HOME/Desktop/mnt/$mounted_dir")

		if [[ -z "${mounted_user}" ]]; then
			rm -rf "$HOME/Desktop/mnt/$mounted_dir"		
		fi

		exit 0
	fi

	notify-send -u low " Error umounting $mounted_dir"
}

"$@"
#exit 0