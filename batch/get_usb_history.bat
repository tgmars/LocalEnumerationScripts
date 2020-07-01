

@echo off
SETLOCAL ENABLEDELAYEDEXPANSION 
SETLOCAL ENABLEEXTENSIONS

REM Start of main execution
echo usb_history.bat
REM Specify the command to execute
set command="reg query HKLM\SYSTEM\CurrentControlSet\Enum\USB /s"
set outputVar="usbOutput"



REM REM Pass the values (command to be excuted & name of variable to store output in) to the function.
REM call:setCmdOutput %command% %outputVar%
REM REM Optional, display the output for testing
REM REM %outputVar%

REM REM Establish a length/counter var for the number of lines of command output
REM set /a lenCmdOutput=0
REM SETLOCAL ENABLEDELAYEDEXPANSION 
REM call:getLength %outputVar% lenCmdOutput

REM REM the first call to resetFields sets the variables for use later on.
REM REM call reset fields after each block of data is parsed.
REM REM IMPORTANT - modify the fields in resetFields for the headers of data that you're parsing
REM call:resetFields

REM REM Output headers to our csv
REM REM Ensure that these headers match fields as you've defined them in :resetFields
REM echo key,subkey,value > .\batch\output\usb.csv

REM REM Optional, display length of lines with content for testing
REM REM lenCmdOutput
REM call:splitStrings %outputVar% %lenCmdOutput% 
REM ENDLOCAL 

REM :setCmdOutput    
REM REM               -- Store the output of the command specified in param 1 in an array named by param 2.
REM REM               -- %~1: command to store output of
REM REM               -- %~2: variable to store command output in
REM     SETLOCAL ENABLEDELAYEDEXPANSION
REM     set "count=0"
REM     for /F "usebackq delims= tokens=*" %%f in (`%~1`) do (
REM         REM double quotes around %%f ensures we get the whole line and don't break on the first whitespace
REM         REM call:incrementCount "%%f"
REM         set %~2[!count!]=%%f
REM         set /a count+=1
REM     )
REM     set "currentScope=1"
REM     REM Ref https://stackoverflow.com/questions/49041934/how-to-return-an-array-of-values-across-endlocal
REM     REM This works because the arrays are stored in environment varibles literaolly as cmdOutput[index]
REM     REM Thus to get all of our arrays we need to specify cmdOutput[ to ensure we've got the array entries.
REM     REM Specifying cmdOutput would work, but if we've got a standard cmdOutput variable then we get that too.
REM     for /F "delims=" %%a in ('set %~2') do (
REM         if defined currentScope ENDLOCAL
REM         set "%%a"
REM     )
REM GOTO:EOF

REM :getLength          
REM REM -- Gets array length
REM REM                  -- Usage:
REM REM                  -- %~1 Name of array
REM REM                  -- %~2 Output variable
REM REM                  -- Example for how use the function and return the variable for further use 
REM REM                          SETLOCAL ENABLEDELAYEDEXPANSION 
REM REM                          call:getLength cmdOutput lenCmdOutput
REM REM                          set lenCmdOutput
REM REM                          ENDLOCAL 
REM REM
REM REM                  -- Note: The DEFINED conditional works just like EXIST except it takes an
REM REM                      environment variable name and returns true if the environment variable
REM REM                      is defined.
REM     set array.name=%~1
REM     set array.output=%~2
REM     if defined %array.name%[!%array.output%!] (
REM         REM echo %array.name%[!%array.output%!]
REM         set /a %array.output%+=1
REM         GOTO:getLength 
REM     ) 
REM GOTO:EOF

REM :splitStrings       
REM REM -- Custom logic for parsing the specific output of the command
REM     echo Splitting strings
REM     echo array to split is called: %~1
REM     echo length of array to split: %~2
REM     REM Skip the first 2 lines, in the ipconfig output they're not worth keeping
REM     for /L %%n in (0 1 %~2) do (
REM         REM Save the current line to avoid formatting issues where we're referencing  !dnscache[%%n]! all throughout.
REM         REM Remove spaces while we're at it (using : =)     
REM         set currentline=!%~1[%%n]: =!

REM         set firstSevenChars=!currentline:~0,7!
REM         set "bodyvalue=nil"

REM         if "!firstSevenChars!" == "HKEY_LO" ( 
REM             REM When we hit a new registry key, dump everything we've got out to a line in our output and reset, ready for parsing.
REM             if NOT "!key!" == "nil" ( 
REM                 call:resetFields
REM             )
REM             set "key=!currentline!"
REM         )
REM         if NOT "!firstSevenChars!" == "HKEY_LO" ( call:splitString !currentline! & echo !key!,!subkey!,!value! >> .\batch\output\usb.csv)
REM     )
REM GOTO:EOF

REM :splitString        
REM REM                  -- Returns the second half of a string split on param 2, in this case a colon.
REM REM                  -- The result will be returned into a variable named bodyvalue.
REM REM                  -- Usage:
REM REM                  -- %~1 Value of line to split
REM REM                  -- %~2 Character to split on
REM     REM echo string to split %~1
REM     REM echo string to split on %~2
REM     set tempvar=%~1
REM     set tempvar=!tempvar:"=!
REM     set "tempsubkey=nil"
REM     set "tempvalue=!tempvar:*REG_DWORD=!"
REM     set "tempvalue=!tempvalue:*REG_SZ=!"
REM     set "tempvalue=!tempvalue:*REG_MULTI_SZ=!"
REM     set "tempvalue=!tempvalue:*REG_EXPAND_SZ=!"

REM     if "!tempvalue!"=="!tempvalue:REG_BINARY=!" (
REM         REM Remove quotes from any of the values
REM         set "tempsubkey=!tempvar:REG_MULTI_SZ%tempvalue%=!"
REM         set "tempsubkey=!tempsubkey:REG_DWORD%tempvalue%=!"
REM         set "tempsubkey=!tempsubkey:REG_SZ%tempvalue%=!"
REM         set "tempsubkey=!tempsubkey:REG_EXPAND_SZ%tempvalue%=!"
REM     ) else (
REM         REM
REM     )
REM     set subkey=!tempsubkey!
REM     set value=!tempvalue!
REM GOTO:EOF

REM :resetFields        
REM REM                  -- Sets the specified variables to 'nil'. 
REM REM                  -- Use this to intialise the variables used to store data parsed
REM REM                  -- from command line outputs before they're written to file.
REM     set "key=nil"
REM     set "subkey=nil"
REM     set "value=nil"
REM GOTO:EOF