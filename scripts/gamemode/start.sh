#!/bin/bash

hyprctl eval 'hl.config({ animations = { enabled = false } })' &
hyprctl eval 'hl.config({ decoration = { blur = { enabled = false } } })' &
qs -c noctalia-shell ipc call powerProfile enableNoctaliaPerformance &
qs -c noctalia-shell ipc call idleInhibitor enable &
scxctl start --sched lavd --mode gaming &
