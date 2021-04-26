xset -b

export WINIT_HIDPI_FACTOR=1
export QT_AUTO_SCREEN_SCALE_FACTOR="0"
export XDG_CURRENT_DESKTOP=i3

udiskie -N &

exec dbus-launch i3
