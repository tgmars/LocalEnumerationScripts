#!/bin/bash -e
# Grab a copy of any auto-exec scripts and intiialisation files
# Only works for bash, if another shell is identified as in use, then just modify
# the script below to search for .sh* 

# Parse .bash* scripts in all user directorys
IFS=$'\n'
for uname in $(getent passwd | awk -F":" '{ print $1}') 
do
    if [ -d /home/$uname ]; then
        printf "@prop\nuser=%s\n" $uname > ./output/autoruns.txt
        for bashConfig in /home/$uname/.bash*
        do
            # exclude bash_history if it exists
            if [ "$bashConfig" == "/home/$uname/.bash_history"  ]; then
                continue;
            fi
            filename=$(basename "$bashConfig")
            printf "@prop\ntype=%s\n" $filename >> ./output/autoruns.txt 
            cat $bashConfig >> ./output/autoruns.txt
        done
    fi
done

# Parse profile file in /etc
printf "@prop\nuser=root\ntype=/etc/profile\n" >> ./output/autoruns.txt
cat /etc/profile >> ./output/autoruns.txt

# Parse profile files in /etc/profile.d/
if [ -f /etc/profile.d/* ]; then
    for profile in /etc/profile.d/*
    do
        printf "@prop\nuser=root\ntype=%sn" $profile >> ./output/autoruns.txt
        cat $profile >> ./output/autoruns.txt
    done
fi
# Parse /etc/rc.local
printf "@prop\nuser=root\ntype=/etc/rc.local\n" >> ./output/autoruns.txt
cat /etc/rc.local >> ./output/autoruns.txt