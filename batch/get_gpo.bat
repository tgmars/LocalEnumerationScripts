@echo off

SETLOCAL ENABLEDELAYEDEXPANSION

for /F "tokens=*" %%a in ('gpresult /v') do (
    echo %%a >> .\batch\output\gpresult.csv
)