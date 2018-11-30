#!/bin/bash
ID=$(xdpyinfo | grep focus | cut -f4 -d " ")
ParentPID=$(xprop -id $ID | grep -m 1 PID | cut -d " " -f 3)
PID=$(pgrep -P $ParentPID --list-name | grep "\(ba\|z\)sh" | cut -d " " -f 1)
if [ -e "/proc/$PID/cwd" ]
then
    urxvt -cd $(readlink /proc/$PID/cwd) &
else
    urxvt
fi
