ZOTERO_PATH="/media/6533-3962/zotero"
ZOTERO_DB="$ZOTERO_PATH/zotero.sqlite"
ZOTERO_STORAGE="$ZOTERO_PATH/storage"

# TODO: nice format, case insensitive, icons, filter non-good-titles
# get filename
file_title=$(sqlite3 $ZOTERO_DB "select DISTINCT json_extract(data, '$.data.itemType'), json_extract(data, '$.data.title') from syncCache where json_extract(data, '$.data.itemType') not in ('attachment', 'note');" | awk -F"|" '{printf(" %s\0icon\x1fgnome-activity-journal\n", $2)}' | rofi -dmenu -show-icons)
echo $file_title

# echo -en "Firefox\0icon\x1ffirefox\ngimpton\0icon\x1fgnome-activity-journal" | rofi -dmenu -show-icons
# exit

# file_title=$(sqlite3 $ZOTERO_DB "select DISTINCT json_extract(data, '$.data.title') from syncCache;" | rofi -dmenu)

# open file
file_path=`sqlite3 $ZOTERO_DB "select json_extract(data, '$.data.key'),json_extract(data, '$.data.title') from syncCache where json_extract(data, '$.data.parentItem') = (select json_extract(data, '$.data.key') from syncCache where json_extract(data, '$.data.title') = '$file_title');" | awk -F"|" '{printf("%s/%s", $1, $2)}'`
nohup zathura "$ZOTERO_STORAGE/$file_path" &