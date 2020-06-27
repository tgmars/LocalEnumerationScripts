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

:: the first call to resetFields sets the variables for use later on.
:: call reset fields after each block of data is parsed.
:: IMPORTANT - modify the fields in resetFields for the headers of data that you're parsing
call:resetFields

:: Output headers to our csv
:: Ensure that these headers match fields as you've defined them in :resetFields
echo RecordName,RecordType,TTL,DataLength,Section,ARecord,PTRRecord,CNAMERecord > .\batch\output\dns.csv

:: Optional, display length of lines with content for testing
:: lenCmdOutput
call:splitStrings %outputVar% %lenCmdOutput% 
ENDLOCAL 

:setCmdOutput    
::               -- Store the output of the command specified in param 1 in an array named by param 2.
::               -- %~1: command to store output of
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

:getLength          
REM -- Gets array length
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
REM -- Custom logic for parsing the specific output of the command
    echo Splitting strings
    echo array to split is called: %~1
    echo length of array to split: %~2
    for /L %%n in (3 1 %~2) do (
        REM Save the current line to avoid formatting issues where we're referencing  !dnscache[%%n]! all throughout.
        REM Remove spaces while we're at it (using : =)     
        set currentline=!%~1[%%n]: =!

        set firstSevenChars=!currentline:~0,7!
        set "bodyvalue=nil"
        if "!firstSevenChars!" == "RecordN" ( 
            call:splitString !currentline! 
            if NOT "!bodyvalue!" == "!cnamerecord!" ( set "recordname=!bodyvalue!" )
        )
        if "!firstSevenChars!" == "DataLen" ( call:splitString !currentline! & set "datalength=!bodyvalue!")
        if "!firstSevenChars!" == "RecordT" ( call:splitString !currentline! & set "recordtype=!bodyvalue!")
        if "!firstSevenChars!" == "TimeToL" ( call:splitString !currentline! & set "timetolive=!bodyvalue!")
        if "!firstSevenChars!" == "Section" ( call:splitString !currentline! & set "section=!bodyvalue!")
        if "!firstSevenChars!" == "A(Host)" ( call:splitString !currentline! & set "arecord=!bodyvalue!")
        if "!firstSevenChars!" == "PTRReco" ( call:splitString !currentline! & set "ptrrecord=!bodyvalue!")
        if "!firstSevenChars!" == "CNAMERe" ( call:splitString !currentline! & set "cnamerecord=!bodyvalue!")
        :: If you hit a record name that is your CNAME, don't the
        :: If we hit a separator line in the dns output, dump our current info out to file & reset our fields
        if "!firstSevenChars!" == "-------" if NOT "!recordname!" == "nil" ( 
            echo !recordname!,!recordtype!,!timetolive!,!datalength!,!section!,!arecord!,!ptrrecord!,!cnamerecord! >> .\batch\output\dns.csv
            call:resetFields
        )
    )
GOTO:EOF

:splitString        
REM -- Returns the second half of a string split on param 2, in this case a colon.
::                  -- The result will be returned into a variable named bodyvalue.
::                  -- Usage:
::                  -- %~1 Value of line to split
::                  -- %~2 Character to split on
    REM echo string to split %~1
    REM echo string to split on %~2
    set "bodyvalue=!%~1!"
    echo ibrokesplit
    REM set firstSplit
GOTO:EOF

:resetFields        
REM -- Sets the specified variables to 'nil'. 
::                  -- Use this to intialise the variables used to store data parsed
::                  -- from command line outputs before they're written to file.
    set "recordname=nil"
    set "datalength=nil"
    set "recordtype=nil"
    set "timetolive=nil"
    set "section=nil"
    set "arecord=nil"
    set "ptrrecord=nil"
    set "cnamerecord=nil"
GOTO:EOF

REM Refs:
REM https://www.programming-books.io/essential/batch/functions-f516efa981d9481ca4253d271451381d