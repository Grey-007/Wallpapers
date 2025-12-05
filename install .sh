#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_SRC="$REPO_DIR/config"
GTK_SRC="$REPO_DIR/gtk"
WALL_SRC="$REPO_DIR/wallpapers"

echo ">>> Dotfiles repo: $REPO_DIR"

# ------------------------
# 1. Basic sanity checks
# ------------------------
if ! grep -qi "arch" /etc/os-release; then
  echo "This script is for Arch Linux only."
  exit 1
fi

if [[ $EUID -eq 0 ]]; then
  echo "Run this as your normal user, not root."
  exit 1
fi

# ------------------------
# 2. Core packages
# ------------------------
echo ">>> Installing core packages (pacman)..."
sudo pacman -Syu --needed --noconfirm \
  base-devel git \
  hyprland hyprlock hyprpaper \
  waybar wofi dunst kitty \
  thunar tumbler ffmpegthumbnailer gvfs gvfs-mtp gvfs-afc gvfs-smb \
  firefox \
  imv mpv amberol \
  grim slurp wl-clipboard \
  networkmanager network-manager-applet \
  bluez bluez-utils blueman \
  pipewire pipewire-pulse pipewire-alsa wireplumber \
  pavucontrol pamixer pulsemixer \
  polkit-gnome \
  xdg-desktop-portal xdg-desktop-portal-hyprland xdg-desktop-portal-gtk \
  ttf-iosevka-nerd ttf-fira-sans noto-fonts noto-fonts-emoji \
  kvantum qt5ct qt6ct \
  greetd greetd-tuigreet \
  nwg-look

echo ">>> Enabling core services..."
sudo systemctl enable --now NetworkManager.service
sudo systemctl enable --now bluetooth.service

# ------------------------
# 3. Install yay (AUR helper)
# ------------------------
if ! command -v yay >/dev/null 2>&1; then
  echo ">>> Installing yay..."
  tmpdir="$(mktemp -d)"
  git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
  (cd "$tmpdir/yay" && makepkg -si --noconfirm)
  rm -rf "$tmpdir"
else
  echo ">>> yay already installed."
fi

# ------------------------
# 4. AUR packages
# ------------------------
echo ">>> Installing AUR packages (yay)..."
yay -S --needed --noconfirm \
  graphite-gtk-theme \
  tela-icon-theme \
  bluetuith \
  grimblast-git

# ------------------------
# 5. Copy configs from repo → ~/.config
# ------------------------
echo ">>> Syncing configs into ~/.config ..."
mkdir -p "$HOME/.config"

for appdir in "$CONFIG_SRC"/*; do
  name="$(basename "$appdir")"
  [[ -d "$appdir" ]] || continue
  echo "  -> $name"
  rm -rf "$HOME/.config/$name"
  mkdir -p "$HOME/.config/$name"
  cp -r "$appdir/"* "$HOME/.config/$name/"
done

# GTK settings
if [[ -d "$GTK_SRC" ]]; then
  echo ">>> Applying GTK settings..."
  mkdir -p "$HOME/.config/gtk-3.0" "$HOME/.config/gtk-4.0"
  [[ -f "$GTK_SRC/gtk-3.0/settings.ini" ]] && cp "$GTK_SRC/gtk-3.0/settings.ini" "$HOME/.config/gtk-3.0/settings.ini"
  [[ -f "$GTK_SRC/gtk-4.0/settings.ini" ]] && cp "$GTK_SRC/gtk-4.0/settings.ini" "$HOME/.config/gtk-4.0/settings.ini"
fi

# ------------------------
# 6. Wallpapers + Screenshots
# ------------------------
echo ">>> Copying wallpapers..."
if [[ -d "$WALL_SRC" ]]; then
  mkdir -p "$HOME/.config/wallpapers"
  cp -r "$WALL_SRC"/* "$HOME/.config/wallpapers/"
fi
mkdir -p "$HOME/Pictures/Screenshots"

# ------------------------
# 7. Greetd / Tuigreet setup
# ------------------------
echo ">>> Configuring greetd (login screen)..."

# Disable any other display manager and remove generic symlink
sudo systemctl disable --now gdm lightdm sddm ly 2>/dev/null || true
sudo rm -f /etc/systemd/system/display-manager.service

sudo mkdir -p /etc/greetd
sudo tee /etc/greetd/config.toml >/dev/null << 'EOF'
[terminal]
vt = 1

[default_session]
command = "tuigreet --cmd Hyprland --time --remember --user-menu"
user = "greeter"
EOF

sudo systemctl enable --now greetd.service

# ------------------------
# 8. Environment tweaks
# ------------------------
echo ">>> Setting environment defaults..."
mkdir -p "$HOME/.config/environment.d"

cat > "$HOME/.config/environment.d/10-hypr.conf" << 'EOF'
MOZ_ENABLE_WAYLAND=1
QT_QPA_PLATFORMTHEME=qt5ct
EOF

# optional cursor / kvantum env can go into hypr configs if you want

echo ">>> Done!"
echo "Reboot, log in via tuigreet, and Hyprland should start with your rice."