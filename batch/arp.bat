@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

echo arp.bat

REM Prepopulate the !arptable! variable with the arp -a output`
set "count=0"
for /F "delims=" %%f in ('arp -a') do (
    set /a count+=1
    set "arptable[!count!]=%%f"
)

echo Interface,IPAddress,MACAddress,ARPType > .\batch\output\arp.csv

for /L %%n in (1 1 !count!) do (
    for /F "tokens=1,2" %%a in ('echo !arptable[%%n]! ^| findstr /R /C:"Interface:"') do (
        :: Set an interface address to populate each entry for this interface with appropriate data. 
        set interfaceaddr=%%~b
    )
    for /F "tokens=1,2,3" %%a in ('echo !arptable[%%n]! ^| findstr /B /C:"  " ^| findstr /V "Internet"') do (
        set ipaddr=%%~a
        set macaddr=%%~b
        set arptype=%%~c
        echo !interfaceaddr!,!ipaddr!,!macaddr!,!arptype! >> .\batch\output\arp.csv
    )
) 


REM Alternative method that runs arp for each search, a lot faster, but a lot grosser.
REM Duplicates a lot of info, needs fine tuning if it's going to be used.

REM echo Interface,IPAddress,MACAddress,ARPType > .\batch\output\arp.csv
REM for /F "tokens=1,2" %%a in ('arp -a ^| findstr /R /C:"Interface:"') do (
REM     set interfaceaddr=%%~b
REM     for /F "tokens=1,2,3" %%a in ('arp -a ^| findstr /B /C:"  " ^| findstr /V "Internet"') do (
REM         set ipaddr=%%~a
REM         set macaddr=%%~b
REM         set arptype=%%~c
REM         echo !interfaceaddr!,!ipaddr!,!macaddr!,!arptype! >> .\batch\output\arp.csv
REM     )
REM )


REM Refs:
REM http://blog.commandlinekungfu.com/2009/07/episode-51-leapin-lizards-arp-stuff.html

