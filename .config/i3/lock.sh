#!/usr/bin/env bash

pkill -u $USER -USR1 dunst
i3lock -n -i ~/Pictures/lock.jpg -t \
    --ringcolor=ffffff7f --line-uses-inside \
    --ringvercolor=ffffffff --ringwrongcolor=ffffffff \
    --keyhlcolor=ff9800ff --bshlcolor=ff9800ff --separatorcolor=00000000 \
    --insidevercolor=ff9800ff --insidewrongcolor=d23c3dff \
    --veriftext="" --wrongtext="" \
    --clock --timestr="%H:%M"
pkill -u $USER -USR2 dunst
