@echo off
echo "--- os_patchlevel.bat ---"
wmic QFE get HotfixID,InstalledBy,InstalledOn /FORMAT:CSV > .\batch\output\os_patchlevel.csv