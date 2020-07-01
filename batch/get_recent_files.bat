@echo off

SETLOCAL ENABLEDELAYEDEXPANSION 
SETLOCAL ENABLEEXTENSIONS
SETLOCAL

REM Start of main execution
echo recentfiles.bat
REM Specify the command to execute
set outputVar="recentfilesOutput"
echo user,filename,size,datewritten,timewritten > .\batch\output\recentfiles.csv

REM Pass the values (command to be excuted & name of variable to store output in) to the function.
REM command isn't used in this implementation
call:setCmdOutput %command% %outputVar%
REM Optional, display the output for testing
REM %outputVar%

ENDLOCAL 

:setCmdOutput    
REM               -- Store the output of the command specified in param 1 in an array named by param 2.
REM               -- %~1: command to store output of
REM               -- %~2: variable to store command output in
    SETLOCAL ENABLEDELAYEDEXPANSION
    for /F "usebackq delims= tokens=*" %%f in (`dir /b /ad "C:\Documents and Settings"`) do (
        REM double quotes around %%f ensures we get the whole line and don't break on the first whitespace
        REM call:incrementCount "%%f"
        set user=%%f
        for /F "usebackq skip=4 tokens=1,2,3,4,5" %%G in (`dir /TW /a-d "C:\Documents and Settings\%%f\Recent"`) do (
                set size=%%J
                set size=!size:,=!
                echo !user!,%%K,!size!,%%G,%%H%%I >> .\batch\output\recentfiles.csv
        )
    )
GOTO:EOF
