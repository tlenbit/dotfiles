# Monitor output
if xrandr -q | grep 'HDMI-1 connected'; then
	xrandr --output eDP-1 --off --output DP-1 --off --output HDMI-1 --mode 2560x1440 --pos 0x0 --rotate normal --output DP-2 --off
fi

# Wallpaper
# ps -ef | grep dwall | grep -v grep | awk '{print $2}' | xargs kill
# dwall -s=$(ls /usr/share/dynamic-wallpaper/images | sort -R | head -1) &
hsetroot -cover "$HOME/Pictures/wallpapers/$(ls $HOME/Pictures/wallpapers | sort -R | head -1)" # set random wallpaper from folder

$HOME/.config/polybar/launch.sh