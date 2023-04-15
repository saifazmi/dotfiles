#!/usr/bin/env bash

source $HOME/.config/i3/lockscreen.sh
pkill -u $USER -USR1 dunst
playerctl pause && pkill -SIGRTMIN+10 i3blocks

i3lock -e -n -i "$tmpbg" \
    --insidecolor=#ffffff00         \
    --ringcolor=#c93636ff           \
    --linecolor=#ffffff00           \
    --separatorcolor=#ff980000      \
    \
    --veriftext=""                  \
    --insidevercolor=#ffffff00      \
    --ringvercolor=#2196f3ff        \
    \
    --wrongtext=""                  \
    --insidewrongcolor=#ffffff00    \
    --ringwrongcolor=#c93636ff      \
    \
    --keyhlcolor=#ff9800ff          \
    --bshlcolor=#101010ff           \
    \
    --indicator                     \
    --composite                     \

pkill -u $USER -USR2 dunst
rm "$tmpbg"
