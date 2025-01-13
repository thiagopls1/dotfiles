#!/bin/bash

SELECTION="$(printf " Lock\n⏾ Suspend\n Log out\n Reboot\n󰐥 Shutdown" | fuzzel -a top-right --dmenu -l 5 -w 14 -p "")"

case $SELECTION in
	*"Lock")
		loginctl lock-session;;
	*"Suspend")
		systemctl suspend;;
	*"Log out")
		hyprctl dispatch exit;;
	*"Reboot")
		systemctl reboot;;
	*"Shutdown")
		systemctl poweroff;;
esac