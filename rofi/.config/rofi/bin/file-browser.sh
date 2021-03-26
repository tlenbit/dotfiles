#!/usr/bin/bash

# go_to_prev="$@"
# prev_path_file=$HOME/.rofi-filebrowserdir

# if [[ -n $go_to_prev ]]; then
#   prev_path=$(cat $prev_path_file)
#   cd $prev_path
# fi

rofi \
  -show file-browser-extended \
  -modi file-browser-extended \
  -width "350px" \
  -theme-str "#prompt { padding: 0.2% 0.5% 0% -0.5%; enabled: true; }"

# echo $(pwd) > $prev_path_file