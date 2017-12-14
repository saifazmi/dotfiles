#!/usr/bin/env bash

i3lock -i ~/Pictures/lock.png -t \
    --ringcolor=ffffff7f --line-uses-inside \
    --ringvercolor=ffffffff --ringwrongcolor=ffffffff \
    --keyhlcolor=ff9800ff --bshlcolor=ff9800ff --separatorcolor=00000000 \
    --insidevercolor=ff9800ff --insidewrongcolor=d23c3dff \
    --veriftext="" --wrongtext="" \
    --clock --timestr="%H:%M" && 
systemctl suspend
