#!/bin/bash

# --- Configuration ---
# Set the package manager command for Arch Linux
INSTALL_CMD="sudo pacman -S --noconfirm --needed"
UNINSTALL_CMD="sudo pacman -Rns --noconfirm"
UPDATE_CMD="sudo pacman -Syu --noconfirm"

# Packages to be installed for the Hyprland setup
hypr_package=(
  bc
  cliphist
  curl
  grim
  gvfs
  gvfs-mtp
  hyprpolkitagent
  imagemagick
  inxi
  jq
  kitty
  kvantum
  libspng
  nano
  network-manager-applet
  pamixer
  pavucontrol
  playerctl
  python-requests
  python-pyquery
  qt5ct
  qt6ct
  qt6-svg
  rofi
  slurp
  swappy
  swaync
  swww
  unzip
  wallust
  waybar
  wget
  wl-clipboard
  wlogout
  xdg-user-dirs
  xdg-utils
  yad
)

# Optional or supplementary packages
hypr_package_2=(
  brightnessctl
  btop
  cava
  loupe
  fastfetch
  gnome-system-monitor
  mousepad
  mpv
  mpv-mpris
  nvtop
  nwg-look
  nwg-displays
  pacman-contrib
  qalculate-gtk
  yt-dlp
)

# Packages to uninstall (conflicting or replacements)
uninstall=(
  aylurs-gtk-shell
  dunst
  cachyos-hyprland-settings
  mako
  rofi-lbonn-wayland
  rofi-lbonn-wayland-git
  wallust-git
)
# 'rofi' is in the uninstall list, but also in hypr_package. 
# It's removed from 'uninstall' here to allow the desired version from 'hypr_package' to be installed/kept.

# --- Helper Functions ---

# Function to check if a command exists (to determine package manager)
command_exists () {
  command -v "$1" >/dev/null 2>&1
}

# --- Main Script Execution ---

echo "🚀 Starting Hyprland Package Installation Script..."

# Check for pacman and root privileges (sudo)
if ! command_exists "pacman"; then
  echo "❌ Error: 'pacman' command not found. This script is designed for Arch Linux/derivatives."
  exit 1
fi

if [[ "$EUID" -eq 0 ]]; then
    echo "⚠️  Warning: Running as root. It's generally better to run this script using 'sudo ./scriptname.sh'."
fi

# --- 1. System Update ---
echo "---"
echo "🔄 Updating the system package list and installed packages..."
$UPDATE_CMD
if [ $? -ne 0 ]; then
    echo "❌ System update failed. Please resolve the issue and run the script again."
    exit 1
fi

# --- 2. Uninstallation of Conflicting Packages ---
echo "---"
echo "🗑️  Checking for and removing conflicting packages..."

# Convert the array to a space-separated string for the uninstall command
PACKAGES_TO_UNINSTALL="${uninstall[*]}"

if [ -n "$PACKAGES_TO_UNINSTALL" ]; then
    echo "Attempting to uninstall: $PACKAGES_TO_UNINSTALL"
    $UNINSTALL_CMD $PACKAGES_TO_UNINSTALL
    if [ $? -ne 0 ]; then
        echo "⚠️  Note: Some packages might not have been installed or uninstallation failed. Continuing with installation."
    else
        echo "✅ Conflicting packages removed successfully (or were not present)."
    fi
else
    echo "✅ No conflicting packages specified for removal."
fi

# --- 3. Installation of Core Hyprland Packages ---
echo "---"
echo "📦 Installing core Hyprland packages (hypr_package)..."

# Convert the array to a space-separated string
CORE_PACKAGES="${hypr_package[*]}"

$INSTALL_CMD $CORE_PACKAGES

if [ $? -ne 0 ]; then
    echo "❌ Installation of core packages failed. Please check the error messages above."
    exit 1
else
    echo "✅ Core packages installed successfully."
fi

# --- 4. Installation of Optional Packages ---
echo "---"
echo "✨ Installing optional/supplementary packages (hypr_package_2)..."

# Convert the array to a space-separated string
OPTIONAL_PACKAGES="${hypr_package_2[*]}"

$INSTALL_CMD $OPTIONAL_PACKAGES

if [ $? -ne 0 ]; then
    echo "⚠️  Note: Installation of some optional packages might have failed. Continuing..."
else
    echo "✅ Optional packages installed successfully."
fi

# --- 5. Post-Installation Steps ---
echo "---"
echo "🛠️  Running post-installation setup for user directories..."
# Create essential user directories if they don't exist
xdg-user-dirs-update

echo "---"
echo "🎉 Installation Script Completed!"
echo "Next Steps: You should now proceed to clone/copy your dotfiles and configure Hyprland."
