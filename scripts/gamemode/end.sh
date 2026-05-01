#!/bin/bash

hyprctl keyword decoration:blur:enabled true &
hyprctl keyword animations:enabled true &
qs -c noctalia-shell ipc call powerProfile disableNoctaliaPerformance &
qs -c noctalia-shell ipc call idleInhibitor disable &
scxctl stop &
