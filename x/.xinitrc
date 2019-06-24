xinput set-prop "Synaptics TM3289-002" "libinput Click Method Enabled" 0 1
xinput set-prop "Synaptics TM3289-002" "libinput Tapping Enabled" 1
xinput set-prop "Synaptics TM3289-002" "libinput Natural Scrolling Enabled" 1
xinput set-button-map 4 1 0 3
xinput set-button-map 12 1 0 3
xinput set-button-map 13 1 0 3

xset -b

export WINIT_HIDPI_FACTOR=1

exec dbus-launch i3
