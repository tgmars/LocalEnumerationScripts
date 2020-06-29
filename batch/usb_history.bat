@echo off

SETLOCAL ENABLEDELAYEDEXPANSION 

echo "usb_history.bat"
REM echo displayname,installdate,publisher  > .\batch\output\software.csv
REM reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s | findstr /B ".*DisplayName .*InstallDate .*Publisher" >> .\batch\output\software.csv
REM reg query "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" /s | findstr /B ".*DisplayName .*InstallDate .*Publisher" >> .\batch\output\software.csv
set "regOutput="""
set "currentRegKey="""
set "outputFile=.\batch\output\usb.csv"
echo key,param,value > !outputFile!

call:setAllRegKeyValuesToStruct HKLM\SYSTEM\CurrentControlSet\Enum\USBSTOR 

ENDLOCAL

:setAllRegKeyValuesToStruct
    REM The skip here might cause issues with reg on XP - keep an eye out for it.Will probably need skip=4 on XP.
    REM Should try to split on PCRE - REG_[A-Z]+\s
    for /f "tokens=1,2,* skip=1 delims= " %%A in ('reg query %~1 /s') do (
            set bodyline=%%A
            set firstSevenChars=!bodyline:~0,7!
            REM set firstSevenChars

            if "!firstSevenChars!" == "HKEY_LO" ( 
                set "currentRegKey=!bodyline!"
            )
            REM Put subkeys that you want to ignore in here (typically because they've used a space in the subkey name)
            REM The inno installer does this. Need the REM in the following block to ensure that the script still executes, can't have
            REM an empty if statement. 
            if "!firstSevenChars!" == "Inno" ( REM
            ) else (
                set regOutput.!currentRegKey!.%%A=%%C
            )
    )
    call:writeStructToCSV !outputfile!
GOTO:EOF

:writeStructToCSV
    set "varattr=regOutput"
    FOR /F "usebackq tokens=1,2,3,4 delims=.=" %%a IN (`set`) DO if "%%a"=="%varattr%" (
        if NOT %%b == "" ( echo %%b,%%c,%%d >> %~1 )
    )
GOTO:EOF

ENDLOCAL


