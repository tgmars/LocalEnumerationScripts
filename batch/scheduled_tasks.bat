@echo off

REM Start of main execution
echo scheduled_tasks.bat
REM Specify the command to execute
schtasks /Query /V /FO:CSV > .\batch\output\schtasks.csv

REM Refs:
REM The Win32_ScheduledJob WMI class represents a job created with the AT command.
REM https://docs.microsoft.com/en-us/windows/win32/cimwin32prov/win32-scheduledjob

