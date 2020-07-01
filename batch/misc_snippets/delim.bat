@echo off

REM set "str=   Record Name . . . . . : play.google.com"

REM set "string1=%str: Name =" & set "string2=%"
REM set "string2=%string2::=%"

REM echo "%string1%"
REM echo "%string2%"


REM @ECHO OFF
REM SETLOCAL enabledelayedexpansion
REM SET "string=string1 more words by string2 with spaces.txt"
REM SET "s2=%string:* by =%"
REM set "s1=!string: by %s2%=!"
REM set "s2=%s2:.txt=%"

REM set s1
REM set s2

@echo off
setlocal

set "MaxIndex=6"
call :CreateArrays
set TargetName
set TargetCPU
goto :EOF


:CreateArrays

setlocal EnableDelayedExpansion
for /L %%i in (1,1,%MaxIndex%) do (
   set /A TargetName[%%i]=!random!, TargetCpu[%%i]=!random!
)

rem Return the arrays to the calling scope
set "currentScope=1"
for /F "delims=" %%a in ('set TargetName[ ^& set TargetCPU[') do (
   if defined currentScope endlocal
   set "%%a"
)
exit /B