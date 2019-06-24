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
active_time=`task rc.verbose:nothing rc.report.active.columns:start.countdown rc.report.active.labels:counter limit:1 active | sed -e 's/^[ \t]*//'`
echo "$active_time"