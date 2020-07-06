#!/bin/bash -e
# Runs history and grabs content of all users .bash_history files

cmdlinehistory="./output/command_history.txt"

printf "@prop\ntype=history\n" > $cmdlinehistory
history >> "$cmdlinehistory"

for uname in $(getent passwd | awk -F":" '{ print $1}') 
do
    if [ -d /home/$uname ]; then
        printf "@prop\nuser=$uname\ntype=.bash_history\n" >> $cmdlinehistory
        cat "/home/$uname/.bash_history" >> $cmdlinehistory
    fi

done