#!/usr/bin/env bash

DAY_WALL=$HOME/Pictures/wallpapers/samurai-champloo-temple_wallpaper.png
NIGHT_WALL=$HOME/Pictures/wallpapers/samurai-champloo-temple-inverted_wallpaper.png

function set_wall {
    feh --bg-fill "$1"
    ln -sf "$1" ~/Pictures/wall.png
}

function usage {
    echo "Usage: wallpaper [day | night]"
    exit
}

if [[ $# -eq 0 ]]; then
    usage
elif [[ "$1" == "day" ]]; then
    set_wall "$DAY_WALL"
elif [[ "$1" == "night" ]]; then
    set_wall "$NIGHT_WALL"
else
    usage
fi