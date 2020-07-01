@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

echo command_history.bat
set command="doskey /history"
echo command > .\batch\output\command_history.csv

for /F "usebackq delims= tokens=*" %%f in (`!command!`) do (
    echo %%f >> .\batch\output\command_history.csv
)