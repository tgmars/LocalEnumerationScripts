#!/bin/bash -e
# 

# iptablesVar=$(iptables-save)
# printf "%s\n" "$iptablesVar"  | tee ./output/firewall.txt


# If the above command is working, this is a suitable alternative.
filterTable=$(sudo iptables --table filter --list -n -v) 
printf "FilterTable\n%s\n" "$filterTable"  | tee ./output/firewall.txt

natTable=$(sudo iptables --table nat --list -n -v) 
printf "NatTable\n%s\n" "$natTable"  | tee -a ./output/firewall.txt

mangleTable=$(sudo iptables --table mangle --list -n -v) 
printf "MangleTable\n%s\n" "$mangleTable"  | tee -a ./output/firewall.txt

rawTable=$(sudo iptables --table raw --list -n -v) 
printf "RawTable\n%s\n" "$rawTable"  | tee -a ./output/firewall.txt

securityTable=$(sudo iptables --table security --list -n -v) 
printf "SecurityTable\n%s\n" "$securityTable"  | tee -a ./output/firewall.txt





