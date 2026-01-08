#!/bin/bash

sleep 5
pkill blueman-applet

declare -i i=0
while [ $i -le 5 ]; do
	kill $(pidof blueman)
	sleep 5
	i+=1
done
