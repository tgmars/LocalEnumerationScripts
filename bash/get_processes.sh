#!/bin/bash -e
#
# Just dumping all the processes - can use -o flag to define custom formatting down the road

ps -ef > ./output/processes.txt
