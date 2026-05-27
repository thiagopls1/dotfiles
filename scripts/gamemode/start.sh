#!/bin/bash

hyprctl eval 'hl.config({ animations = { enabled = false } })' &
hyprctl eval 'hl.config({ blur = { enabled = false } })' &
qs -c noctalia-shell ipc call powerProfile disableNoctaliaPerformance &
qs -c noctalia-shell ipc call powerProfile enableNoctaliaPerformance &
qs -c noctalia-shell ipc call idleInhibitor enable &
scxctl start --sched lavd --mode gaming &
