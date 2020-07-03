#!/bin/bash -e

rm ./output/cron.txt 2>/dev/null
touch ./output/cron.txt

IFS=$'\n'
for uname in $(getent passwd | awk -F":" '{ print $1}') 
do
    for cronentry in $(sudo crontab -u $uname -l 2>/dev/null) 
    do 
        printf "%s\n%s\n" $uname $cronentry >> ./output/cron.txt
    done
done

contentsCrontab=$(cat /etc/crontab)
printf "%s\n%s" "crontab" $contentsCrontab >> ./output/cron.txt
