#!/usr/bin/env bash

# TODO
# documents=$(lao ls -s "-title" -f "{id}\t{title}\0icon\x1f{favorite?$icon_favorite:}" "$collections")
# optional flag for showing more info:  -mesg "<span color='#636e72'>4 Documents | 5 Collections</span>"
# - include description information as searcheable fields in rofi

collections=("Books" "Papers")
icon_favorite="package_favorite"

documents=$(lao ls \
  -s "-title" \
  -f "{id}\t{title} ({collection})\0icon\x1f{favorite}" \
  --format-replacements "favorite?$icon_favorite:" \
  "${collections[@]}")

doc=$(echo -en "$documents" | cut -d$'\t' -f2 | rofi \
  -show-icons \
  -dmenu \
  -i \
  -p "" \
  -width 30% \
  -theme-str "entry {placeholder: \"Search...\";}")
exit_code="$?"

if [ -z "$doc" ]; then exit; fi

doc_id=$(echo -en "$documents" | grep -wam1 "$doc" | cut -d$'\t' -f1)
if [ -z "$doc_id" ];then exit; fi

case "$exit_code" in
  "0")
    doc_file=$(lao ls -f "{filepath}" -i "$doc_id")
    evince "$doc_file"
    ;;
  "10")
    lao ls --toggle-favorite -i "$doc_id" >/dev/null 2>&1
    notify-send -i "favorite" "Toggle favorite for '$doc'"
    ;;
esac
