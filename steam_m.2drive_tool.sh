#!/bin/bash

# Reid's Steam NTFS Linux Drive Fixer
# Automatically mounts and fixes NTFS Steam drives on Linux

CONFIG="$HOME/.steam_mount_config"
AUTOSTART_DIR="$HOME/.config/autostart"
AUTOSTART_FILE="$AUTOSTART_DIR/steam_drive_mounter.desktop"
LOCAL_BIN="$HOME/.local/bin"
SCRIPT_NAME="steam_drive_mounter.sh"
SCRIPT_PATH="$LOCAL_BIN/$SCRIPT_NAME"

# ========== Install Zenity if missing ==========
if ! command -v zenity &>/dev/null; then
    echo "🛠 Installing Zenity..."
    sudo apt update && sudo apt install -y zenity || {
        echo "❌ Zenity installation failed."
        exit 1
    }
fi

# ========== First-time setup ==========
if [ ! -f "$CONFIG" ]; then
    MOUNT_PATH=$(zenity --file-selection --directory --title="Select your Steam NTFS Drive")
    if [ -z "$MOUNT_PATH" ]; then
        zenity --error --text="No path selected. Exiting."
        exit 1
    fi

    UUID=$(lsblk -no UUID,MOUNTPOINT | grep "$MOUNT_PATH" | awk '{print $1}')
    if [ -z "$UUID" ]; then
        zenity --error --text="Could not detect UUID for $MOUNT_PATH"
        exit 1
    fi

    echo "$UUID|$MOUNT_PATH" > "$CONFIG"
else
    UUID=$(cut -d'|' -f1 "$CONFIG")
    MOUNT_PATH=$(cut -d'|' -f2 "$CONFIG")
fi

USER_ID=$(id -u)
GROUP_ID=$(id -g)

# ========== Update /etc/fstab ==========
sudo mkdir -p "$MOUNT_PATH"
sudo sed -i "\|$MOUNT_PATH|d" /etc/fstab
echo "UUID=$UUID  $MOUNT_PATH  ntfs-3g  uid=$USER_ID,gid=$GROUP_ID,exec,auto,nofail  0  0" | sudo tee -a /etc/fstab

# ========== Mount the drive ==========
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo umount "$MOUNT_PATH" 2>/dev/null
sudo mount -a
sudo mount -o remount,exec,uid=$USER_ID,gid=$GROUP_ID "$MOUNT_PATH"

# ========== Confirm mount success ==========
if mount | grep -q "$MOUNT_PATH"; then
    zenity --info --text="✅ Drive mounted at:\n$MOUNT_PATH"
else
    zenity --error --text="❌ Mount failed at:\n$MOUNT_PATH"
    exit 1
fi

# ========== Setup autostart ==========
mkdir -p "$AUTOSTART_DIR"
mkdir -p "$LOCAL_BIN"
cp "$0" "$SCRIPT_PATH"
chmod +x "$SCRIPT_PATH"

cat <<EOF > "$AUTOSTART_FILE"
[Desktop Entry]
Type=Application
Exec=$SCRIPT_PATH
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Steam Drive Mounter
Comment=Automatically mounts NTFS Steam drive on login
EOF

zenity --info --text="✅ Setup complete. Your Steam NTFS drive will auto-mount on login."

# ========== Optional Steam launch ==========
zenity --question --text="Do you want to launch Steam now?" --ok-label="Yes" --cancel-label="No"
if [ $? -eq 0 ]; then
    steam &
fi

exit 0
