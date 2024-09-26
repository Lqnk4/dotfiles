#!/bin/sh
#
# ~/.xinitrc
xrandr --output HDMI-2 --primary --mode 1920x1080

exec ~/.local/bin/startdwm.sh
#exec i3
