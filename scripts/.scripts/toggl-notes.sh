#!/bin/bash
NOTES_FILE=$HOME/.notes

notes=$(cat "${NOTES_FILE}")
selected_task=$(echo -e "$notes" | rofi rofi -dmenu -i -width 30)

if [[ -z "${selected_task}" ]]; then
	exit 0
fi

echo $selected_task

# FLAW: if the command takes longer then everything gets blocked. maybe add a timeout?
list_projects=$(toggl projects)
selected_project_id=$(echo -e "$list_projects" | rofi -dmenu -i -width 10 | awk '{ print $1 }')
echo $selected_project_id

if [[ -z "${selected_project_id}" ]]; then
	exit 0
fi

toggl start "$selected_task" -P "$selected_project_id"

notify-send -u low " Task started on Toggl"

exit 0