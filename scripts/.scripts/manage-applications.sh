#!/bin/bash

# -------------------
# LAUNCH MISC
# -------------------

function ssh_on_directory() {
	host_dir=`echo "$1" | awk -F "$HOME/Desktop/mnt/" '{print $2}'`

	if [ -z "$host_dir" ];then
		send_notification "Can't SSH"
		exit
	fi

	host=$(echo $host_dir | awk -F '/' '{print $1}')
	user=$(echo ${host_dir#*/} | awk -F '/' '{print $1}')
	host_name="$user@$host"
	current_dir="/home/${host_dir#*/}"
	cmd="cd $current_dir; exec \$SHELL -l"

	alacritty -e ssh -t "$host_name" "$cmd"
}

# -------------------
# LAUNCH APPLICATIONS
# -------------------

function launch_timidity() {
	if pgrep timidity; then
		send_notification "Timidity is already running"
		exit 0
	fi

	timidity -iA -B2,8 \
		-Ei'49/1' \
		-Ei'1/2' \
		-Ei'3/3' \
		-Ei'4/4' \
		-Ei'5/5' \
		-Ei'6/6' \
		-Ei'7/7' \
		-Ei'8/8' \
		-Ei'9/9' \
		-Ei'10/10' \
		-Ei'11/11' \
		-Ei'12/12' \
		-Ei'13/13' \
		-Ei'14/14' \
		-Ei'15/15' \
		-Ei'16/16' \
		-Os </dev/null &>/dev/null &
	sleep 0.3
	aconnect 20:0 128:0

	send_notification "Timidity started"
}

function launch_mpd() {
	if pgrep mpd; then
		send_notification "MPD is already running"
		exit 0
	fi

	conf_file="$1"

	mpd $conf_file
	ashuffle </dev/null &>/dev/null &
	send_notification "MPD started"
}

function launch_mpd_hdd() {
	launch_mpd "$HOME/.config/mpd/mpd.conf"
}

function launch_mpd_local() {
	launch_mpd "$HOME/.config/mpd/mpd_local.conf"
}

function launch_docker() {
	if sudo systemctl is-active docker.service; then
		send_notification "Docker ir already running"
		exit 0
	fi

	sudo systemctl start docker.service
	send_notification "Docker started"
}

function launch_insomnia() {
	$HOME/.local/bin/Insomnia.Core.AppImage
}

function launch_transmission() {
	if pgrep transmission-da; then
		send_notification "Transmission is already running"
		exit 0
	fi

	transmission_host="127.0.0.1"
	transmission_port="9091"
	transmission_user="admin"

	transmission-daemon --auth --username "$transmission_user" --password "$transmission_user" --port "$transmission_port" --allowed "$transmission_host"
	send_notification "Transmission started at $transmission_host:$transmission_port ($transmission_user)"
}

function launch_webdav() {
	if pgrep webdav; then
		send_notification "Webdav is already running"
		exit 0
	fi

	webdav_port="8888"

	webdav --config $HOME/.config/webdav.yml --port $webdav_port </dev/null &>/dev/null &
	send_notification "Webdav started at :$webdav_port"
}

function launch_clickup() {
	chromium --profile-directory=Default --app-id=edcmabgkbicempmpgmniellhbjopafjh
}

# -------------------
# KILL APPLICATIONS
# -------------------

function kill_mpd() {
	if [ -z "$(pgrep mpd)" ]; then
		send_notification "MPD is not running"
		exit 0
	fi

	mpd --kill
}

function kill_docker() {
	if [ "$(sudo systemctl is-active docker.service)" == "inactive" ]; then
		send_notification "Docker is not running"
		exit 0
	fi

	sudo systemctl stop docker.service
}

function kill_timidity() {
	if [ -z "$(pgrep timidity)" ]; then
		send_notification "Timidity is not running"
		exit 0
	fi

	killall timidity
}

function kill_webdav() {
	if [ -z "$(pgrep webdav)" ]; then
		send_notification "Webdav is not running"
		exit 0
	fi

	killall webdav
}

function kill_transmission() {
	if ! pgrep transmission-da; then
		send_notification "Transmission is not running"
		exit 0
	fi

	transmission_user=admin
	transmission-remote --auth "$transmission_user:$transmission_user" --exit
}

function kill_timer() {
	kill -9 $(cat /tmp/timer_pid.tmp)
	rm /tmp/timer_*
}

# -------------------
# UTILITIES
# -------------------

function kill_apps() {
	programs="MPD\nDocker\nTimidity\nWebdav\nTransmission\nTimer"

	choice=$(echo -e "$programs" | rofi -dmenu -i -p 'kill' -hide-scrollbar -width -30)

	case $choice in
		"MPD")
			kill_mpd
			;;
		"Docker")
			kill_docker
			;;
		"Timidity")
			kill_timidity
			;;
		"Webdav")
			kill_webdav
			;;
		"Transmission")
			kill_transmission
			;;
		"Timer")
			kill_timer
			;;
		"*")
			exit 0
			;;
	esac

	send_notification "$choice stopped"
}

function send_notification() {
	notify-send -u low " $1" -h string:x-canonical-private-synchronous:volume_level
}

"$@"
exit 0
