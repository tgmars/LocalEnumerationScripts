#!/bin/bash -e

# ip neighbour

# a for all, u for udp, t for tcp and p for pid/program name
netstatVar=$(sudo netstat -autp)
printf "%s\n" "$netstatVar" | tee ./output/netconns.txt

routingTable=$(netstat -r)
printf "%s\n" "$routingTable" | tee ./output/routingtable.txt

interfaces=$(ip link show)
printf "%s\n" "$interfaces" | tee ./output/interfaces.txt
