#!/bin/bash -e

# ip neighbour

# a for all, u for udp, t for tcp and p for pid/program name
netstatVar=$(sudo netstat -autpn)
printf "%s\n" "$netstatVar" > ./output/netconns.txt

routingTable=$(netstat -r)
printf "%s\n" "$routingTable" > ./output/routingtable.txt

interfaces=$(ip link show)
printf "%s\n" "$interfaces" > ./output/interfaces.txt
