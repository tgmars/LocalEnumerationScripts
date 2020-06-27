@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

echo "logon_history.bat"
cscript C:\WINDOWS\System32\eventquery.vbs /L security /FI "id eq 528" /FO csv
cscript C:\WINDOWS\System32\eventquery.vbs /L security /FI "id eq 680" /FO csv

REM auditpol /set /category:"Logon/Logoff" /success:enable /failure:enable


REM Refs:
REM https://www.itprotoday.com/programming-languages/eventquery 
REM https://docs.microsoft.com/en-us/previous-versions/orphan-topics/ws.10/cc772995(v=ws.10)
REM https://superuser.com/questions/1059822/change-audit-policy-through-the-registry