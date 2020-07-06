#!/bin/bash -e
# 

# iptablesVar=$(iptables-save)
# printf "%s\n" "$iptablesVar"  | tee ./output/firewall.txt


# If the above command isn't working, this is a suitable alternative.
filterTable=$(sudo iptables --table filter --list -n -v) 
printf "FilterTable\n%s\n" "$filterTable"  > ./output/firewall.txt

natTable=$(sudo iptables --table nat --list -n -v) 
printf "NatTable\n%s\n" "$natTable"  >> ./output/firewall.txt

mangleTable=$(sudo iptables --table mangle --list -n -v) 
printf "MangleTable\n%s\n" "$mangleTable"  >> ./output/firewall.txt

rawTable=$(sudo iptables --table raw --list -n -v) 
printf "RawTable\n%s\n" "$rawTable"  >> ./output/firewall.txt

securityTable=$(sudo iptables --table security --list -n -v) 
printf "SecurityTable\n%s\n" "$securityTable"  >> ./output/firewall.txt





