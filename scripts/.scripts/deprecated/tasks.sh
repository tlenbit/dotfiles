#! /bin/bash

# Original inspiration
# task_id=`task \
# 	rc.verbose:nothing \
# 	rc.report.next.columns:start.active,id,entry.age,project,description \
# 	rc.report.next.labels:active,id,age,project,description \
# 	next | rofi -dmenu -width 20 -i -p "tasks" -lines 10 -no-custom | awk 'NR==1 { print $1 }'`


# APPROACH 1
ICON_DIR=$HOME/.config/i3/scripts/icons

input_line=`task \
	rc.verbose:nothing \
	rc.report.next.columns:start.active,project,description.desc \
	rc.report.next.labels:active,project,description \
	next | sed -e 's/^[ \t]*//' | rofi -dmenu -width 20 -i -p "tasks" -lines 15`

line=${input_line}
if [ -z "$line" ]; then
	exit 0
fi

# get projects: task _projects

# if there is a '+' leading, then add a new task
if [[ $line == +* ]]; then
	task_description=$(echo $line | sed s/^+//g |sed s/^\s+//g )
	project_name=`task _unique project | rofi -dmenu -i -p "project" -width 20`

	if [ -z "$project_name"]; then
		exit 0
	fi

	task_priority=`echo -e "L\nM\nH" | rofi -dmenu -i -p "priority" -width 20 -no-custom`

	if [ -z "$task_priority"]; then
		exit 0
	fi

	if [ -n "$project_name" ] && [ -n "$task_priority" ]; then
		task add project:"$project_name" priority:"$task_priority" "$task_description"
		notify-send -u low -i "$ICON_DIR/task-new.svg" "Task added!"
	fi
# otherwise, get the task id to execute other commands
else
	task_active=`echo "$line" | awk 'NR==1 { print $1 }'`
	task_options="Stop\nDone\nView\nDelete"

	if [ "$task_active" = "*" ]; then # selected task is active
		task_project_name=`echo "$line" | awk 'NR==1 { print $2 }'`
		task_description=`echo "$line" | cut -f 3- -d " " | sed -e 's/^[ \t]*//'`
		task_id=`task rc.verbose:nothing rc.report.list.columns:id rc.report.list.labels:id /"$(printf %q "$task_description")"/ limit:1 list | sed -e 's/^[ \t]*//'`

		echo "$task_description"
		echo "$task_id"
		# exit 0
	else
		task_project_name=`echo "$line" | awk 'NR==1 { print $1 }'`
		task_description=`echo "$line" | cut -f 2- -d " " | sed -e 's/^[ \t]*//'`
		task_id=`task rc.verbose:nothing rc.report.list.columns:id rc.report.list.labels:id /"$(printf %q "$task_description")"/ limit:1 list | sed -e 's/^[ \t]*//'`

		if [ "$task_id" -eq "$task_id" ] 2>/dev/null; then # validate if the id is a number
			task_options="Start\nView\nDone\nDelete"
		fi

		echo "$task_description"
		echo "$task_id"
		# exit 0
	fi

	echo "$task_options"

	if [ -z "$task_options" ]; then
		exit 0
	fi

	chosed_option=`echo -e "$task_options" | rofi -dmenu -i -p "[$task_id] $task_project_name..." -no-custom -width 20`

	# exit 0
	case "$chosed_option" in
		"Done" )
			task "$task_id" done
			notify-send -u low -i "$ICON_DIR/task-done.svg" "Task done!"
			# show a little summary before desappearing it
			;;
		"Start" )
			$HOME/.config/i3/scripts/tasks-stop.sh # First, stop all the active tasks
			task "$task_id" start
			notify-send -u low -i "$ICON_DIR/time-start.svg" "Task started!"
			;;
		"Stop" )
			task "$task_id" stop
			notify-send -u low -i "$ICON_DIR/time-stop.svg" "Task stopped!"
			;;
		"View")
			task_info=`task rc.verbose:nothing "$task_id"`
			rofi -e "$task_info" -fullscreen
			;;
		"Delete" )
			task "$task_id" rc.confirmation=off rc.bulk=5 rc.recurrence.confirmation=off delete
			notify-send -u low -i "$ICON_DIR/delete.svg" "Task deleted!"
			;;
	esac
fi

#task start "$task_id" && notify-send -i "$HOME/.config/i3/scripts/icons/time-start.svg" -u low "Task started"

# APPROACH 2

# function get_tasks {
# 	task \
# 		rc.verbose:nothing \
# 		rc.report.next.columns:start.active,id,entry.age,project,description \
# 		rc.report.next.labels:active,id,age,project,description \
# 		next
# }

# function get_projects {
# 	task _projects
# }

# function add_task {
# 	# description=$*
# 	# task add project:$1 $description
# }

# function start_task {
# 	task start 3
# }

# if [ -z "$@" ]; then
# 	get_tasks
# else
# 	LINE_UNESCAPED=${@}
# 	if [[ $LINE_UNESCAPED == +* ]]; then
# 		LINE_UNESCAPED=$(echo $LINE_UNESCAPED | sed s/^+//g |sed s/^\s+//g )
# 		get_projects
# 		echo "$LINE_UNESCAPED" > $HOME/Downloads/tesla
# 		add_task ${LINE_UNESCAPED}
# 	else

# 	fi
# fi

exit 0
