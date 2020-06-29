@echo off

echo "interfaces"
wmic NICCONFIG GET /FORMAT:CSV > .\batch\output\interfaces.csv

echo "network connections - requires elevated privs"
echo proto,localaddr,remoteaddr,state,pid > .\batch\output\netconns.csv
REM skip 4 to remove the funk and their headers at the top of the netstat output
for /F "skip=4 tokens=1-5 delims= " %%A in ('netstat -nao') do echo %%A,%%B,%%C,%%D,%%E >> .\batch\output\netconns.csv
