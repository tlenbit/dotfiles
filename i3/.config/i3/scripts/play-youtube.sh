search=$(rofi -dmenu -p 'search' -width 20)

if [ -z "$search" ]; then
	exit 0
fi

mpc insert $(youtube-dl --prefer-insecure -g -f140 ytsearch:"$search")
mpc next
mpc play
exit 0
