@echo off

call:%~1

:GetRegValues Key Data Type -- returns all registry values of a given registry key
::                       -- Key   [in]  - registry key
::                       -- Stc   [out] - struct of registry values
:$created 20091123 :$changed 20091123 :$categories Registry, Array
:$source https://www.dostips.com
if "%~3" NEQ "" for /f "delims==" %%A in ('"set %~3. 2>NUL"') do set "%%A="
echo "%~1"
echo "%~2"
echo "%~3"%
for /f "tokens=1,2,* skip=4 delims= " %%A in ('reg query "%~2"') do (
    for /f "tokens=*" %%X in ("%%A") do ( rem this removes the leading tab
        set "%~3.%%X=%%C"
    )
)
EXIT /b

:setCmdOutput    
REM               -- Store the output of the command specified in param 1 in an array named by param 2.
REM               -- %~1: command to store output of
REM               -- %~2: variable to store command output in
    SETLOCAL ENABLEDELAYEDEXPANSION
    set "count=0"
    for /F "usebackq delims= tokens=*" %%f in (`%~1`) do (
        REM double quotes around %%f ensures we get the whole line and don't break on the first whitespace
        REM call:incrementCount "%%f"
        set %~2[!count!]=%%f
        set /a count+=1
    )
    set "currentScope=1"
    REM Ref https://stackoverflow.com/questions/49041934/how-to-return-an-array-of-values-across-endlocal
    REM This works because the arrays are stored in environment varibles literaolly as cmdOutput[index]
    REM Thus to get all of our arrays we need to specify cmdOutput[ to ensure we've got the array entries.
    REM Specifying cmdOutput would work, but if we've got a standard cmdOutput variable then we get that too.
    for /F "delims=" %%a in ('set %~2') do (
        if defined currentScope ENDLOCAL
        set "%%a"
    )
GOTO:EOF

:getLength          
REM -- Gets array length
REM                  -- Usage:
REM                  -- %~1 Name of array
REM                  -- %~2 Output variable
REM                  -- Example for how use the function and return the variable for further use 
REM                          SETLOCAL ENABLEDELAYEDEXPANSION 
REM                          call:getLength cmdOutput lenCmdOutput
REM                          set lenCmdOutput
REM                          ENDLOCAL 
REM
REM                  -- Note: The DEFINED conditional works just like EXIST except it takes an
REM                      environment variable name and returns true if the environment variable
REM                      is defined.
    set array.name=%~1
    set array.output=%~2
    if defined %array.name%[!%array.output%!] (
        REM echo %array.name%[!%array.output%!]
        set /a %array.output%+=1
        GOTO:getLength 
    ) 
GOTO:EOF