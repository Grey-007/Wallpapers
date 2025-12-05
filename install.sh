#!/usr/bin/env bash
set -e

### ---------------------------------------------------------
###  Matte Hyprland Rice Installer (Arch Linux)
###  - installs all deps
###  - installs yay
###  - sets up greetd + tuigreet
###  - copies all configs from ./config
### ---------------------------------------------------------

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_SRC="$REPO_DIR/config"
WALL_SRC="$REPO_DIR/wallpapers"
GTK_SRC="$REPO_DIR/gtk"

echo ">>> Using repo dir: $REPO_DIR"

# -----------------------
# 1. Sanity checks
# -----------------------
if ! grep -qi "arch" /etc/os-release; then
  echo "This script is meant for Arch Linux. Aborting."
  exit 1
fi

if [[ "$EUID" -eq 0 ]]; then
  echo "Run this script as your normal user, NOT as root."
  echo "It will use sudo when needed."
  exit 1
fi

if ! command -v sudo >/dev/null 2>&1; then
  echo "sudo is not installed. Install it and add your user to wheel group first."
  exit 1
fi

# -----------------------
# 2. Base system packages
# -----------------------
echo ">>> Installing base packages via pacman..."

sudo pacman -Syu --needed --noconfirm \
  base-devel git \
  hyprland hyprlock hyprpaper \
  waybar wofi dunst kitty \
  thunar tumbler ffmpegthumbnailer gvfs gvfs-mtp gvfs-afc gvfs-smb \
  firefox \
  imv mpv amberol \
  grim slurp wl-clipboard \
  networkmanager network-manager-applet nm-connection-editor \
  bluez bluez-utils blueman \
  pavucontrol pamixer pulsemixer \
  polkit-gnome \
  ttf-iosevka-nerd ttf-fira-sans noto-fonts noto-fonts-emoji \
  xdg-desktop-portal xdg-desktop-portal-hyprland xdg-desktop-portal-gtk \
  brightnessctl \
  kvantum \
  greetd greetd-tuigreet \
  nwg-look

echo ">>> Enabling core services (NetworkManager, Bluetooth, greetd)..."
sudo systemctl enable --now NetworkManager.service
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now greetd.service

# -----------------------
# 3. Install yay (AUR helper)
# -----------------------
if ! command -v yay >/dev/null 2>&1; then
  echo ">>> Installing yay AUR helper..."
  tmpdir="$(mktemp -d)"
  git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
  cd "$tmpdir/yay"
  makepkg -si --noconfirm
  cd "$REPO_DIR"
  rm -rf "$tmpdir"
else
  echo ">>> yay already installed, skipping."
fi

# -----------------------
# 4. AUR packages via yay
# -----------------------
echo ">>> Installing AUR packages via yay..."
yay -S --needed --noconfirm \
  bibata-cursor-translucent \
  graphite-gtk-theme \
  tela-icon-theme \
  bluetuith \
  grimblast-git

# -----------------------
# 5. Copy all configs from ./config to ~/.config
# -----------------------
echo ">>> Copying config files into ~/.config ..."

mkdir -p "$HOME/.config"

