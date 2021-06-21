#!/bin/bash

# query=$(rofi -dmenu -p "" -width "20%" -theme-str "entry {placeholder: \"Search in Youtube...\";}")

# if [ -z "$query" ]; then exit; fi
# query=$(sed  -e 's|+|%2B|g' -e 's|#|%23|g' -e 's|&|%26|g' -e 's| |+|g' <<< "$query")

# response="$(curl -s "https://www.youtube.com/results?search_query=$query" | sed 's|\\.||g')"
# if ! grep -q "script" <<< "$response"; then echo "unable to fetch yt"; exit 1; fi
# vgrep='"videoRenderer":{"videoId":"\K.{11}".+?"text":".+?[^\\](?=")'
# playlist_grep='"playlistRenderer":{"playlistId":"\K.{34}?","title":{"simpleText":".+?[^\"](?=")'



# videoids=$(getresults "$vgrep")
# playlistids=$(getresults "$playlist_grep" "(playlist)")

# [ -n "$playlistids" ] && ids="$playlistids\n"
# [ -n "$videoids" ] && ids="$ids$videoids"

# echo "$ids"

# choice=$(echo -e "$ids" | cut -d$'\t' -f2 | awk '{print $0 "\0icon\x1fentry-new"}' | rofi -dmenu -i -width "20%" -p "" -theme-str "entry {placeholder: \"Select...\";}")
# if [ -z "$choice" ]; then exit; fi
# id=$(echo -e "$ids" | grep -Fwm1 "$choice" | cut -d$'\t' -f1)

list=$(echo -e "tom\nbeso\ncat\nentry\ncamino" | awk -F\" '{ print NR-1 "\t" $1}')

choice=$(echo -e "$list" | cut -d$'\t' -f1)

echo -e "$list"

