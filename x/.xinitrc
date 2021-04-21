# To list the devices and ids execute xinput list

#xinput set-prop "Synaptics TM3289-002" "libinput Click Method Enabled" 0 1
#xinput set-prop "Synaptics TM3289-002" "libinput Tapping Enabled" 1
#xinput set-prop "Synaptics TM3289-002" "libinput Natural Scrolling Enabled" 1

#xinput set-button-map 4 1 0 3
#xinput set-button-map 12 1 0 3
#xinput set-button-map 13 1 0 3

xset -b

export WINIT_HIDPI_FACTOR=1
export QT_AUTO_SCREEN_SCALE_FACTOR="0"
export XDG_CURRENT_DESKTOP=i3

udiskie -N &

exec dbus-launch i3