for appdir in "$CONFIG_SRC"/*; do
  name="$(basename "$appdir")"
  if [[ -d "$appdir" ]]; then
    echo "  -> $name"
    mkdir -p "$HOME/.config/$name"
    cp -r "$appdir/"* "$HOME/.config/$name/"
  fi
done

# -----------------------
# 6. GTK settings
# -----------------------
echo ">>> Setting up GTK settings..."

if [[ -d "$GTK_SRC" ]]; then
  mkdir -p "$HOME/.config/gtk-3.0" "$HOME/.config/gtk-4.0"

  if [[ -f "$GTK_SRC/gtk-3.0/settings.ini" ]]; then
    cp "$GTK_SRC/gtk-3.0/settings.ini" "$HOME/.config/gtk-3.0/settings.ini"
  fi
  if [[ -f "$GTK_SRC/gtk-4.0/settings.ini" ]]; then
    cp "$GTK_SRC/gtk-4.0/settings.ini" "$HOME/.config/gtk-4.0/settings.ini"
  fi
fi

# -----------------------
# 7. Wallpapers
# -----------------------
echo ">>> Setting up wallpapers..."

if [[ -d "$WALL_SRC" ]]; then
  mkdir -p "$HOME/.config/wallpapers"
  cp -r "$WALL_SRC"/* "$HOME/.config/wallpapers/"
else
  echo "  (no wallpapers/ directory in repo, skipping wallpaper copy)"
fi

mkdir -p "$HOME/Pictures/Screenshots"

# -----------------------
# 8. greetd + tuigreet config (matte theme)
# -----------------------
echo ">>> Writing /etc/greetd/config.toml ..."

sudo mkdir -p /etc/greetd

sudo tee /etc/greetd/config.toml >/dev/null << 'EOF'
[terminal]
vt = 1

[default_session]
command = "tuigreet \
  --time \
  --remember \
  --user-menu \
  --cmd Hyprland \
  --theme-background '#0a0a0a' \
  --theme-background-bright '#141414' \
  --theme-text '#e0e0e0' \
  --theme-prompt '#c01417' \
  --theme-input '#141414' \
  --theme-input-border '#5a0a0b'"
user = "greeter"
EOF

sudo systemctl enable --now greetd.service

# -----------------------
# 9. Environment helper file (optional)
# -----------------------
ENV_FILE="$HOME/.config/hypr/env.conf"
mkdir -p "$(dirname "$ENV_FILE")"

if ! grep -q "HYPRCURSOR_THEME" "$ENV_FILE" 2>/dev/null; then
  cat >> "$ENV_FILE" << 'EOF'

# Cursor + Qt + Firefox env (edit cursor name to match your theme)
env = HYPRCURSOR_THEME,Bibata Spirit
env = HYPRCURSOR_SIZE,24
env = XCURSOR_SIZE,24
env = QT_QPA_PLATFORMTHEME,kvantum
env = MOZ_ENABLE_WAYLAND,1
EOF
fi

# -----------------------
# 10. Firefox theming (user.js + userChrome.css)
# -----------------------
echo ">>> Trying to apply Firefox theme (if profile exists)..."

FF_DIR="$HOME/.mozilla/firefox"

if [[ -f "$FF_DIR/profiles.ini" ]]; then
  # Find default profile
  PROFILE_PATH="$(awk -F= '
    /^\[Profile[0-9]+\]/{p=0}
    $1=="Default" && $2=="1"{p=1}
    p && $1=="Path"{print $2; exit}
  ' "$FF_DIR/profiles.ini")"

  if [[ -n "$PROFILE_PATH" ]]; then
    echo "  -> Using Firefox profile: $PROFILE_PATH"
    mkdir -p "$FF_DIR/$PROFILE_PATH/chrome"

    # user.js + userChrome.css from repo
    if [[ -f "$CONFIG_SRC/firefox/user.js" ]]; then
      cp "$CONFIG_SRC/firefox/user.js" "$FF_DIR/$PROFILE_PATH/user.js"
    fi
    if [[ -f "$CONFIG_SRC/firefox/chrome/userChrome.css" ]]; then
      cp "$CONFIG_SRC/firefox/chrome/userChrome.css" "$FF_DIR/$PROFILE_PATH/chrome/userChrome.css"
    fi
  else
    echo "  (Default Firefox profile not found in profiles.ini; run Firefox once and re-run this part if needed.)"
  fi
else
  echo "  (No Firefox profile yet. Run Firefox once, then re-run install.sh or copy theme manually.)"
fi

echo ">>> All done!"
echo "Reboot, log in via tuigreet, and enjoy your matte Hyprland rice."
