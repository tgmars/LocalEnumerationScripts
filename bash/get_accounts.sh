#!/bin/bash -e
#
# Refs:

# Alternative just cat /etc/passwd
printf "username,groups\n" > ./output/accounts.csv
for username in $(getent passwd | awk -F":" '{ print $1}') 
do
    sudo groups $username | sed -e "s/:/,/g" >> ./output/accounts.csv
done

