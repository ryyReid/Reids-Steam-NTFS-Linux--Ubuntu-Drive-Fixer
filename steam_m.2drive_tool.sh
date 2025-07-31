#!/bin/bash

# ========== Check and install zenity if missing ==========
if ! command -v zenity &>/dev/null; then
    echo "🛠 Zenity not found. Installing..."
    sudo apt update
    sudo apt install -y zenity || {
        echo "❌ Failed to install zenity."
        exit 1
    }
fi

# ========== Ask for mount path ==========
MOUNT_PATH=$(zenity --file-selection --directory --title="Select your Steam games drive (NTFS)")
if [ -z "$MOUNT_PATH" ]; then
    zenity --error --text="No mount path selected. Exiting."
    exit 1
fi

# ========== Get UUID ==========
DEVICE=$(lsblk -no UUID,MOUNTPOINT | grep "$MOUNT_PATH" | awk '{print $1}')
if [ -z "$DEVICE" ]; then
    zenity --error --text="Could not find device mounted at $MOUNT_PATH"
    exit 1
fi

USER_ID=$(id -u)
GROUP_ID=$(id -g)

# ========== Apply Fix ==========
sudo mkdir -p "$MOUNT_PATH"

# Clean up fstab and re-add line
sudo sed -i "\|$MOUNT_PATH|d" /etc/fstab
echo "UUID=$DEVICE  $MOUNT_PATH  ntfs-3g  uid=$USER_ID,gid=$GROUP_ID,exec,auto,nofail  0  0" | sudo tee -a /etc/fstab

# Reload systemd and remount
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo umount "$MOUNT_PATH" 2>/dev/null
sudo mount -a
sudo mount -o remount,exec,uid=$USER_ID,gid=$GROUP_ID "$MOUNT_PATH"

# ========== Confirm Success ==========
if mount | grep -q "$MOUNT_PATH"; then
    zenity --info --text="✅ Drive mounted successfully at:\n$MOUNT_PATH"
else
    zenity --error --text="❌ Mount failed for:\n$MOUNT_PATH"
    exit 1
fi

# ========== Ask to Launch Steam ==========
zenity --question --text="Do you want to launch Steam now?" --ok-label="Yes" --cancel-label="No"
if [ $? -eq 0 ]; then
    steam &
    zenity --info --text="🚀 Steam launched!"
else
    zenity --info --text="🎮 Steam not launched."
fi

exit 0

