#!/bin/bash -e
# Enumerate named pipes based on the type of the file.

# Named pipes
find / -type p 2>/dev/null > ./output/namedpipes.txt

# Standard pipes
# Ref:
# https://serverfault.com/questions/48330/how-can-i-get-more-info-on-open-pipes-show-in-proc-in-linux
# Just grab LSOF output, can pivot off a PID and look at open sockets, pipes, etc from this output.
lsof > ./output/lsof.txt

# for pipeID in $(sudo ls -l /proc/*/fd/ | egrep "\/proc\/[0-9]+\/fd\/:" | awk -F"/" '{print $2}')
# do
#     ls -l /proc/*/fd/$FD | grep $PIPE_ID
# done