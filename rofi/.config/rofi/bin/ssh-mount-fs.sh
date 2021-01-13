#!/usr/bin/env bash

list_hosts=`sed -rn 's/^\s*Host\s+(.*)\s*/\1/ip' $HOME/.ssh/config`

# mounted_hosts=$(ls $HOME/.mnt)
# list_available=`comm -23 <(echo "$list_hosts" | sort) <(echo "$mounted_hosts" | sort)`
# hostname=`echo "$list_available" | rofi -dmenu -i -p "Mount Host" -width 15 -lines 15 -matching regex`

hostname=`echo "$list_hosts" | rofi -dmenu -i -p "" -width 15 -lines 15 -matching regex`

if [ -z "$hostname" ];then
  notify-send -i "dialog-error" -u low "Can't mount"
  exit
fi

if ! grep -q "$hostname" $HOME/.ssh/config; then
  notify-send -u -i "dialog-error" low "No host match $hostname"
  exit
fi

user=`rofi -dmenu -i -p "" -hide-scrollbar -width -30`
user_hostname="$user@$hostname"

if [ -z "$user" ];then
  user_hostname="$hostname"
fi

# Test if the connection is possible
ssh -o PreferredAuthentications=publickey "$user_hostname" "echo ''" 2>&1;
if [ $? -ne 0 ]; then
  notify-send -u -i "dialog-error" low "Can't connect to $user_hostname"
  exit
fi

# Create a directory for mounting
mount_dir="$HOME/.mnt/$hostname/$user"
mkdir -p $mount_dir

sshfs "$user_hostname:/home/$user" $mount_dir
notify-send -u low -i "drive-optical" "$user_hostname successfully mounted!"