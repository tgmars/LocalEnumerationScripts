#!/bin/bash -e
# 
# Enumerates user cron entries and /etc/crontab

cronout="./output/cron.txt"

if [ -f $cronout ]; then 
    rm $cronout
    touch $cronout
fi

IFS=$'\n'
for uname in $(getent passwd | awk -F":" '{ print $1}') 
do
    for cronentry in $(sudo crontab -u $uname -l 2>/dev/null | grep -v '^#') 
    do 
        printf "@prop\nuser=%s\ntype=usercrontab\n%s\n" $uname $cronentry >> $cronout
    done
done

contentsCrontab=$(cat /etc/crontab | grep -v '^#')
printf "@prop\ntype=/etc/crontab\n%s\n" $contentsCrontab >> $cronout
