
# 🧩 Reid's Steam NTFS Linux Drive Fixer (for external drives or m.2 ssd)

Automatically mount and fix your **NTFS Steam game drive** on Linux so **Proton and Steam games Just Work™**.

This script remembers your game drive, updates `/etc/fstab` with the correct mount options, and ensures it's auto-mounted on every boot.  
✅ No more `.exe not executable`, `disk write errors`, or Proton refusing to launch games!

> 🧠 Made with 🛠️ by [@ryyReid](https://github.com/ryyReid)

---

## ✅ What It Fixes

- Steam can’t run `.exe` games from NTFS drives
- Proton/Wine games failing to start
- NTFS mounting with `noexec` (blocks game launches)
- Steam "disk write error" when installing games
- NTFS drives not mounting on boot

---

## 📂 What It Does

- ✅ GUI lets you select your NTFS game drive
- ✅ Detects UUID and mount path
- ✅ Automatically adds a working `/etc/fstab` entry:
  
  ```fstab
  UUID=XXXX-XXXX  /your/mount/path  ntfs-3g  uid=1000,gid=1000,exec,auto,nofail  0  0
✅ Mounts the drive immediately

✅ Installs a copy of the script to ~/.local/bin

✅ Creates autostart .desktop entry

✅ Optionally launches Steam when done

🧰 Requirements
Linux (Mint, Ubuntu, Pop!_OS, etc.)

Steam installed

ntfs-3g (usually pre-installed)

zenity for GUI (auto-installs if missing)

## 🚀 How to Use
Clone the repo:

               
                         
                              
                                  git clone https://github.com/ryyReid/steam-ntfs-drive-fixer.git
 cd steam-ntfs-drive-fixer
 Make the script executable:

    
         
          
                chmod +x steam_drive_setup.sh
 Run the setup:

  bash
       Copy
            Edit
./steam_drive_setup.sh
Follow the GUI prompts:

Pick your NTFS Steam drive

Confirm mount path and UUID

Script updates fstab, mounts the drive, and sets up autostart

🔁 Auto-Mount Every Boot
Yes — it creates this autostart file:

bash
Copy
Edit
~/.config/autostart/steam_drive_mounter.desktop
Which runs this every login:

bash
Copy
Edit
~/.local/bin/steam_drive_mounter.sh
💻 Example /etc/fstab Entry Added
fstab
Copy
Edit
UUID=XXXX-XXXX  /media/reid/SteamDrive  ntfs-3g  uid=1000,gid=1000,exec,auto,nofail  0  0
🛑 Notes
❌ Does not erase or reformat your drive

🔁 You can re-run the script anytime to reconfigure

✅ Works with any NTFS game drive, including for Heroic and Lutris

📄 License
MIT License
© 2025 @ryyReid

---

Let me know if you want a  `.deb` later!
