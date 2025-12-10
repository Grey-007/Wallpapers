#!/bin/bash

WALLDIR="$HOME/Wallpapers"
LIST="$WALLDIR/list.txt"
INDEX_FILE="$WALLDIR/.current_wall"

# No wallpapers? Exit
if [ ! -d "$WALLDIR" ]; then
    notify-send "Wallpaper" "Folder $WALLDIR does not exist"
    exit 1
fi

# (Re)generate list file if missing or empty
if [ ! -s "$LIST" ]; then
    ls "$WALLDIR"/*.{jpg,jpeg,png,webp} 2>/dev/null > "$LIST"
fi

mapfile -t WALLS < "$LIST"

if [ "${#WALLS[@]}" -eq 0 ]; then
    notify-send "Wallpaper" "No images found in $WALLDIR"
    exit 1
fi

# Current index
if [ ! -f "$INDEX_FILE" ]; then
    echo 0 > "$INDEX_FILE"
fi

INDEX=$(cat "$INDEX_FILE")
if ! [[ "$INDEX" =~ ^[0-9]+$ ]]; then
    INDEX=0
fi

NEXT=$(( (INDEX + 1) % ${#WALLS[@]} ))
WALL="${WALLS[$NEXT]}"

# Change this to your monitor names
MON1="eDP-1"
# MON2="HDMI-A-1"   # uncomment if you have second monitor

# Preload + apply
hyprctl hyprpaper preload "$WALL"
hyprctl hyprpaper wallpaper "$MON1,$WALL"
# hyprctl hyprpaper wallpaper "$MON2,$WALL"

# Save index
echo "$NEXT" > "$INDEX_FILE"

# Let Quickshell read which image we used (optional)
echo "$WALL" > /tmp/current_wallpaper_path
