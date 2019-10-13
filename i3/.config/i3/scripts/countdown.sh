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

time_minutes=`rofi -dmenu -p 'Time (minutes)' -width 10`
run_countdown $time_minutes