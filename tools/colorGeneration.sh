#!/bin/bash

IMAGE=$1
COLORS=$(convert "$IMAGE" -resize 10x10 -format "%[hex:u.p{0,0}]\n" info:)

# Set the wallpaper
swww img "$IMAGE"

# Export dominant colors
count=0
for color in $COLORS; do
    export COLOR_$count="#$color"
    echo "COLOR_$count=#${color}"
    ((count++))
done
