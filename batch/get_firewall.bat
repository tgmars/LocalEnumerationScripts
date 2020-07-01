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
REM Optional, display the output for testing
REM %outputVar%

REM Establish a length/counter var for the number of lines of command output
set /a lenCmdOutput=0
SETLOCAL ENABLEDELAYEDEXPANSION 
call:getLength %outputVar% lenCmdOutput

REM the first call to resetFields sets the variables for use later on.
REM call reset fields after each block of data is parsed.
REM IMPORTANT - modify the fields in resetFields for the headers of data that you're parsing
call:resetFields

REM Output headers to our csv
REM Ensure that these headers match fields as you've defined them in :resetFields
echo key,subkey,value > .\batch\output\firewall.csv

REM Optional, display length of lines with content for testing
REM lenCmdOutput
call:splitStrings %outputVar% %lenCmdOutput% 
ENDLOCAL 

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

:splitStrings       
REM -- Custom logic for parsing the specific output of the command
    echo Splitting strings
    echo array to split is called: %~1
    echo length of array to split: %~2
    REM Skip the first 2 lines, in the ipconfig output they're not worth keeping
    for /L %%n in (0 1 %~2) do (
        REM Save the current line to avoid formatting issues where we're referencing  !dnscache[%%n]! all throughout.
        REM Remove spaces while we're at it (using : =)     
        set currentline=!%~1[%%n]: =!

        set firstSevenChars=!currentline:~0,7!
        set "bodyvalue=nil"

        if "!firstSevenChars!" == "HKEY_LO" ( 
            REM When we hit a new registry key, dump everything we've got out to a line in our output and reset, ready for parsing.
            if NOT "!key!" == "nil" ( 
                call:resetFields
            )
            set "key=!currentline!"
        )
        if NOT "!firstSevenChars!" == "HKEY_LO" ( call:splitString !currentline! & echo !key!,!subkey!,!value! >> .\batch\output\firewall.csv)
    )
GOTO:EOF

:splitString        
REM                  -- Returns the second half of a string split on param 2
REM                  -- The result will be returned into a variable named bodyvalue.
REM                  -- Usage:
REM                  -- %~1 Value of line to split
REM                  -- %~2 Character to split on
    REM echo string to split %~1
    REM echo string to split on %~2
    set tempvar=%~1
    set tempvar=!tempvar:"=!
    set tempvar=!tempvar:|=_!
    set "tempsubkey=nil"
    set "tempvalue=!tempvar:*REG_DWORD=!"
    set "tempvalue=!tempvalue:*REG_SZ=!"
    set "tempvalue=!tempvalue:*REG_MULTI_SZ=!"
    set "tempvalue=!tempvalue:*REG_EXPAND_SZ=!"
    REM set tempvalue="!tempvalue!"
    REM echo !tempvalue!

    if "!tempvalue!"=="!tempvalue:REG_BINARY=!" (
        REM Remove quotes from any of the values
        set "tempsubkey=!tempvar:REG_MULTI_SZ%tempvalue%=!"
        set "tempsubkey=!tempsubkey:REG_DWORD%tempvalue%=!"
        set "tempsubkey=!tempsubkey:REG_SZ%tempvalue%=!"
        set "tempsubkey=!tempsubkey:REG_EXPAND_SZ%tempvalue%=!"
    ) else (
        REM
    )
    set subkey=!tempsubkey!
    set value=!tempvalue!
GOTO:EOF

:resetFields        
REM                  -- Sets the specified variables to 'nil'. 
REM                  -- Use this to intialise the variables used to store data parsed
REM                  -- from command line outputs before they're written to file.
    set "key=nil"
    set "subkey=nil"
    set "value=nil"
GOTO:EOF
