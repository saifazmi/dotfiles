#!/usr/bin/env bash

source $HOME/.config/i3/lockscreen.sh
i3lock -e -i "$tmpbg" \
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
    
rm "$tmpbg" &&
sleep 1 &&
systemctl suspend