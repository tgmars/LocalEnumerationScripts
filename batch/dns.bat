@echo off
SETLOCAL

echo dns.bat

:: Specify the command to execute
set command="ipconfig /displaydns"
set outputVar="dnsOutput"
:: Pass the values (command to be excuted & name of variable to store output in) to the function.
call:setCmdOutput %command% %outputVar%
:: Optional, display the output for testing
:: %outputVar%

:: Establish a length/counter var for the number of lines of command output
set /a lenCmdOutput=0
SETLOCAL ENABLEDELAYEDEXPANSION 
call:getLength %outputVar% lenCmdOutput
:: Optional, display length of lines with content for testing
:: lenCmdOutput
call:splitStrings %outputVar% %lenCmdOutput% 
ENDLOCAL 

:: Output headers to our csv
REM echo RecordName,RecordType,TTL,DataLength,Section,PTRRecord,ARecord,CNAMERecord > .\batch\output\dns.csv

:setCmdOutput    -- Store the output of the command specified in %~1 in an array named cmdOutput
::                 -- %~1: command to store output of
    SETLOCAL ENABLEDELAYEDEXPANSION
    set "count=0"
    for /F "usebackq delims= tokens=*" %%f in (`%~1`) do (
        :: double quotes around %%f ensures we get the whole line and don't break on the first whitespace
        REM call:incrementCount "%%f"
        set %~2[!count!]=%%f
        set /a count+=1
    )
    set "currentScope=1"
    :: Ref https://stackoverflow.com/questions/49041934/how-to-return-an-array-of-values-across-endlocal
    :: This works because the arrays are stored in environment varibles literaolly as cmdOutput[index]
    :: Thus to get all of our arrays we need to specify cmdOutput[ to ensure we've got the array entries.
    :: Specifying cmdOutput would work, but if we've got a standard cmdOutput variable then we get that too.
    for /F "delims=" %%a in ('set %~2') do (
        if defined currentScope ENDLOCAL
        set "%%a"
    )
GOTO:EOF

:getLength          -- Gets array length
::                  -- Usage:
::                  -- %~1 Name of array
::                  -- %~2 Output variable
::                  -- Example for how use the function and return the variable for further use 
::                          SETLOCAL ENABLEDELAYEDEXPANSION 
::                          call:getLength cmdOutput lenCmdOutput
::                          set lenCmdOutput
::                          ENDLOCAL 
::
::                  -- Note: The DEFINED conditional works just like EXIST except it takes an
::                      environment variable name and returns true if the environment variable
::                      is defined.
    set array.name=%~1
    set array.output=%~2
    if defined %array.name%[!%array.output%!] (
        REM echo %array.name%[!%array.output%!]
        set /a %array.output%+=1
        GOTO:getLength 
    ) 
GOTO:EOF

:splitStrings
    echo Splitting strings
    echo array to split is called: %~1
    echo length of array to split: %~2
    for /L %%n in (3 1 %~2) do (
        REM Save the current line to avoid formatting issues where we're referencing  !dnscache[%%n]! all throughout.
        REM Remove spaces while we're at it (using : =)     
        set currentline=!%~1[%%n]: =!

        set Header8=!currentline:~0,7!
        set "bodyvalue=nil"
        if "!Header8!" == "RecordN" ( call:splitString !bodyvalue! !currentline! : & set bodyvalue)
        if "!Header8!" == "DataLen" ( call:splitString !bodyvalue! !currentline! : & set bodyvalue)
        if "!Header8!" == "RecordT" ( call:splitString !bodyvalue! !currentline! : & set bodyvalue)
        if "!Header8!" == "TimeToL" ( call:splitString !bodyvalue! !currentline! : & set bodyvalue)
        if "!Header8!" == "Section" ( call:splitString !bodyvalue! !currentline! : & set bodyvalue)
        if "!Header8!" == "A(Host)" ( call:splitString !bodyvalue! !currentline! : & set bodyvalue)
        if "!Header8!" == "PTRReco" ( call:splitString !bodyvalue! !currentline! : & set bodyvalue)
        if "!Header8!" == "CNAMERe" ( call:splitString !bodyvalue! !currentline! : & set bodyvalue)

        REM set !bodyvalue!
        REM set "recordname=!currentline:RecordName=!"
        REM set "rnf=!recordname:*:=!"
        REM set "recordtype=!currentline:RecordType=!"
        REM set "ttl=!currentline:TimeToLive=!"
        REM set "section=!currentline:Section=!"        
        REM set "arecord=!currentline:A(Host)Record=!"            
        REM set "ptrrecord=!currentline:PTRRecord=!"            
        REM set "cnamerecord=!currentline:CNameRecord=!"            
        REM echo !rnf!


        REM Should produce: .......:your.data.here
        REM echo !content!
        REM set "header=!currentline:=!"
        REM echo !header!
        REM  Should produce: currentline-content = RecordName
    )
GOTO:EOF

:splitString
    REM echo string to split %~1
    REM echo string to split on %~2
    set "firstSplit=!%~2!"
    set "%~1=firstSplit"
    REM set firstSplit
GOTO:EOF

REM :splitStringSecond
REM     echo string to split second %~1
REM     echo string to split on second %~2
REM     set "secondSplit=!%~2!"
REM     set secondSplit
REM GOTO:EOF

REM Refs:
REM https://www.programming-books.io/essential/batch/functions-f516efa981d9481ca4253d271451381d