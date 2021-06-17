#!/bin/bash

if [ -z "$(pgrep mpd)" ]; then
  notify-send -u low "MPD is not running" -h string:x-canonical-private-synchronous:volume_level
  exit 0
fi

current=$(mpc current -f '%file% (%time%)')

# TODO: maybe add music label icons here? along with current

if [[ -z "$current" ]]; then
  current="Nothing is currently playing"
else
  current=$(echo "$current" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g')
  current=${current:0:130}
fi

playlist=$(mpc playlist -f  "[[%artist% - ]%title%]|[%file%]")
#playlist=$(mpc playlist | awk '{print "[" NR "]" " " $0}')

options+="Albums\0icon\x1fremote-folder-sync\n"
options+="Current\0icon\x1fprocess-syncing\n"
options+="Tracks\0icon\x1fpithos-tray-icon\n"
# options+="Playlists\0icon\x1fprocess-syncing-idle\n"
options+="Youtube\0icon\x1fyoutube-indicator-light\n"
options+="Clear\0icon\x1findicator-trashindicator\n"
options+=$(echo -e "$playlist" | tac)

# options+="Youtube\0icon\x1fcurrenttrack_play\n"
# draw-circle
# options+=$(echo "$playlist" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g')

statusbar="<span color='#32ff7e'></span> <span>$current</span>"
# statusbar="<span color='#95a5a6'></span> <span color='#32ff7e'></span> <span>$current</span>"

option=$(echo -e "$options" | rofi -show-icons -dmenu -p "" -width "20%" -selected-row 5 -mesg "$statusbar" -i -theme-str "entry {placeholder: \"Select...\";}")

case $option in
  Albums)
    selections=$(mpc ls | awk '{print $0 "\0icon\x1fentry-new"}' | rofi -dmenu -p "" -width "20%" -multi-select -i -mesg "$(mpc stats | head -3)" -theme-str "entry {placeholder: \"Select...\";}")
    echo -e "$selections" | mpc insert
    notify-send  -i "dialog-information" "Albums added: $selections"
    ;;
  Current)
    current_music_dir=$(mpc current -f "%file%" | awk '{ print $1 }' FS="/")
    selections=$(mpc ls "$current_music_dir" | awk '{print $0 "\0icon\x1fentry-new"}' | rofi -dmenu -p "" -width "20%" -multi-select -i -mesg "$statusbar" -theme-str "entry {placeholder: \"Select...\";}")
    echo -e "$selections" | mpc insert
    notify-send  -i "dialog-information" "Tracks added: $selections"
    ;;
  Tracks)
    selections=$(mpc listall | awk '{print $0 "\0icon\x1fentry-new"}' | rofi -dmenu -p "" -width "20%" -multi-select -i -mesg "$(mpc stats | head -3)" -theme-str "entry {placeholder: \"Select...\";}")
    echo -e "$selections" | mpc insert
    notify-send  -i "dialog-information" "Tracks added: $selections"
    ;;
  Youtube)
    query=$(rofi -dmenu -p "" -width "20%" -theme-str "entry {placeholder: \"Search in Youtube...\";}")

    if [ -z "$query" ]; then exit; fi 
    query=$(sed  -e 's|+|%2B|g' -e 's|#|%23|g' -e 's|&|%26|g' -e 's| |+|g' <<< "$query")

    response="$(curl -s "https://www.youtube.com/results?search_query=$query" | sed 's|\\.||g')"
    if ! grep -q "script" <<< "$response"; then echo "unable to fetch yt"; exit 1; fi
    vgrep='"videoRenderer":{"videoId":"\K.{11}".+?"text":".+?[^\\](?=")'
    playlist_grep='"playlistRenderer":{"playlistId":"\K.{34}?","title":{"simpleText":".+?[^\"](?=")'

    getresults() {
        grep -oP "$1" <<< "$response" |\
        awk -F\" -v p="$2" '{ print $1 "\t" p " " $NF}'
    }

    videoids=$(getresults "$vgrep")
    playlistids=$(getresults "$playlist_grep" "(playlist)")

    [ -n "$playlistids" ] && ids="$playlistids\n"
    [ -n "$videoids" ] && ids="$ids$videoids"

    choice=$(echo -e "$ids" | cut -d$'\t' -f2 | awk '{print $0 "\0icon\x1fentry-new"}' | rofi -dmenu -i -width "20%" -p "" -theme-str "entry {placeholder: \"Select...\";}")
    if [ -z "$choice" ]; then exit; fi
    id=$(echo -e "$ids" | grep -Fwm1 "$choice" | cut -d$'\t' -f1)

    mpc insert $(youtube-dl -x --add-metadata --prefer-insecure -g -f140 "$id")
    notify-send  -i "dialog-information" "Youtube track added: $selections"
    ;;
  Clear)
    mpc clear
    ;;
  *)
    if [ -z "$option" ]; then exit; fi
    playlist_numbered=$(echo -e "$playlist" | awk '{print NR "\t"  $0}')
    track_id=$(echo -e "$playlist_numbered" | grep -Fwm1 "$option" | cut -d$'\t' -f1)
    mpc play $track_id
    ;;
esac

# mpc next

exit