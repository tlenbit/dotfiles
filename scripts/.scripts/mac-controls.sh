#!/bin/bash

# device_name="MagicTrackpad di RiccardoTommasini"
device_name="Apple Inc. Magic Trackpad 2"

xinput set-prop "$device_name" "libinput Natural Scrolling Enabled" 1
xinput set-prop "$device_name" "libinput Tapping Enabled" 1
xinput set-prop "$device_name" "libinput Click Method Enabled" 0 1
xinput set-prop "$device_name" "libinput Middle Emulation Enabled" 1
xinput set-prop "$device_name" "libinput Tapping Button Mapping Enabled" 1 0
