#!/bin/bash

query=$(rofi -dmenu -p "" -width "20%" -theme-str "entry {placeholder: \"Search\";}")

if [ -z "$query" ]; then
  exit
fi

if [ -z "$query" ]; then exit; fi 
# sanitise the query
query=$(sed \
	-e 's|+|%2B|g'\
	-e 's|#|%23|g'\
	-e 's|&|%26|g'\
	-e 's| |+|g'\
	<<< "$query")
# fetch the results with the $query and
# delete all escaped characters
response="$(curl -s "https://www.youtube.com/results?search_query=$query" |\
	sed 's|\\.||g')"
# if unable to fetch the youtube results page, inform and exit
if ! grep -q "script" <<< "$response"; then echo "unable to fetch yt"; exit 1; fi
# regex expression to match video and playlist entries from yt result page
vgrep='"videoRenderer":{"videoId":"\K.{11}".+?"text":".+?[^\\](?=")'
pgrep='"playlistRenderer":{"playlistId":"\K.{34}?","title":{"simpleText":".+?[^\"](?=")'
# grep the id and title
# return them in format id (type) title
getresults() {
	  grep -oP "$1" <<< "$response" |\
		awk -F\" -v p="$2" '{ print $1 "\t" p " " $NF}'
}
# get the list of videos/playlists and their ids in videoids and playlistids
videoids=$(getresults "$vgrep")
playlistids=$(getresults "$pgrep" "(playlist)")
# if there are playlists or videos, append them to list
[ -n "$playlistids" ] && ids="$playlistids\n"
[ -n "$videoids" ] && ids="$ids$videoids"
# url prefix for videos and playlists
videolink="https://youtu.be/"
playlink="https://youtube.com/playlist?list="
# prompt the results to user infinitely until they exit (escape)

choice=$(echo -e "$ids" | cut -d'	' -f2 | rofi -dmenu -i -p "") # dont show id
if [ -z "$choice" ]; then exit; fi	# if esc-ed then exit
id=$(echo -e "$ids" | grep -Fwm1 "$choice" | cut -d'	' -f1) # get id of choice

# TODO: instead of another menu, handle response with key bindings. eg Enter: mpd; Ctrl+Enter: mpv
mode=$(echo -ne "Sound\0icon\x1fpithos-tray-icon\nVideo\0icon\x1frecord-desktop-indicator" | rofi -show-icons -dmenu -e -i -p "" -width "10%" -theme-str "entry {placeholder: \"Mode\";}")

if [ -z "$mode" ];then
  exit
fi

case "$mode" in
  Video)
    notify-send -i "record-desktop-indicator" "Opening \"$choice\""

    case $id in
      # 11 digit id = video
      ???????????) mpv "$videolink$id";;
      # 34 digit id = playlist
      ??????????????????????????????????) mpv "$playlink$id";;
      *) exit ;;
    esac
    ;;
  Sound)
    if [ -z "$(pgrep mpd)" ]; then
      notify-send -u low "MPD is not running" -h string:x-canonical-private-synchronous:volume_level
      exit 0
    fi

    notify-send -i "pithos-tray-icon" "Opening \"$choice\""
    mpc insert $(youtube-dl -x --add-metadata --prefer-insecure -g -f140 "$id")
    # mpc insert $(youtube-dl -x --add-metadata --prefer-insecure -g -f140 ytsearch:"$choice")
    mpc next
    mpc play
    ;;
  *)
    exit 0
    ;;
esac