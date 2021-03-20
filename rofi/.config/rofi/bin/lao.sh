#!/usr/bin/env bash

collection_name="Computer Science"
icon_favorite="package_favorite"

documents=$(lao ls -s "-title" -f "{id}\t{title}\0icon\x1f{favorite}" --format-replacements "favorite?$icon_favorite:" "$collection_name")
# documents=$(lao ls -s "-title" -f "{id}\t{title}\0icon\x1f{favorite?$icon_favorite:}" "$collection_name")

# optional flag for showing more info:  -mesg "<span color='#636e72'>4 Documents | 5 Collections</span>"
doc=$(echo -en "$documents" | cut -d'	' -f2 | rofi -show-icons -dmenu -i -p "" -width 30% -theme-str "entry {placeholder: \"Search...\";}")

if [ -z "$doc" ];then exit; fi

doc_id=$(echo -en "$documents" | grep -wam1 "$doc" | cut -d'	' -f1)

if [ -z "$doc_id" ];then exit; fi

doc_file=$(lao ls -f "{filepath}" -i "$doc_id")

evince "$doc_file"