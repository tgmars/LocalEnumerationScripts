@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

echo "software.bat"

REM Todo: delim each raw into a column of CSVs? Use wscript instead?
REM for /F "tokens=1,2,3 delims=	" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s ^| findstr /B ".*DisplayName .*InstallDate .Publisher"') do echo %%a %%c

reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s | findstr /B ".*DisplayName .*InstallDate .*Publisher" > .\batch\output\software.txt
reg query "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" /s | findstr /B ".*DisplayName .*InstallDate .*Publisher" >> .\batch\output\software.txt
