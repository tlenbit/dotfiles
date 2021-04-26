#!/bin/bash

# -------------------
# LAUNCH MISC
# -------------------

function ssh_on_directory() {
	host_dir=`echo "$1" | awk -F "$HOME/.mnt/" '{print $2}'`

	if [ -z "$host_dir" ];then
		notify-send "Can't SSH"
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
		notify-send "Timidity is already running"
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

	notify-send "Timidity started"
}

function launch_docker() {
	if sudo systemctl is-active docker.service; then
		notify-send "Docker ir already running"
		exit 0
	fi

	sudo systemctl start docker.service
	notify-send "Docker started"
}

function launch_insomnia() {
	$HOME/.local/bin/Insomnia.Core.AppImage
}

function launch_transmission() {
	if pgrep transmission-da; then
		notify-send "Transmission is already running"
		exit 0
	fi

	transmission_host="127.0.0.1"
	transmission_port="9091"
	transmission_user="admin"

	transmission-daemon --auth --username "$transmission_user" --password "$transmission_user" --port "$transmission_port" --allowed "$transmission_host"
	notify-send "Transmission started at $transmission_host:$transmission_port ($transmission_user)"
}

function launch_webdav() {
	if pgrep webdav; then
		notify-send "Webdav is already running"
		exit 0
	fi

	webdav_port="6666"

	webdav --config $HOME/.config/webdav.yml --port $webdav_port </dev/null &>/dev/null &
	notify-send "Webdav started at :$webdav_port"
}

function launch_clickup() {
	chromium --profile-directory=Default --app-id=edcmabgkbicempmpgmniellhbjopafjh
}

"$@"
