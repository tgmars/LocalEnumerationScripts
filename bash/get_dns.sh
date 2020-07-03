#!/bin/bash -e
# Systemd has a cache, but not on ubuntu10
# Closest to DNS client cache is showing /etc/hosts for now

hostsVar=$(cat /etc/hosts)
printf "%s\n" "$hostsVar" > ./output/dns.txt