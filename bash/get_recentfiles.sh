#!/bin/bash -e
# Gets a list of file smodified in the last 1440 mins (24 hours), excluding those in /proc and /sys

recentfiles="./output/recentfiles.txt"

if [ -f $recentfiles ]; then
    rm $recentfiles
    touch $recentfiles
fi

for recentfile in $(sudo find / -not \( -path /proc -prune \) -not \( -path /sys -prune \) -mmin -1440 -type f 2>/dev/null)
do
    sudo ls -lhd $recentfile >> $recentfiles
done 