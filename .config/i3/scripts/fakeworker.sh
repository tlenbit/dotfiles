#!/bin/bash

# Move mouse cursor
xdotool mousemove 10000 10000
# Move focus to a temporal workspace "temp"
i3-msg workspace temp
# Launch alacritty with custom title and initial command
alacritty -t fakeworker -e $HOME/sw/genact/genact-linux
# Tell i3 to fullscreen alacritty
i3-msg '[title="fakeworker"] fullscreen toggle'
# Disable touchpad
# synclient TouchpadOff=1

# Not used commands
# i3-msg '[title="fakeworker"] focus'
# i3-msg '[title="fakeworker"] move container to workspace temp'
