#!/bin/bash

hyprctl eval 'hl.config({ animations = { enabled = true } })' &
hyprctl eval 'hl.config({ blur = { enabled = true } })' &
qs -c noctalia-shell ipc call powerProfile disableNoctaliaPerformance &
qs -c noctalia-shell ipc call idleInhibitor disable &
scxctl stop &
