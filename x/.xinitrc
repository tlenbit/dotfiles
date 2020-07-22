# To list the devices and ids execute xinput list

xinput set-prop "Synaptics TM3289-002" "libinput Click Method Enabled" 0 1
xinput set-prop "Synaptics TM3289-002" "libinput Tapping Enabled" 1
xinput set-prop "Synaptics TM3289-002" "libinput Natural Scrolling Enabled" 1
xinput set-button-map 4 1 0 3
xinput set-button-map 12 1 0 3
xinput set-button-map 13 1 0 3

# MagicTrackpad (14)
xinput set-prop 14 "libinput Natural Scrolling Enabled" 1
xinput --set-prop 14 "libinput Tapping Enabled" 1
xinput set-prop 14 "libinput Click Method Enabled" 1 0

xset -b

export WINIT_HIDPI_FACTOR=1

udiskie -N &

exec dbus-launch i3
