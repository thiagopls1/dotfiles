#!/bin/bash

hyprctl keyword decoration:blur:enabled false &
hyprctl keyword animations:enabled false &
qs -c noctalia-shell ipc call powerProfile enableNoctaliaPerformance &
qs -c noctalia-shell ipc call idleInhibitor enable &
scxctl start --sched lavd --mode gaming &
