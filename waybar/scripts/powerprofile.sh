#!/bin/bash

# Get current power profile
get_current_profile() {
  if command -v powerprofilesctl &>/dev/null; then
    powerprofilesctl get
  else
    echo "power-saver" # fallback
  fi
}

# Set power profile
set_profile() {
  case $1 in
  "power-saver")
    if command -v powerprofilesctl &>/dev/null; then
      powerprofilesctl set power-saver
    fi
    ;;
  "balanced")
    if command -v powerprofilesctl &>/dev/null; then
      powerprofilesctl set balanced
    fi
    ;;
  "performance")
    if command -v powerprofilesctl &>/dev/null; then
      powerprofilesctl set performance
    fi
    ;;
  esac
}

# Toggle between profiles
toggle_profile() {
  current=$(get_current_profile)
  case $current in
  "power-saver")
    set_profile "balanced"
    ;;
  "balanced")
    set_profile "performance"
    ;;
  "performance")
    set_profile "power-saver"
    ;;
  esac
}

# Display current profile with icon only
display_profile() {
  current=$(get_current_profile)
  case $current in
  "power-saver")
    echo "󰾆" # Battery/efficiency icon
    ;;
  "balanced")
    echo "󰾅" # Balanced icon
    ;;
  "performance")
    echo "󰓅" # Performance/rocket icon
    ;;
  esac
}

# Handle arguments
case $1 in
"toggle")
  toggle_profile
  display_profile
  ;;
"display" | *)
  display_profile
  ;;
esac
exit 0
