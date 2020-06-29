@echo off
echo "--- os_version.bat ---"
wmic OS GET Version /FORMAT:CSV > .\batch\output\os_version.csv