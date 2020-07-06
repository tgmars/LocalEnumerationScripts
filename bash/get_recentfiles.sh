#!/bin/bash -e
# Gets a list of file smodified in the last 1440 mins (24 hours), excluding those in /proc and /sys
sudo find / -not \( -path /proc -prune \) -not \( -path /sys -prune \) -mmin -1440 2>/dev/null > ./output/recentfiles.txt