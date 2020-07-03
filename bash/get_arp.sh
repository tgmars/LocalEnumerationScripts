#!/bin/bash -e
# 

arpVar=$(arp -a) 
printf "%s\n" "$arpVar"  | tee ./output/arp.txt

