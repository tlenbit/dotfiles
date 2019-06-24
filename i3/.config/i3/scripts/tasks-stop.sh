#! /bin/sh

# Stop just one task
# task_id=`task \
# 	rc.verbose:nothing \
# 	rc.report.active.columns:id \
# 	rc.report.active.labels:id limit:1 \
# 	active | sed -e 's/^[ \t]*//'`
# task stop task_id

# Stop all the tasks
for t in $(task status:pending +ACTIVE _uuids); do
	task $t stop
done

exit 0