# 🔧 Steam NTFS Mount Fixer (GUI Tool)

Fix your Steam/NTFS issues with a simple graphical tool for Linux!

This script helps you mount an NTFS drive (like a Windows M.2 with your Steam library) with the right permissions so Steam on Linux can launch your games properly—perfect for dual-boot setups.

---

## ✅ Features

- 📂 GUI prompt to select your NTFS drive mount path (via Zenity)
- 🛠 Automatically updates `/etc/fstab` with proper `exec`, `symlink`, and `allow_other` flags
- 🔁 Optionally remounts the drive live
- 🚀 Can auto-launch Steam after fixing
- 📥 Installs `zenity` if it's not already installed

---

## 🧠 Why

Steam on Linux often fails to run games on NTFS drives mounted by default with restricted options. This tool makes it simple to fix that without having to edit `/etc/fstab` manually or fight with permissions.

---

## 📦 Requirements

- Linux distro (tested on Linux Mint)
- `zenity` (auto-installed by the script)
- `ntfs-3g`
- `sudo` access
- An NTFS drive shared with Windows (e.g., dual-boot Steam drive)

---

## 📂 Example Use Case

You're dual-booting Windows + Linux. Your Steam games are on an M.2 NTFS drive. On Linux, Steam won’t launch them unless:
- The mount point allows `exec`
- Symlinks are respected
- You mount with `ntfs-3g` using `allow_other`

This script does all of that automatically.

---

## ▶️ How to Run

```bash
chmod +x steam-ntfs-fixer.sh
./steam-ntfs-fixer.sh
🛡 Disclaimer
Use at your own risk. This script edits /etc/fstab and requires sudo. Always back up critical files.

📃 License
MIT

© 2025 @ryyReid
