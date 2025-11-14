# hypr-pkg-installer.sh
## 🚀 Hyprland Package Installer  Bash script (`hypr-pkg-installer.sh`) for Arch Linux. Automates the full dependency setup for this Hyprland config (Waybar, Kitty, Rofi, etc.). Features: Installs core packages (`pacman -S`), updates the system, and removes conflicting software. Essential for dotfile setup.
That's a great idea to provide clear instructions for your users!

Necessary steps for cloning and installing, ready to be placed in your README.md file.

🚀 Hyprland Package Installer (Quick Setup)

This guide shows you how to quickly clone this repository and run the installation script.

1. Clone the Repository

Open your terminal and use the git clone command to download the repository:

git clone https://github.com/ArNahidBD/Arch-hypr-pkg-installer.git

2. Navigate to the Directory

Move into the newly cloned folder:

cd hypr-pkg-installer.sh

3. Run the Installer

Make the script executable and then run it using sudo. This will update your system, remove conflicting packages, and install all Hyprland dependencies.

# Makes the script executable
chmod +x hypr-pkg-installer.sh

# Runs the installer (requires your sudo password)
./hypr-pkg-installer.sh

After the script finishes, you can proceed with copying your Hyprland dotfiles and configuration.
