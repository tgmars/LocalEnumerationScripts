#!/bin/bash -e

# Use last for each user

printf "username,groups" > ./output/accounts.csv
for username in $(getent passwd | awk -F":" '{ print $1}') 
do
    sudo last $username | grep -v wtmp >> ./output/recentlogins.txt
    sudo lastb $username | grep -v wtmp >> ./output/badlogins.txt
done

awk -f last24hours.awk /var/log/auth.log 
