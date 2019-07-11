#! /bin/bash

## APPROACH 1
# active_time=`task rc.verbose:nothing rc.report.active.columns:start.countdown rc.report.active.labels:counter limit:1 active | sed -e 's/^[ \t]*//'`
# active_project=`task rc.verbose:nothing rc.report.active.columns:project rc.report.active.labels:project limit:1 active | sed -e 's/^[ \t]*//'`
# active_description=`task rc.verbose:nothing rc.report.active.columns:description rc.report.active.labels:description limit:1 active | sed -e 's/^[ \t]*//'`

# TODO: integrate this function
# function trim_spaces {
# 	sed -e 's/^[ \t]*//'
# }

# echo "$active_time · [${active_project:--}] $active_description"

## APPROACH 2
# active_time=`task rc.verbose:nothing rc.report.active.columns:start.countdown rc.report.active.labels:counter limit:1 active | sed -e 's/^[ \t]*//'`
# echo "$active_time"

## APPROACH 3
is_task_active=$(task active 2>&1)
if [[ $is_task_active == "No matches." ]]; then
	# If there is no active task then show the counter of tasks
	counter_tasks=$(task status:pending count)
	echo "%{F#b8e994} %{F-}$counter_tasks"
else
	# Otherwhise show the counter of the current task
	active_time=`task rc.verbose:nothing rc.report.active.columns:start.countdown rc.report.active.labels:counter limit:1 active | sed -e 's/^[ \t]*//'`
	echo "%{F#ff7f50} %{F-}$active_time"
fi