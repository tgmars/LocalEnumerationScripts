#!/bin/bash -e

# Use last for each user

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
    sudo lastb $username 2>/dev/null | grep -v wtmp >> $failedlogins
done

awk -f last24hours.awk /var/log/auth.log 
