#!/bin/bash -e
# 
# Grab networking information with netstat.
# a for all, u for udp, t for tcp and p for pid/program name
# Need to be root to enumerate the process name associated with the pid
netstatVar=$(sudo netstat -autpn)
printf "%s\n" "$netstatVar" > ./output/netconns.txt

routingTable=$(netstat -r)
printf "%s\n" "$routingTable" > ./output/routingtable.txt

interfaces=$(ip link show)
printf "%s\n" "$interfaces" > ./output/interfaces.txt
