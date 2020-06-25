@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

echo "startup.bat
wmic STARTUP GET Caption, Command, User, Location /FORMAT:CSV > .\batch\output\startup.csv