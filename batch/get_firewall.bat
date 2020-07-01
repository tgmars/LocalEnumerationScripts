@echo off

SETLOCAL ENABLEDELAYEDEXPANSION 
SETLOCAL ENABLEEXTENSIONS
SETLOCAL

REM Start of main execution
echo firewall.bat
REM Specify the command to execute
set command="reg query HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy /s"
set outputVar="firewallOutput"
REM Pass the values (command to be excuted & name of variable to store output in) to the function.
call:setCmdOutput %command% %outputVar%

:setCmdOutput    
REM               -- Store the output of the command specified in param 1 in an array named by param 2.
REM               -- %~1: command to store output of
REM               -- %~2: variable to store command output in
    SETLOCAL ENABLEDELAYEDEXPANSION
    set "count=0"
    for /F "usebackq skip=1 delims= tokens=*" %%f in (`%~1`) do (
        REM double quotes around %%f ensures we get the whole line and don't break on the first whitespace
        REM call:incrementCount "%%f"
        echo %%f >> .\batch\output\firewall.txt
    )
GOTO:EOF
