@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

REM STARTUP - Management of commands that run automatically when users log onto the computer system.
echo "startup.bat
wmic STARTUP GET Caption, Command, User, Location /FORMAT:CSV > .\batch\output\startup.csv