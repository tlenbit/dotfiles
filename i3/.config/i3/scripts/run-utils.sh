#!/usr/bin/env bash

function define_word {
	word=`cat /usr/share/dict/cracklib-small | rofi -dmenu -i -p "word" -width 15 -lines 6 -matching regex`
	if [ -z "$word" ]; then
		exit 0
	fi

	definition=`sdcv -n "$word"`
	rofi -e "$definition" -fullscreen
}

function translate_word {
	cat /usr/share/dict/cracklib-small | rofi -dmenu -i -p "word" -width 15 -lines 6 -matching regex | xargs -I{} xdg-open https://www.linguee.com/english-spanish/search\?source\=auto\&query\=\{\}
}

function clean_system {
	icon=$HOME/.config/i3/scripts/icons/user-trash-full.svg

	# Cleaning the system with bleachbit utility, first scan and then remove
	notify-send -u low -i "$icon" "[1/5] Cleaning the system - Bleachbit preview"
	bleachbit --preview --preset >/dev/null

	notify-send -u low -i "$icon" "[2/5] Cleaning the system - Bleachbit clean"
	bleachbit --clean --preset >/dev/null

	notify-send -u low -i "$icon" "[3/5] Cleaning the system - Paccache remove"
	paccache -r

	notify-send -u low -i "$icon" "[4/5] Cleaning the system - Pacman cache remove"
	sudo pacman -Sc

	notify-send -u low -i "$icon" "[5/5] Cleaning the system - Pacman orphans remove"
	sudo pacman -Rns $(pacman -Qtdq)

	notify-send -u low -i $HOME/.config/i3/scripts/icons/cleaned.svg "The system is now clean!"
}

function clone_repo {
	url=$(rofi -dmenu -p 'url' -width 20)

	if [ -z "$url" ]; then
		break
	fi

	icon=$HOME/.config/i3/scripts/icons/folder-git.svg

	## TODO
	# - validate if url regex is valid
	# - add automatic clipboard paste: xclip -out -selection clipboard

	cd $HOME/Downloads
	git clone --progress "$url" 2>&1 | while read OUTPUT; do
		notify-send -t 0 -i "$icon" "$OUTPUT" -h string:x-canonical-private-synchronous:git_clone
	done
}

function show_calendar {
	# references:
	# https://raw.githubusercontent.com/dikiaap/dotfiles/master/bin/rofi-calendar
	# https://raw.githubusercontent.com/vivien/i3blocks-contrib/master/rofi-calendar/rofi-calendar
	# cal 2019 | rofi run -dmenu -width 23 -lines 40 -p $(date) > /dev/null
	rofi -e "$(cal 2019)" -fullscreen -markup
}

function kill_current_timer {
	$HOME/.config/polybar/scripts/kill-timer.sh
}

function run_countdown {
	kill_current_timer

	time_minutes=$1
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

  # TODO: disable vlc notification trigger and replace it with notify-send
  vlc \
  	--quiet \
  	--play-and-exit \
  	--no-video-title-show \
  	--intf dummy \
  	--novideo \
  	--qt-notification 0 \
  	$HOME/.config/i3/scripts/bell.wav 2>/dev/null
}

function run_stopwatch {
	# NOTE
	# this does not work because the command can not be hide in background
	# it somehow stops and doest count nor creates the tmp file, so
	# polybar cannot see it but if this command is runned in tty works fine

	# Approach 1
	# termdown --no-figlet --no-text-magic -o /tmp/termdown.tmp

	# Approach 2
	# timew start

	# Approach 3
	kill_current_timer

  notify-send -u low -i $HOME/.config/i3/scripts/icons/time-start.svg "Timer started!"

	echo "$$" > /tmp/timer_pid.tmp

  date1=`date +%s`;
   while true; do
   	time="$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)"
    echo -ne "$time" > /tmp/timer_time.tmp
    sleep 0.1
   done

  rm /tmp/timer_time.tmp
  rm /tmp/timer_pid.tmp

  notify-send -u low -i $HOME/.config/i3/scripts/icons/time-stop.svg "Timer stopped!"
}

function report_project_tasks {
	# currently this is a poor and ill-formated report
	project=`task _unique project | rofi -dmenu -i -p "project" -no-custom -width 20`
	if [ -z "$project"]; then
		exit 0
	fi
	# report=`{ task burndown.weekly test & "$HOME"/.config/i3/scripts/tasktime.py "$project" }`
	report=`"$HOME"/.config/i3/scripts/tasktime.py -r "$project"`
	cat "$report"
	rofi -e "$report" -width 15 -markup -fullscreen
	# rofi -e "<span color='white'>$report</span>" -width 30 -markup
}

function toggle_theme {
	# ALERT: This function contains many flaws such as the consistency of the file
	# ant the future modification of the theme. In that case modify the settings.ini and
	# create the respective dark and light versions
	is_light=`cat $HOME/.config/gtk-3.0/settings.ini | rg -i "dark"`
	if [[ -z "$is_light" ]]; then
		cat $HOME/.config/gtk-3.0/settings_dark.ini > $HOME/.config/gtk-3.0/settings.ini
		notify-send -u low -i $HOME/.config/i3/scripts/icons/state-information.svg "Now the theme is dark"
	else
		cat $HOME/.config/gtk-3.0/settings_light.ini > $HOME/.config/gtk-3.0/settings.ini
		notify-send -u low -i $HOME/.config/i3/scripts/icons/state-information.svg "Now the theme is light"
	fi
}

options="Translate Word
Define Word
Clean System
Calendar
Countdown
Stopwatch"
# Toggle Theme
# Screencast
# Clone Repo
# Pomodoro
# Task Report

choice=$(echo "$options" | rofi -dmenu -i -p 'util' -hide-scrollbar -width -30)

case $choice in
	"Define Word")
		define_word
		;;
	"Translate Word")
		translate_word
		;;
	"Clean System")
		clean_system
		;;
	"Clone Repo")
		clone_repo
		;;
	"Toggle Theme")
		toggle_theme
		;;
	"Calendar")
		show_calendar
		;;
	"Pomodoro")
		run_countdown 25
		;;
	"Countdown")
		time_minutes=`rofi -dmenu -p 'Time (minutes)' -width 10`
		run_countdown $time_minutes
		;;
	"Stopwatch")
		run_stopwatch
		;;
	"Task Report")
		report_project_tasks
		;;
esac

exit 0


## Removed utilities
# function translate_text {
# 	rofi -dmenu -i -p "text" -width 30 -lines 0 | xargs -I{} xdg-open https://www.deepl.com/translator\#en/es/\{\}
# }
