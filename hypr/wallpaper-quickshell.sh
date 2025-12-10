#!/bin/bash

# 1) Change to next wallpaper
~/.config/hypr/wallpaper-next.sh

# Get chosen wallpaper path (optional)
WALL_PATH="$(cat /tmp/current_wallpaper_path 2>/dev/null)"

# 2) Start Quickshell overlay (non-blocking)
# Replace `quickshell` below with the actual binary if it's different
quickshell run "$HOME/.config/quickshell/wallpaper-fade.qml" "$WALL_PATH" &
