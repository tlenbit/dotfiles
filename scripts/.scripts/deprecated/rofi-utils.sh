#!/bin/bash

# TODO: Move functions to separate scripts or to deprecated

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

	notify-send -u low "Toggl: [$selected_project_name] $selected_task"
}

"$@"
#exit 0