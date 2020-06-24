@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

echo "services.bat"
wmic SERVICE GET Name,DisplayName,Description,InstallDate,PathName,ProcessId,State, Status,SystemName,StartMode /FORMAT:CSV > .\batch\output\services.csv
