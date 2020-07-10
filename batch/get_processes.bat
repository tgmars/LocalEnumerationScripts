@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

echo "processes.bat"
REM Process selection - wmic PROCESS WHERE "Name='Notepad.exe'" GET /FORMAT:LIST

wmic PROCESS GET ProcessId,ParentProcessId,Name,CommandLine,ExecutablePath,CreationDate,Status /FORMAT:CSV > .\batch\output\processes.csv

