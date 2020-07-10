#!/bin/bash -e
# 
# Dumps arp table to a file

arpVar=$(arp -a) 
printf "%s\n" "$arpVar" > ./output/arp.txt

