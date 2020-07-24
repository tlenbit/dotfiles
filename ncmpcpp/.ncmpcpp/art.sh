#!/usr/bin/env sh

#-------------------------------#
# Generate current song cover   #
# ffmpeg version                #
#-------------------------------#

MUSIC_DIR="/media/roygbiv/music"
COVER="/tmp/cover.png"
UNKNOWN_COVER="$HOME/.ncmpcpp/cover.png"
COVER_SIZE=150

function fallback_find_cover {
    album="${file%/*}"
    album_cover="$(find "$album" -type d -exec find {} -maxdepth 1 -type f -iregex ".*\(cover?s\|folder?s\|artwork?s\|front?s\|scan?s\).*[.]\(jpe?g\|png\|gif\|bmp\)" \;)"
    if [ "$album_cover" == "" ]; then
        album_cover="$(find "$album" -type d -exec find {} -maxdepth 1 -type f -iregex ".*[.]\(jpe?g\|png\|gif\|bmp\)" \;)"
    fi
    if [ "$album_cover" == "" ]; then
        album_cover="$(find "$album/.." -type d -exec find {} -maxdepth 1 -type f -iregex ".*\(cover?s\|folder?s\|artwork?s\|front?s\|scan?s\|booklet\).*?1[.]\(jpe?g\|png\|gif\|bmp\)" \;)"
    fi
    album_cover="$(echo -n "$album_cover" | head -n1)"
}

# {
file="$MUSIC_DIR/$(mpc --format %file% current)"

ffmpeg -loglevel 0 -y -i "$file" -vf "scale=$COVER_SIZE:-1" "$COVER"
HAS_COVER=$?

if [ $HAS_COVER != 0 ]; then
COVER=$UNKNOWN_COVER
fi

notify-send -u low "$(mpc --format '%title% \n%artist% - %album%' current)" -h string:x-canonical-private-synchronous:mpd-info -i "$COVER"

exit
# } &
