#!/bin/bash -e
# 

arpVar=$(arp -a) 
printf "%s\n" "$arpVar" > ./output/arp.txt

