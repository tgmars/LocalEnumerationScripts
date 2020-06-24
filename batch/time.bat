@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

echo "--- timestamp.bat ---"

REM Parses the system local time and offset (in minutes). 
for /F "skip=2 tokens=1,2,3 delims=,+" %%a in ('wmic OS get LocalDateTime /FORMAT:CSV') do set timedatestamp=%%b&set offset=%%c

REM Output the timestamp and offset into a csv
echo Timedatestamp,Offsetmins > .\batch\output\time.csv
echo %timedatestamp%,%offset% >> .\batch\output\time.csv

