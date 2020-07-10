#!/bin/bash -e
# 
# Retrieves rules for each of iptables' different chains.
# Grabbing everything so that we've got view of the hosts firewall
# Data is marked up with the name of the table using a @prop flag.
# If the host supports iptables-save, suggest using it instead! (code below)

# iptablesVar=$(iptables-save)
# printf "%s\n" "$iptablesVar"  | tee ./output/firewall.txt


# If the above command isn't working, this is a suitable alternative.
filterTable=$(sudo iptables --table filter --list -n -v) 
printf "@prop\ntype=FilterTable\n%s\n" "$filterTable"  > ./output/firewall.txt

natTable=$(sudo iptables --table nat --list -n -v) 
printf "@prop\ntype=NatTable\n%s\n" "$natTable"  >> ./output/firewall.txt

mangleTable=$(sudo iptables --table mangle --list -n -v) 
printf "@prop\ntype=MangleTable\n%s\n" "$mangleTable"  >> ./output/firewall.txt

rawTable=$(sudo iptables --table raw --list -n -v) 
printf "@prop\ntype=RawTable\n%s\n" "$rawTable"  >> ./output/firewall.txt

securityTable=$(sudo iptables --table security --list -n -v) 
printf "@prop\ntype=SecurityTable\n%s\n" "$securityTable"  >> ./output/firewall.txt





