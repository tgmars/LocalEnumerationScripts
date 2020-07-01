@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

REM auditpol /set /category:"Logon/Logoff" /success:enable /failure:enable

REM Start of main execution
echo logon_history.bat > .\batch\output\login_audit.csv

for /F "usebackq delims= tokens=*" %%f in (`cscript C:\WINDOWS\System32\eventquery.vbs /v /L security /FI "id eq 528 or id eq 529 or id eq 578 or id eq 576 " /FO csv ^| findstr /v "Microsoft" ^| findstr /v "Copyright"`) do (
    echo %%f >> .\batch\output\login_audit.csv
)



REM Refs:
REM https://www.itprotoday.com/programming-languages/eventquery 
REM https://docs.microsoft.com/en-us/previous-versions/orphan-topics/ws.10/cc772995(v=ws.10)
REM https://superuser.com/questions/1059822/change-audit-policy-through-the-registry