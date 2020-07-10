#!/bin/bash -e
# Enumerates two sources of data for logins.
# First is enumerating current/recent login sessions with last. Last presents active and recently
# closed sessions, lastb will show recent failed logins.
# Second is /var/log/auth.log - a copy of this file is created, with entries presented for the last
# 24 hours in output/auth.log__CurrentMon

# Grab auth.log
awk -f last24hours.awk /var/log/auth.log 

successfullogins="./output/successfullogins.txt"
failedlogins="./output/failedlogins.txt"

if [ -f $successfullogins ]; then
    rm $successfullogins
    touch $successfullogins
fi

if [ -f $failedlogins ]; then
    rm  $failedlogins
    touch $failedlogins
fi

for username in $(getent passwd | awk -F":" '{ print $1}') 
do
    sudo last $username 2>/dev/null | grep -v wtmp >> $successfullogins
    sudo lastb $username 2>/dev/null | grep -v btmp >> $failedlogins
done

