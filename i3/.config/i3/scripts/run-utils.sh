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

function translate_text {
	rofi -dmenu -i -p "text" -width 30 -lines 0 | xargs -I{} xdg-open https://www.deepl.com/translator\#en/es/\{\}
}

function clean_system {
	bleachbit --clean --preset && paccache -r && pacman -Sc && sudo pacman -Rns $(pacman -Qtdq) && notify-send "System cleared"
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

function run_stopwatch {
	# NOTE
	# this does not work because the command can not be hide in background
	# it somehow stops and doest count nor creates the tmp file, so
	# polybar cannot see it but if this command is runned in tty works fine

	# Approach 1
	# termdown --no-figlet --no-text-magic -o /tmp/termdown.tmp

	# Approach 2
	timew start
}

function report_project_tasks {
	# currently this is a poor and ill-formated report
	project=`task _unique project | rofi -dmenu -i -p "project" -no-custom -width 20`
	if [ -z "$project"]; then
		exit 0
	fi
	# report=`{ task burndown.weekly test & "$HOME"/.config/i3/scripts/tasktime.py "$project" }`
	report=`"$HOME"/.config/i3/scripts/tasktime.py -r "$project"`
	rofi -e "$report" -width 15 -markup -fullscreen
	# rofi -e "<span color='white'>$report</span>" -width 30 -markup
}

options="Define Word
Translate Word
Translate Text
Clone Repo
Clean System
Switch Theme
Calendar
Timer
Stopwatch
Pomodoro
Screencast
Task Report"

choice=$(echo "$options" | rofi -dmenu -i -p 'util' -hide-scrollbar -width -30)

case $choice in
	"Define Word")
		define_word
		;;
	"Translate Word")
		translate_word
		;;
	"Translate Text")
		translate_text
		;;
	"Clean System")
		clean_system
		;;
	"Clone Repo")
		clone_repo
		;;
	"Switch Theme")
		;;
	"Calendar")
		show_calendar
		;;
	"Stopwatch")
		run_stopwatch
		;;
	"Task Report")
		report_project_tasks
		;;
esac

exit 0
