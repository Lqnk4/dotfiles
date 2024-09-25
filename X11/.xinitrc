#!/bin/sh
#
# ~/.xinitrc
xrandr --output HDMI-2 --primary --mode 1920x1080

exec ~/dwm_default/scripts/startdwm.sh
#exec i3
