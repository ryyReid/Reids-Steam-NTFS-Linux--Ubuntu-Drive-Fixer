
🧩 Reid's Steam NTFS Linux Drive Fixer
Automatically mount and fix your NTFS Steam game drive on Linux so Proton and Steam games Just Work™.

This tool remembers your game drive, fixes fstab with correct options (exec, uid, etc.), and ensures it's mounted properly on every boot. No more disk write errors, .exe not executable, or Proton refusing to run games from your Windows drive!

🧠 Designed and maintained by @ryyReid

✅ What It Fixes
Steam can't run .exe games from NTFS

Proton or Wine can't start games

NTFS mounts with noexec (prevents launching anything)

Steam fails to write to drive (disk write error)

NTFS drives not mounting on boot

📂 What It Does
Lets you pick your NTFS Steam drive (GUI)

Detects the drive's UUID and mount point

Automatically fixes /etc/fstab with:

bash
Copy
Edit
uid=$USER,gid=$GROUP,exec,auto,nofail
Mounts the drive immediately

Adds autostart script to ensure it mounts on every login

Optionally launches Steam for you

🧰 Requirements
Linux (Mint, Ubuntu, Pop!_OS, etc.)

Steam installed

NTFS-3G installed (usually already is)

Zenity (GUI prompt, auto-installs if missing)

🚀 How to Use
bash
Copy
Edit
chmod +x steam_drive_setup.sh
./steam_drive_setup.sh
This will:

Ask you to select the NTFS drive you use for Steam games

Add a correct entry to /etc/fstab

Mount it right away

Install a copy of the script in ~/.local/bin

Add it to your autostart folder

Ask if you want to launch Steam right now

🔁 Auto-Mount Every Boot
✅ Yes, it auto-runs on login by creating this:

bash
Copy
Edit
~/.config/autostart/steam_drive_mounter.desktop
It uses the permanent script location:

bash
Copy
Edit
~/.local/bin/steam_drive_mounter.sh
💻 Example fstab Entry Added
fstab
Copy
Edit
UUID=XXXX-XXXX  /media/reid/SteamDrive  ntfs-3g  uid=1000,gid=1000,exec,auto,nofail  0  0
🛑 Notes
This does not erase or reformat your drive

You can re-run the script anytime to reselect or update the mount

Works with any NTFS game drive used by Steam or Heroic

📄 License
MIT License
© 2025 @ryyReid
