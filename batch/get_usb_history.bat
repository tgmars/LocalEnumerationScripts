

@echo off
SETLOCAL ENABLEDELAYEDEXPANSION 
SETLOCAL ENABLEEXTENSIONS

REM Start of main execution
echo usb_history.bat > .\batch\output\usb.txt
REM Specify the command to execute
REM This should be modified to iterate through each controlset001-0xx to parse details from each profile
set command="reg query HKLM\SYSTEM\CurrentControlSet\Enum\USB /s"
set outputVar="usbOutput"

REM Pass the values (command to be excuted & name of variable to store output in) to the function.
call:setCmdOutput %command% %outputVar%

set command="reg query HKLM\SYSTEM\CurrentControlSet\Enum\USBSTOR /s"
set outputVar="usbStorOutput"

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
        echo %%f >> .\batch\output\usb.txt
    )
GOTO:EOF
