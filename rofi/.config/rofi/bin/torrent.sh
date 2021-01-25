#!/bin/bash

query=$(rofi -dmenu -p "" -width "20%" -theme-str "entry {placeholder: \"Search\";}")

if [ -z "$query" ]; then
  exit 0
fi

query=$(sed 's| |%20|g' <<< $query)
videoids=$(curl -s https://www.1377x.to/search/$query/1/ | \
  grep -o -E '<a href="/torrent/.*</a>|<td class="coll-4 size mob-uploader">.*</td>|<td class="coll-2 seeds">.*</td>' |  \
  sed 's|<a href="/||g' | sed 's|<td class="coll-2 seeds">|\| 🌱Seeds: |g' | sed 's|<td class="coll-4 size mob-uploader">|\| 💾Size: |g' | \
  sed 's|">| |g' | \
  sed 's|</a>||g' | sed 's|</td>||g' | \
  awk 'NR%3{printf "%s ",$0;next;}1')

if [ -z "$videoids" ]; then
  notify-send "No results found"
  exit
fi

# fzf --with-nth='2..-1'
videoid=$(echo -e "$videoids" | cut -d' ' -f1 | rofi -dmenu -i -p "")
if [ "$videoid" == "" ]; then exit; fi

magnet_link=$(curl -s https://www.1377x.to/$videoid | grep -o 'magnet.*" on' | sed 's|" on||g')

if [ "$magnet_link" == "" ]; then exit; fi

transmission-remote --auth admin:admin -a "$magnet_link"

notify-send "Torrent added! $videoid"