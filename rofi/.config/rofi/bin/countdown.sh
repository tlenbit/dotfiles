#!/usr/bin/env bash

time_minutes=$(echo -ne "5\n10\n15\n30\n45\n60" | rofi -dmenu -p "" -width "5%")

if [ -z "$time_minutes" ];then
  exit
fi

time_seconds="$(($time_minutes*60))"

echo "$$" > /tmp/timer_pid.tmp

notify-send -u low "Countdown started" -h string:x-canonical-private-synchronous:volume_level

date1=$((`date +%s` + "$time_seconds"));
while [ "$date1" -ge `date +%s` ]; do
	time="$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)"
	echo -ne "$time" > /tmp/timer_time.tmp
  sleep 0.1
done

rm /tmp/timer_time.tmp
rm /tmp/timer_pid.tmp

slock